import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/utils/custom_app_bar.dart';
import 'package:book_adder_2/utils/dialog_save_cancel_button.dart';
import 'package:book_adder_2/utils/progress_dialog.dart';
import 'package:book_adder_2/v_pages/project_v/vb_author.dart';
import 'package:book_adder_2/v_pages/project_v/vb_project_info.dart';
import 'package:book_adder_2/v_pages/project_v/vb_resource_list.dart';
import 'package:book_adder_2/v_pages/project_v/va_side_bar.dart';
import 'package:book_adder_2/vm_pages/project_vm.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class ProjectV extends StatefulWidget {
  const ProjectV({super.key});

  @override
  State<ProjectV> createState() => _ProjectVState();
}

class _ProjectVState extends State<ProjectV> {
  final vm = ProjectVM();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'مدیریت پروژه',
        buttons: [appBarAddButtons()],
      ),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: Row(
            spacing: 20,
            children: [
              FutureBuilder(
                future: vm.getProjectList(),
                builder: (context, asyncSnapshot) {
                  return SideBar(vm: vm, onSelectProject: vm.onSelectProject);
                },
              ),
              Expanded(child: projectCurrentPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget projectCurrentPage() {
    return ValueListenableBuilder(
      valueListenable: vm.pageState,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: vm.currentProject,
          builder: (context, p, child) {
            return switch (value) {
              .projectInfo => ProjectInfoV(vm: vm),
              .resource => ResourceList(vm: vm),
              .author => AuthorV(vm: vm),
            };
          },
        );
      },
    );
  }

  Widget appBarAddButtons() {
    return ValueListenableBuilder(
      valueListenable: vm.pageState,
      builder: (context, value, child) {
        return FilledButton.icon(
          onPressed: switch (value) {
            .resource => onAddResource,
            .author => onAddAuthor,
            .projectInfo => onSaveProjectInfo,
          },
          label: switch (value) {
            .resource => Text('افزودن منبع'),
            .author => Text('افزودن نویسنده'),
            .projectInfo => Text('ذخیره'),
          },
          icon: switch (value) {
            .projectInfo => Icon(Icons.save),
            _ => Icon(Icons.add),
          },
        );
      },
    );
  }

  void onAddResource() =>
      addResourceDialog().showAsSimpleDialog(context: context);
  void onAddAuthor() => addAuthorDialog().showAsSimpleDialog(context: context);

  void onSaveProjectInfo() {
    final pv = ValueNotifier(0.0);
    Future.delayed(Durations.short1, () {
      vm.setProjectInfo();
      pv.value = 1.0;
    });
    progressDialog(
      context: context,
      title: 'ذخیره اطلاعات',
      description: 'در حال ذخیره اطلاعات پروژه.',
      progressValue: pv,
    ).showAsSimpleDialog(context: context);
  }

  Widget addResourceDialog() {
    final nameCon = TextEditingController();
    final typeCon = TextEditingController();

    return Column(
      mainAxisSize: .min,
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text('افزودن منبع', style: Theme.of(context).textTheme.titleMedium),
        TextInput(lable: 'نام منبع', textEditingController: nameCon),
        TextInput(
          lable: 'نوع منبع',
          textEditingController: typeCon,
          suggestions: Resource.resourceTypes,
          showSuggestionsOnEmpty: true,
        ),
        const SizedBox(height: 10),
        dialogSaveCancleButton(
          onSave: () {
            print('1> ${typeCon.text}');
            final resource = Resource(
              resourceName: nameCon.text,
              projectId: vm.currentProject.value!.projectId,
              resourceType: typeCon.text,
              version: 1,
            );
            vm.onAddResource(resource);
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget addAuthorDialog() {
    final nameCon = TextEditingController();
    final typeCon = TextEditingController();

    return Column(
      mainAxisSize: .min,
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text('افزودن نویسنده', style: Theme.of(context).textTheme.titleMedium),
        TextInput(lable: 'نام نویسنده', textEditingController: nameCon),
        const SizedBox(height: 10),
        dialogSaveCancleButton(
          onSave: () {
            final author = Author(firstName: nameCon.text);
            vm.onAddAuthor(author);
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// SimpleTable(
//   spacing: 10,
//   items: [
//     [Text('data'), Text('data'), Text('data')],
//     [Text('data'), Text('data'), Text('data')],
//     [Text('data'), Text('data'), Text('data')],
//   ],
// ),
