import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/utils/animation.dart';
import 'package:book_adder_2/utils/dialog_save_cancel_button.dart';
import 'package:book_adder_2/utils/yes_no_dialog.dart';
import 'package:book_adder_2/v_pages/vb_resource.dart';
import 'package:book_adder_2/v_widgets/record_paging.dart';
import 'package:book_adder_2/vm_pages/project_vm.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class ResourceList extends StatefulWidget {
  final ProjectVM vm;
  const ResourceList({super.key, required this.vm});

  @override
  State<ResourceList> createState() => _ResourceListState();
}

class _ResourceListState extends State<ResourceList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: RecordPaging(
        records: [
          for (int i = 0; i < widget.vm.resources.value.length; i++)
            resourceTile(widget.vm.resources.value[i], i),
        ],
      ),
    );
  }

  Widget resourceTile(Resource resource, int index) {
    void onEdit() {
      pushMaterialPage(
        context: context,
        child: ResourceV(
          resource: resource,
          resourceRepo: widget.vm.resourceRepo,
          bookRepo: widget.vm.bookRepo,
          shortArticlesRepo: widget.vm.shortArticlesRepo,
        ),
      );
    }

    return ListTile(
      onTap: () {},
      title: Text(resource.resourceName ?? ''),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: Icon(Icons.edit, color: Colors.grey),
          ),
          IconButton(
            onPressed: () => onDeleteResourceDialog(resource),
            icon: Icon(Icons.delete, color: Colors.grey),
          ),
        ],
      ),
    ).listTileAnim1(index ~/ 3);
  }

  void onDeleteResourceDialog(Resource resource) {
    yesNoDialog(
      context: context,
      title: 'حذف منبع',
      description:
          'آیا مطمئن هستید، میخواهید این منبع و همه محتوای آن را حذف کنید؟',
      onContinue: () async {
        await widget.vm.onDeleteResource(resource);
        Navigator.pop(context);
      },
      // onCancel: () {},
    ).showAsSimpleDialog(context: context);
  }
}
