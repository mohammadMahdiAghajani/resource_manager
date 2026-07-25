import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/utils/animation.dart';
import 'package:book_adder_2/utils/yes_no_dialog.dart';
import 'package:book_adder_2/v_widgets/record_paging.dart';
import 'package:book_adder_2/vm_pages/project_vm.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class AuthorV extends StatefulWidget {
  final ProjectVM vm;
  const AuthorV({super.key, required this.vm});

  @override
  State<AuthorV> createState() => _AuthorVState();
}

class _AuthorVState extends State<AuthorV> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: RecordPaging(
        records: [
          for (int i = 0; i < widget.vm.authors.value.length; i++)
            authorTile(widget.vm.authors.value[i], i),
        ],
      ),
    );
  }

  Widget authorTile(Author author, int index) {
    return ListTile(
      onTap: () {},
      title: Text(author.firstName ?? ''),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: Colors.grey),
          ),
          IconButton(
            onPressed: () => onDeleteAuthorDialog(author),
            icon: Icon(Icons.delete, color: Colors.grey),
          ),
        ],
      ),
    ).listTileAnim1(index ~/ 3);
  }

  void onDeleteAuthorDialog(Author author) {
    yesNoDialog(
      context: context,
      title: 'حذف منبع',
      description: 'آیا مطمئن هستید، میخواهید این نویسنده را حذف کنید؟',
      onContinue: () async {
        await widget.vm.onDeleteAuthor(author);
        Navigator.pop(context);
      },
      // onCancel: () {},
    ).showAsSimpleDialog(context: context);
  }
}
