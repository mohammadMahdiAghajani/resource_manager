import 'package:flutter/material.dart';

Widget yesNoDialog({
  required BuildContext context,
  required String title,
  required String description,
  VoidCallback? onContinue,
  VoidCallback? onCancel,
}) {
  return Column(
    mainAxisSize: .min,
    spacing: 10,
    crossAxisAlignment: .start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      Text(description),
      const SizedBox(height: 10),
      Row(
        spacing: 10,
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: onContinue,
              label: Text('ادامه'),
              icon: Icon(Icons.check),
            ),
          ),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                if (onCancel != null) onCancel();
                Navigator.pop(context);
              },
              label: Text('لغو'),
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    ],
  );
}
