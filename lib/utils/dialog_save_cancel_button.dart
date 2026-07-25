import 'package:flutter/material.dart';

Widget dialogSaveCancleButton({VoidCallback? onSave, VoidCallback? onCancel}) {
  return Row(
    spacing: 10,
    children: [
      Expanded(
        child: FilledButton.icon(
          onPressed: onSave,
          label: Text('ذخیره'),
          icon: Icon(Icons.check),
        ),
      ),
      Expanded(
        child: OutlinedButton.icon(
          onPressed: onCancel,
          label: Text('لغو'),
          icon: Icon(Icons.close),
        ),
      ),
    ],
  );
}
