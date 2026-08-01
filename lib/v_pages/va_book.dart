import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/repositories/book_repositorie.dart';
import 'package:book_adder_2/utils/custom_app_bar.dart';
import 'package:book_adder_2/utils/page_template.dart';
import 'package:book_adder_2/utils/progress_dialog.dart';
import 'package:book_adder_2/utils/scrollbar_wraper.dart';
import 'package:book_adder_2/utils/section_wraper.dart';
import 'package:book_adder_2/v_widgets/multy_select.dart';
import 'package:book_adder_2/v_widgets/page_navigator.dart';
import 'package:book_adder_2/v_widgets/validate_date.dart';
import 'package:book_adder_2/vm_pages/book_manager_vm.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class BookV extends StatefulWidget {
  final Book book;
  final BookRepositorie bookRepo;
  final List<Author> authors;
  const BookV({
    super.key,
    required this.book,
    required this.bookRepo,
    required this.authors,
  });

  @override
  State<BookV> createState() => _BookVState();
}

class _BookVState extends State<BookV> {
  late final BookManagerVM vm;
  final scrollCon = ScrollController();

  @override
  void didChangeDependencies() async {
    print('didChangeDependencies');
    await vm.getInitData();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    vm = BookManagerVM(book: widget.book, bookRepo: widget.bookRepo);
    print('initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'ویرایش کتاب', onSave: onSaveBook),
      body: pageTemplate(
        context: context,
        controller: scrollCon,
        listenable: vm,
        future: vm.getInitData,
        page: (asyncSnapshot) {
          return SingleChildScrollView(
            padding: .only(top: 20, bottom: 100, right: 40),
            controller: scrollCon,
            child: Column(
              spacing: 20,
              children: [
                section1(),
                section2(),
                const SizedBox(height: 20),
                tableOfContentText(),
                const SizedBox(height: 20),
                pageView(context),
              ],
            ),
          );
        },
      ),
    );
  }

