import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/models/interface/content.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/repositories/book_repositorie.dart';
import 'package:book_adder_2/repositories/resource_repositorie.dart';
import 'package:book_adder_2/repositories/short_article_repositorie.dart';
import 'package:book_adder_2/utils/animation.dart';
import 'package:book_adder_2/utils/custom_app_bar.dart';
import 'package:book_adder_2/utils/dialog_save_cancel_button.dart';
import 'package:book_adder_2/v_pages/va_book.dart';
import 'package:book_adder_2/v_widgets/record_paging.dart';
import 'package:book_adder_2/vm_pages/resource_manager_vm.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/input/text_input.dart';
import 'package:zu_widgets/material/navigation.dart';
import 'package:zu_widgets/zu_temp/widget_extentions.dart';

class ResourceV extends StatefulWidget {
  final Resource resource;
  final ResourceRepositorie resourceRepo;
  final BookRepositorie bookRepo;
  final ShortArticleRepositorie shortArticlesRepo;
  final List<Author> authors;
  const ResourceV({
    super.key,
    required this.resource,
    required this.resourceRepo,
    required this.bookRepo,
    required this.shortArticlesRepo,
    required this.authors,
  });

  @override
  State<ResourceV> createState() => _ResourceVState();
}

class _ResourceVState extends State<ResourceV> {
  late final ResourceManagerVM vm;

  @override
  void initState() {
    vm = ResourceManagerVM(
      currentResource: widget.resource,
      resourceRepo: widget.resourceRepo,
      bookRepo: widget.bookRepo,
      shortArticlesRepo: widget.shortArticlesRepo,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: '${widget.resource.resourceName} (منبع)',
        buttons: [addContentButton()],
      ),
      body: Align(
        alignment: .topCenter,
        child: Container(
          width: 1000,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: FutureBuilder(
            future: vm.getContents(),
            builder: (context, asyncSnapshot) {
              return ListenableBuilder(
                listenable: vm,
                builder: (context, child) {
                  return body();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget addContentButton() {
    return FilledButton.icon(
      onPressed: switch (widget.resource.resourceType) {
        'book' => showAddBookDialog,
        _ => () {},
      },
      label: Text('افزودن ${widget.resource.resourceTypePersion}'),
      icon: Icon(Icons.add),
    );
  }

  Widget body() {
    return RecordPaging(
      records: [
        for (int i = 0; i < vm.contents.length; i++)
          switch (vm.contents[i]) {
            Book book => bookTile(book, i),
            _ => const SizedBox(),
          },
      ],
    );
  }

  Widget bookTile(Book book, int index) {
    void onEdit() {
      pushMaterialPage(
        context: context,
        child: BookV(
          book: book,
          bookRepo: widget.bookRepo,
          authors: widget.authors,
        ),
      );
    }

    return ListTile(
      onTap: () {},
      title: Text(book.bookName ?? ''),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: Icon(Icons.edit, color: Colors.grey),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: Colors.grey),
          ),
        ],
      ),
    ).listTileAnim1(index ~/ 3);
  }

  void showAddBookDialog() {
    final nameCon = TextEditingController();

    Column(
      mainAxisSize: .min,
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text('افزودن کتاب', style: Theme.of(context).textTheme.titleMedium),
        TextInput(lable: 'نام کتاب', textEditingController: nameCon),
        const SizedBox(height: 10),
        dialogSaveCancleButton(
          onSave: () {
            final book = Book(
              bookName: nameCon.text,
              resourceId: vm.currentResource.resourceId,
            );
            vm.createBook(book);
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ],
    ).showAsSimpleDialog(context: context);
  }

  void showAddArticleDialog() {
    Column(
      mainAxisSize: .min,
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text('افزودن مقاله', style: Theme.of(context).textTheme.titleMedium),
        TextInput(lable: 'عنوان مقاله'),
        const SizedBox(height: 10),
        dialogSaveCancleButton(
          onSave: () {},
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ],
    ).showAsSimpleDialog(context: context);
  }
}

  // Widget addResourceMenu() {
  //   List<PopupMenuEntry<dynamic>> itemBuilder(BuildContext context) {
  //     return [
  //       PopupMenuItem(
  //         child: Text('کتاب'),
  //         onTap: () {
  //           addBookDialog().showAsSimpleDialog(context: context);
  //         },
  //       ),
  //       PopupMenuItem(
  //         child: Text('مقاله کوتاه'),
  //         onTap: () {
  //           addArticleDialog().showAsSimpleDialog(context: context);
  //         },
  //       ),
  //     ];
  //   }

  //   return PopupMenuButton(
  //     padding: .zero,
  //     // menuPadding: .zero,
  //     tooltip: 'افزودن منبع',
  //     offset: Offset(10, 30),
  //     itemBuilder: itemBuilder,
  //     icon: Icon(Icons.add_box_outlined),
  //   );
  // }