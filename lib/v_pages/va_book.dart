import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/repositories/book_repositorie.dart';
import 'package:book_adder_2/utils/custom_app_bar.dart';
import 'package:book_adder_2/utils/progress_dialog.dart';
import 'package:book_adder_2/utils/scrollbar_wraper.dart';
import 'package:book_adder_2/v_widgets/page_navigator.dart';
import 'package:book_adder_2/vm_pages/book_manager_vm.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class BookV extends StatefulWidget {
  final Book book;
  final BookRepositorie bookRepo;
  const BookV({super.key, required this.book, required this.bookRepo});

  @override
  State<BookV> createState() => _BookVState();
}

class _BookVState extends State<BookV> {
  late final BookManagerVM vm;
  final scrollCon = ScrollController();
  late final TextEditingController nameCon;
  late final TextEditingController idCon;
  late final TextEditingController resourceCon;
  late final TextEditingController publisherCon;
  late final TextEditingController publishDateCon;
  late final TextEditingController authorCon;
  late final TextEditingController isbnCon;
  late final TextEditingController editionCon;
  late final TextEditingController referencesCon;

  @override
  void initState() {
    vm = BookManagerVM(book: widget.book, bookRepo: widget.bookRepo);
    super.initState();
  }

  void initCon() {
    nameCon = TextEditingController();
    idCon = TextEditingController();
    resourceCon = TextEditingController();
    publisherCon = TextEditingController();
    publishDateCon = TextEditingController();
    authorCon = TextEditingController();
    isbnCon = TextEditingController();
    editionCon = TextEditingController();
    referencesCon = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'ویرایش کتاب', onSave: onSaveBook),
      body: Align(
        alignment: .topCenter,
        child: SizedBox(
          width: 1000,
          child: scrollBarWraper(
            context: context,
            controller: scrollCon,
            child: SingleChildScrollView(
              padding: .only(top: 20, bottom: 20, right: 40),
              controller: scrollCon,
              child: SimpleTable(
                spacing: 20,
                items: [
                  line1(),
                  line2(),
                  line3(),
                  [tableOfContentText()],
                  [bookFullText()],
                  addFileRow(),
                  [pageView()],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSaveBook() {
    final v = ValueNotifier(0.0);
    progressDialog(
      context: context,
      title: 'ذخیره کتاب',
      description: 'درحال ذخیره تغییرات.',
      progressValue: v,
    ).showAsSimpleDialog(context: context, barrierDismissible: false);
  }

  List<Widget> line1() {
    return [
      Expanded(
        child: TextInput(lable: 'نام کتاب', textEditingController: nameCon),
      ),
      Expanded(
        child: TextInput(lable: 'شناسه کتاب', textEditingController: idCon),
      ),
      Expanded(
        child: TextInput(
          lable: 'شناسه منبع',
          textEditingController: resourceCon,
        ),
      ),
    ];
  }

  List<Widget> line2() {
    return [
      Expanded(
        child: TextInput(lable: 'ناشر', textEditingController: publisherCon),
      ),
      Expanded(
        child: TextInput(
          lable: 'تاریخ انتشار',
          textEditingController: publishDateCon,
        ),
      ),
      Expanded(
        child: TextInput(lable: 'مولف', textEditingController: authorCon),
      ),
    ];
  }

  List<Widget> line3() {
    return [
      Expanded(
        child: TextInput(lable: 'ISBN', textEditingController: isbnCon),
      ),
      Expanded(
        child: TextInput(
          lable: 'شماره ویرایش',
          textEditingController: editionCon,
        ),
      ),
      Expanded(
        child: TextInput(
          lable: 'ارجاعات',
          textEditingController: referencesCon,
        ),
      ),
    ];
  }

  Widget tableOfContentText() {
    return TextInput(
      lable: 'فهرست مطالب',
      minLines: 15,
      border: OutlineInputBorder(),
    );
  }

  Widget bookFullText() {
    return TextInput(
      lable: 'متن کامل کتاب',
      minLines: 15,
      border: OutlineInputBorder(),
    );
  }

  List<Widget> addFileRow() {
    return [
      Expanded(
        flex: 1,
        child: FilledButton.icon(
          onPressed: () {},
          label: Text('افزودن فایل'),
          icon: Icon(Icons.file_open),
        ),
      ),
      Expanded(
        flex: 2,
        child: TagBox(
          title: 'path/to/file',
          color: Colors.black,
          mainAxisAlignment: .center,
        ),
      ),
    ];
  }

  Widget pageView() {
    return Column(
      spacing: 10,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Text('صفحه 5 از 15'),
        TextInput(
          lable: 'متن صفحه',
          minLines: 10,
          border: OutlineInputBorder(),
        ),
        TextInput(lable: 'پاورقی', minLines: 5, border: OutlineInputBorder()),
        Center(child: PageNavigator()),
      ],
    );
  }
}