  bool checkErrors() {
    if (validateDate(vm.publishDateCon.text) == false) {
      final sn = SnackBar(
        width: 800,
        backgroundColor: Colors.red,
        content: Text('تاریخ درست وارد نشده است'),
        behavior: .floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(sn);
      return false;
    }
    return true;
  }

  void onSaveBook() {
    final noError = checkErrors();
    if (noError == false) return;

    final v = ValueNotifier(0.0);
    Future.delayed(Durations.short1, () {
      v.value = 0.5;
    });
    vm.onSave().then((e) {
      v.value = 1.0;
    });

    progressDialog(
      context: context,
      title: 'ذخیره کتاب',
      description: 'درحال ذخیره تغییرات.',
      progressValue: v,
    ).showAsSimpleDialog(context: context, barrierDismissible: false);
  }

  Widget authorInput() {
    return MultySelect(
      hint: 'نام مولف',
      items: {for (var e in widget.authors) '${e.firstName} ${e.lastName}': e},
      title: Text('مولف ها'),
      selecteds: vm.bookAuthors
          .map((a) => '${a.firstName} ${a.lastName}')
          .toSet(),
      onChange: (v) {
        vm.bookAuthors = v.cast<Author>();
      },
    );
  }

  Widget section1() {
    return sectionWraper(
      children: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: TextInput(
                lable: 'نام کتاب',
                textEditingController: vm.nameCon,
              ),
            ),
            Expanded(
              child: TextInput(
                lable: 'شناسه کتاب',
                textEditingController: vm.idCon,
                readOnly: true,
              ),
            ),
            Expanded(
              child: TextInput(
                lable: 'شناسه منبع',
                readOnly: true,
                textEditingController: vm.resourceCon,
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: TextInput(
                lable: 'ناشر',
                textEditingController: vm.publisherCon,
              ),
            ),
            Expanded(
              child: TextInput(
                lable: 'تاریخ انتشار',
                textEditingController: vm.publishDateCon,
              ),
            ),
            Expanded(
              child: TextInput(
                lable: 'شماره ویرایش',
                textEditingController: vm.editionCon,
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: TextInput(
                lable: 'ISBN',
                textEditingController: vm.isbnCon,
              ),
            ),
            Expanded(
              child: TextInput(
                lable: 'تعداد صفحات',
                textEditingController: TextEditingController(
                  text: vm.book.pageCount.toString(),
                ),
                readOnly: true,
              ),
            ),
            Expanded(
              child: TextInput(
                lable: 'ارجاعات',
                textEditingController: vm.referencesCon,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        authorInput(),
      ],
    );
  }

  Widget section2() {
    void onTocChanged(v) {
      vm.tocChanged = true;
    }

    return sectionWraper(
      children: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              flex: 1,
              child: FilledButton.icon(
                onPressed: () {
                  vm.onAddFile();
                },
                label: Text('افزودن فایل'),
                icon: Icon(Icons.file_open),
              ),
            ),
            Expanded(
              flex: 2,
              child: ValueListenableBuilder(
                valueListenable: vm.filePath,
                builder: (context, value, child) {
                  return Directionality(
                    textDirection: .ltr,
                    child: TagBox(
                      title: value ?? ' ',
                      color: Colors.black,
                      mainAxisAlignment: .center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              flex: 1,
              child: TextInput(
                lable: 'صفحه شروع فهرست مطالب',
                textEditingController: vm.tocStartCon,
                onChanged: onTocChanged,
              ),
            ),
            Expanded(
              child: TextInput(
                lable: 'صفحه پایان فهرست مطالب',
                textEditingController: vm.tocEndCon,
                onChanged: onTocChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget tableOfContentText() {
    return TextInput(
      lable: 'فهرست مطالب',
      minLines: 15,
      maxLines: 15,
      border: OutlineInputBorder(),
      textEditingController: vm.tableOfContentCon,
    );
  }

  Widget fullTextParagraphButtons() {
    return Row(children: [
        
      ],
    );
  }

  Widget bookFullText() {
    return FutureBuilder(
      future: vm.getFullText(),
      builder: (context, asyncSnapshot) {
        return TextInput(
          lable: 'متن کامل کتاب',
          minLines: 15,
          maxLines: 15,
          border: OutlineInputBorder(),
          readOnly: true,
          textEditingController: TextEditingController(text: vm.book.fullText),
        );
      },
    );
  }

  Widget pageView(BuildContext context) {
    void onSetPage(int v) {
      final r = vm.pageVm.onSetPage(v);
      if (r == false) {
        final sn = SnackBar(
          width: 800,
          backgroundColor: Colors.red,
          content: Text('شماره صفحه در بازه درست نیست'),
          behavior: .floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(sn);
      }
    }

    void onChangedPage(String v) {
      vm.pageVm.pageChanged = true;
    }

    return ListenableBuilder(
      listenable: vm.pageVm,
      builder: (context, child) {
        return FutureBuilder(
          future: vm.pageVm.getPage(vm.pageVm.currentPageNumber),
          builder: (context, page) {
            return Column(
              spacing: 10,
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Text(
                  'صفحه ${vm.pageVm.currentPageNumber} از ${vm.book.pageCount}',
                ),
                TextInput(
                  lable: 'متن صفحه',
                  minLines: 20,
                  maxLines: 20,
                  border: OutlineInputBorder(),
                  textEditingController: vm.pageVm.pageTextCon,
                  onChanged: onChangedPage,
                ),
                TextInput(
                  lable: 'پاورقی',
                  minLines: 7,
                  maxLines: 7,
                  border: OutlineInputBorder(),
                  textEditingController: vm.pageVm.pageFooterCon,
                  onChanged: onChangedPage,
                ),
                Center(
                  child: PageNavigator(
                    onSetPage: onSetPage,
                    pageNumber: vm.pageVm.currentPageNumber,
                    onNext: () {
                      vm.pageVm.onNextPage();
                    },
                    onPrevios: vm.pageVm.onPrePage,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
