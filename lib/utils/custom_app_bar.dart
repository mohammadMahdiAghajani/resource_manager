import 'package:flutter/material.dart';

AppBar customAppBar(
  BuildContext context, {
  String title = '',
  VoidCallback? onSave,
  List<Widget> buttons = const [],
}) {
  void popPage() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: SizedBox(
      width: 1000,
      child: Row(
        spacing: 10,
        children: [
          Expanded(child: Text(title)),
          ...buttons,
          if (onSave != null)
            FilledButton.icon(
              onPressed: onSave,
              label: Text('ذخیره'),
              icon: Icon(Icons.save),
            ),
          if (Navigator.canPop(context))
            OutlinedButton.icon(
              onPressed: popPage,
              label: Text('بازگشت'),
              icon: Icon(Icons.arrow_back),
            ),
        ],
      ),
    ),
  );
}
