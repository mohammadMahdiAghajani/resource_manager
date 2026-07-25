import 'package:book_adder_2/models/project.dart';
import 'package:book_adder_2/utils/dialog_save_cancel_button.dart';
import 'package:book_adder_2/utils/yes_no_dialog.dart';
import 'package:book_adder_2/vm_pages/project_vm.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class SideBar extends StatefulWidget {
  final ProjectVM vm;
  final void Function(Project project) onSelectProject;
  const SideBar({super.key, required this.vm, required this.onSelectProject});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topCenter,
      child: Container(
        width: 200,
        clipBehavior: .antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: .circular(10),
        ),
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: widget.vm.pageState,
            builder: (context, pageState, child) {
              return ValueListenableBuilder(
                valueListenable: widget.vm.projectList,
                builder: (context, value, child) {
                  return Column(
                    mainAxisSize: .min,
                    children: sideBarItems(pageState),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> sideBarItems(ProjectPageState pageState) {
    return [
      ...projectTabs(pageState),
      Divider(indent: 10, endIndent: 10),
      ...projectManagmentButtons(),
      Divider(indent: 10, endIndent: 10),
      ...widget.vm.projectList.value.map(tile),
    ];
  }

  Widget tile(Project project) {
    return ListTile(
      title: Text(project.projectName ?? ''),
      leading: Icon(Icons.arrow_right),
      titleTextStyle: widget.vm.currentProject.value == project
          ? Theme.of(context).textTheme.titleMedium
          : null,
      selected: widget.vm.currentProject.value == project,
      onTap: () {
        widget.vm.currentProject.value = project;
        widget.onSelectProject(project);
        widget.vm.pageState.notifyListeners();
      },
    );
  }

  List<Widget> projectTabs(ProjectPageState pageState) {
    return [
      ListTile(
        title: Text('اطلاعات پروژه'),
        leading: Icon(Icons.info_outline),
        selectedTileColor: Theme.of(context).focusColor,
        titleTextStyle: pageState == .projectInfo
            ? Theme.of(context).textTheme.titleMedium
            : null,
        selected: pageState == .projectInfo,
        selectedColor: Colors.black,
        onTap: () {
          widget.vm.pageState.value = .projectInfo;
        },
      ),
      ListTile(
        title: Text('منابع'),
        leading: Icon(Icons.article_outlined),
        selectedTileColor: Theme.of(context).focusColor,
        titleTextStyle: pageState == .resource
            ? Theme.of(context).textTheme.titleMedium
            : null,
        selected: pageState == .resource,
        selectedColor: Colors.black,
        onTap: () {
          widget.vm.getResources();
          widget.vm.pageState.value = .resource;
        },
      ),
      ListTile(
        title: Text('نویسندگان'),
        leading: Icon(Icons.group_outlined),
        selectedTileColor: Theme.of(context).focusColor,
        titleTextStyle: pageState == .author
            ? Theme.of(context).textTheme.titleMedium
            : null,
        selected: pageState == .author,
        selectedColor: Colors.black,
        onTap: () {
          widget.vm.getAuthors();
          widget.vm.pageState.value = .author;
        },
      ),
    ];
  }

  List<Widget> projectManagmentButtons() {
    return [
      ListTile(
        title: Text('افزودن پروژه'),
        leading: Icon(Icons.add),
        onTap: onAddProjectDialog,
      ),
      ListTile(
        title: Text('حذف پروژه'),
        leading: Icon(Icons.delete_outline),
        onTap: onDeleteProjectDialog,
      ),
    ];
  }

  void onDeleteProjectDialog() {
    yesNoDialog(
      context: context,
      title: 'حذف پروژه',
      description:
          'آیا مطمئن هستید، میخواهید پروژه و همه منابع آن را حذف کنید؟',
      onContinue: () async {
        await widget.vm.onDeleteProject();
        Navigator.pop(context);
      },
      // onCancel: () {},
    ).showAsSimpleDialog(context: context);
  }

  void onAddProjectDialog() {
    final nameCon = TextEditingController();
    final descriptionCon = TextEditingController();

    Column(
      mainAxisSize: .min,
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text('افزودن پروژه', style: Theme.of(context).textTheme.titleMedium),
        TextInput(lable: 'نام پروژه', textEditingController: nameCon),
        TextInput(lable: 'توضیحات', textEditingController: descriptionCon),
        const SizedBox(height: 10),
        dialogSaveCancleButton(
          onSave: () async {
            final newProject = Project(
              projectName: nameCon.text,
              description: descriptionCon.text,
            );
            await widget.vm.onAddProject(newProject);
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ],
    ).showAsSimpleDialog(context: context);
  }
}
