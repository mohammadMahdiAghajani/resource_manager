import 'package:book_adder_2/utils/animation.dart';
import 'package:book_adder_2/vm_pages/project_vm.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class ProjectInfoV extends StatefulWidget {
  final ProjectVM vm;
  const ProjectInfoV({super.key, required this.vm});

  @override
  State<ProjectInfoV> createState() => _ProjectInfoVState();
}

class _ProjectInfoVState extends State<ProjectInfoV> {
  late TextEditingController nameCon;
  late TextEditingController idCon;
  late TextEditingController ownerCon;
  late TextEditingController createdByCon;
  late TextEditingController revisionNumberCon;
  late TextEditingController startedAtCon;
  late TextEditingController finishedAtCon;
  late TextEditingController descriptionCon;

  void initCon() {
    nameCon = TextEditingController(
      text: widget.vm.currentProject.value?.projectName,
    );
    idCon = TextEditingController(
      text: widget.vm.currentProject.value?.projectId.toString(),
    );
    ownerCon = TextEditingController(
      text: widget.vm.currentProject.value?.projectOwner.toString(),
    );
    createdByCon = TextEditingController(
      text: widget.vm.currentProject.value?.createdBy,
    );
    revisionNumberCon = TextEditingController(
      text: widget.vm.currentProject.value?.revisionNumber.toString(),
    );
    startedAtCon = TextEditingController(
      text: widget.vm.currentProject.value?.startedAt,
    );
    finishedAtCon = TextEditingController(
      text: widget.vm.currentProject.value?.finishedAt,
    );
    descriptionCon = TextEditingController(
      text: widget.vm.currentProject.value?.description,
    );
  }

  @override
  void initState() {
    initCon();
    widget.vm.onProjectInfoSave = onSave;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProjectInfoV oldWidget) {
    initCon();
    widget.vm.onProjectInfoSave = onSave;
    super.didUpdateWidget(oldWidget);
  }

  void onSave() {
    widget.vm.currentProject.value!.projectName = nameCon.text;
    widget.vm.currentProject.value!.projectOwner = int.tryParse(ownerCon.text);
    widget.vm.currentProject.value!.createdBy = createdByCon.text;
    widget.vm.currentProject.value!.revisionNumber = int.tryParse(nameCon.text);
    widget.vm.currentProject.value!.startedAt = startedAtCon.text.isEmpty
        ? null
        : startedAtCon.text;
    widget.vm.currentProject.value!.finishedAt = startedAtCon.text.isEmpty
        ? null
        : finishedAtCon.text;
    widget.vm.currentProject.value!.description = descriptionCon.text;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: shadowA,
          color: Colors.white,
          borderRadius: const .all(.circular(10)),
        ),
        child: SimpleTable(spacing: 10, expandedItem: true, items: items()),
      ).listTileAnim1(),
    );
  }

  List<List<Widget>> items() {
    return [
      [
        TextInput(lable: 'شناسه پروژه', textEditingController: nameCon),
        TextInput(lable: 'نام پروژه', textEditingController: idCon),
      ],
      [
        TextInput(
          lable: 'سازنده (created_by)',
          textEditingController: createdByCon,
        ),
        TextInput(lable: 'مالک (owner)', textEditingController: ownerCon),
      ],
      [
        TextInput(lable: 'تاریخ شروع', textEditingController: startedAtCon),
        TextInput(lable: 'تاریخ پایان', textEditingController: finishedAtCon),
      ],
      [
        TextInput(
          lable: 'شماره ویرایش',
          textEditingController: revisionNumberCon,
        ),
        TextInput(lable: 'توضیحات', textEditingController: descriptionCon),
      ],
    ];
  }
}
