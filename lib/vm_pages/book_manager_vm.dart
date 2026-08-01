import 'dart:convert';
import 'dart:io';

import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/book_page.dart';
import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/repositories/book_repositorie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BookManagerVM extends ChangeNotifier {
  Book book;
  late final BookPageManagerVM pageVm;
  final BookRepositorie bookRepo;

  List<Author> bookAuthors = [];
  bool tocChanged = false;
  late final filePath = ValueNotifier(book.filePath);
  late final TextEditingController nameCon;
  late final TextEditingController idCon;
  late final TextEditingController resourceCon;
  late final TextEditingController publisherCon;
  late final TextEditingController publishDateCon;
  late final TextEditingController authorCon;
  late final TextEditingController isbnCon;
  late final TextEditingController editionCon;
  late final TextEditingController referencesCon;
  late final TextEditingController tableOfContentCon;
  late final TextEditingController filePathCon;
  late final TextEditingController tocStartCon;
  late final TextEditingController tocEndCon;

  BookManagerVM({required this.book, required this.bookRepo}) {
    nameCon = TextEditingController(text: book.bookName);
    idCon = TextEditingController(text: book.bookId.toString());
    resourceCon = TextEditingController(text: book.resourceId.toString());
    publisherCon = TextEditingController(text: book.publisherName);
    publishDateCon = TextEditingController(text: book.publishDate);
    authorCon = TextEditingController();
    isbnCon = TextEditingController(text: book.isbn);
    editionCon = TextEditingController(text: book.edition.toString());
    referencesCon = TextEditingController(text: book.references);
    tableOfContentCon = TextEditingController(text: book.tableOfContents);
    filePathCon = TextEditingController(text: book.filePath);
    tocStartCon = TextEditingController();
    tocEndCon = TextEditingController();

    pageVm = BookPageManagerVM(book: book, bookRepo: bookRepo);
  }

  Future<bool> getInitData() async {
    bookAuthors = await bookRepo.getBookAuthors(book);
    book = await bookRepo.read(book);
    pageVm.book = book;
    filePath.value = book.filePath;
    tableOfContentCon.text = book.tableOfContents ?? '';
    setTextEditingControllers();

    print(book.isbn);
    return true;
  }

  void setTextEditingControllers() {
    nameCon.text = book.bookName ?? '';
    idCon.text = book.bookId.toString();
    resourceCon.text = book.resourceId.toString();
    publisherCon.text = book.publisherName ?? '';
    publishDateCon.text = book.publishDate ?? '';
    isbnCon.text = book.isbn ?? '';
    editionCon.text = book.edition.toString();
    referencesCon.text = book.references ?? '';
    tableOfContentCon.text = book.tableOfContents ?? '';
    filePathCon.text = book.filePath ?? '';
  }

  Future<bool> getFullText() async {
    book.fullText = await bookRepo.getBookFullText(book);
    return true;
  }

  Book newBook() {
    final newBook = Book();
    newBook
      ..bookId = book.bookId
      ..edition = int.tryParse(editionCon.text)
      ..bookName = nameCon.text
      ..publisherName = publisherCon.text
      ..publishDate = publishDateCon.text
      ..references = referencesCon.text
      ..tableOfContents = tableOfContentCon.text
      ..isbn = isbnCon.text
      ..filePath = filePath.value;
    return newBook;
  }

  Future<bool> onSave() async {
    await Future.delayed(Durations.short1);
    final nb = newBook();
    final tocStart = int.tryParse(tocStartCon.text) ?? 1;
    final tocEnd = int.tryParse(tocEndCon.text) ?? 1;

    final changedFile = await saveBookFile(
      newBook: nb,
      tocStart: tocStart,
      tocEnd: tocEnd,
    );
    // first add file-path to book table
    print('> ${nb.tableOfContents?.length}');
    await bookRepo.update(nb);
    if (changedFile || tocChanged) {
      print('extractBookFromServerFile');
      final r = await bookRepo.extractBookFromServerFile(
        filePath: nb.filePath!,
        bookId: nb.bookId!,
        tocStart: tocStart,
        tocEnd: tocEnd,
      );
      tocChanged = false;
    }
    await bookRepo.updateAuthors(bookAuthors, nb.bookId!);

    if (pageVm.pageChanged) {
      await pageVm.updatePage();
    }

    notifyListeners();
    return true;
  }

  Future<bool> saveBookFile({
    required Book newBook,
    int tocStart = 1,
    int tocEnd = 1,
  }) async {
    final changedFile = book.filePath != newBook.filePath;
    if (changedFile) {
      // add file to server
      if (book.filePath == null) {
        print('createFile');
        final r = await bookRepo.createFile(
          File(filePath.value!),
          dirPath: 'books_file',
        );
        newBook.filePath = r;
      } else {
        print('updateFile');
        bookRepo.updateFile(File(filePath.value!), book.filePath!);
        newBook.filePath = book.filePath;
      }
      return true;
    }
    return false;
  }

  void onAddFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: .custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      filePath.value = result.files.single.path!;
    } else {
      // User canceled the picker
    }
  }
}

class BookPageManagerVM extends ChangeNotifier {
  Book book;
  BookPage? page;
  bool pageChanged = false;
  int currentPageNumber = 1;

  late final TextEditingController pageTextCon;
  late final TextEditingController pageFooterCon;

  final BookRepositorie bookRepo;
  BookPageManagerVM({required this.book, required this.bookRepo}) {
    pageTextCon = TextEditingController(text: page?.pageText);
    pageFooterCon = TextEditingController(text: page?.footer);
  }
  void setTextEditingControllers() {
    pageTextCon.text = page?.pageText ?? '';
    pageFooterCon.text = page?.footer ?? '';
  }

  Future<BookPage> getPage(int pageNumber) async {
    page = await bookRepo.getPageByNumber(book.bookId!, pageNumber);
    pageChanged = false;
    print('2> ${page?.pageText}');
    setTextEditingControllers();
    return page!;
  }

  BookPage newPage() {
    final newPage = BookPage();
    newPage
      ..bookId = page?.bookId
      ..pageId = page?.pageId
      ..bookPageId = page?.bookPageId
      ..pageText = pageTextCon.text
      ..footer = pageFooterCon.text;
    return newPage;
  }

  Future updatePage() async {
    final np = newPage();
    print('1> ${np.pageText}');
    final r = await bookRepo.bookService.updatePage(np);
    notifyListeners();
    print(r);
    return r;
  }

  bool onSetPage(int pageNumber) {
    if (isNotValidPageNumber(pageNumber)) return false;
    currentPageNumber = pageNumber;
    notifyListeners();
    return true;
  }

  void onNextPage() {
    if (isNotValidPageNumber(currentPageNumber + 1)) return;
    currentPageNumber++;
    notifyListeners();
  }

  void onPrePage() {
    if (isNotValidPageNumber(currentPageNumber - 1)) return;
    currentPageNumber--;
    notifyListeners();
  }

  bool isNotValidPageNumber(int pn) => pn <= 0 || pn > (book.pageCount ?? 1);
}
