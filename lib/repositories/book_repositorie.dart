import 'dart:io';

import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/book_page.dart';
import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/repositories/repositorie.dart';
import 'package:book_adder_2/services/book_service.dart';
import 'package:book_adder_2/services/file_service.dart';
import 'package:dio/dio.dart';

class BookRepositorie implements Repositorie {
  final bookService = BookService();
  final fileService = FileService();

  Future<List<Book>> getBookList(
    Resource resource,
    int pageNumber,
    int pageSize,
  ) async {
    final r = await bookService.getBookList(resource, pageNumber, pageSize);
    return r;
  }

  Future<Book> read(covariant Book book) async {
    final r = await bookService.read(book);
    return Book.fromMap(r.data);
  }

  @override
  Future<bool> create(covariant Book book) async {
    final r = await bookService.create(book);
    return true;
  }

  @override
  Future<bool> delete(covariant Book book) async {
    final r = await bookService.delete(book);
    return true;
  }

  @override
  Future<bool> update(covariant Book book) async {
    final r = await bookService.update(book);
    return true;
  }

  //---------------------
  Future<bool> updateAuthors(List<Author> authors, int bookId) async {
    final r = await bookService.updateAuthors(authors, bookId);
    return true;
  }

  Future<List<Author>> getBookAuthors(Book book) async {
    final r = await bookService.getBookAuthors(book);
    return r;
  }

  Future<String> createFile(
    File file, {
    String dirPath = '',
    String contentType = Headers.jsonContentType,
    ProgressCallback? onSendProgress,
  }) async {
    final r = await fileService.createFile(
      file,
      dirPath: dirPath,
      contentType: contentType,
      onSendProgress: onSendProgress,
    );
    return r.data['url'];
  }

  Future<String> updateFile(
    File file,
    String filePath, {
    String contentType = 'application/octet-stream',
    ProgressCallback? onSendProgress,
  }) async {
    final r = await fileService.updateFile(
      file,
      filePath,
      contentType: contentType,
      onSendProgress: onSendProgress,
    );
    return filePath;
  }

  Future<Map> extractBookFromServerFile({
    String filePath = '',
    int bookId = 0,
    int tocStart = 1,
    int tocEnd = 1,
  }) async {
    final r = await bookService.extractBookFromServerFile(
      filePath: filePath,
      bookId: bookId,
      tocStart: tocStart,
      tocEnd: tocEnd,
    );
    return r;
  }

  Future<String> getBookFullText(Book book) async {
    final r = await bookService.getBookFullText(book);
    return r;
  }

  Future<BookPage> getPageByNumber(int bookId, int pageNumber) async {
    final r = await bookService.getPageByNumber(bookId, pageNumber);
    return BookPage.fromMap(r);
  }
}
