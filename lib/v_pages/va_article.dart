import 'package:book_adder_2/models/contents/short_articles.dart';
import 'package:book_adder_2/utils/custom_app_bar.dart';
import 'package:book_adder_2/utils/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class ArticleV extends StatefulWidget {
  final ShortArticle article;
  const ArticleV({super.key, required this.article});

  @override
  State<ArticleV> createState() => _ArticleVState();
}

class _ArticleVState extends State<ArticleV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'ویرایش مقاله', onSave: onSaveBook),
      body: Align(
        alignment: .topCenter,
        child: SizedBox(
          width: 1000,
          child: SingleChildScrollView(
            padding: .symmetric(vertical: 20),
            child: SimpleTable(
              spacing: 20,
              items: [
                line1(),
                line2(),
                addFileRow(),
                [bookFullText()],
              ],
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
      title: 'ذخیره مقاله',
      description: 'درحال ذخیره تغییرات.',
      progressValue: v,
    ).showAsSimpleDialog(context: context, barrierDismissible: false);
  }

  List<Widget> line1() {
    return [
      Expanded(child: TextInput(lable: 'عنوان')),
      Expanded(child: TextInput(lable: 'موضوع')),
    ];
  }

  List<Widget> line2() {
    return [
      Expanded(child: TextInput(lable: 'نام منبع(source)')),
      Expanded(child: TextInput(lable: 'نشانی اینترنتی(url)')),
      Expanded(child: TextInput(lable: 'برچسب ها(tags)')),
    ];
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

  Widget bookFullText() {
    return TextInput(
      lable: 'متن کامل مقاله',
      minLines: 15,
      border: OutlineInputBorder(),
    );
  }
}
