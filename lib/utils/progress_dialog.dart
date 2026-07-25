import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget progressDialog({
  required BuildContext context,
  required String title,
  required String description,
  required ValueListenable<double> progressValue,
  VoidCallback? onCancel,
}) {
  void popOnComplete(double value) {
    if (progressValue.value == 1) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  return Column(
    mainAxisSize: .min,
    spacing: 10,
    crossAxisAlignment: .start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      Text(description),
      const SizedBox(height: 10),
      ValueListenableBuilder(
        valueListenable: progressValue,
        builder: (context, value, child) {
          popOnComplete(value);
          return TweenAnimationBuilder<double>(
            tween: Tween(end: value),
            duration: const Duration(seconds: 2),
            // curve: Curves.ease,
            builder: (context, animValue, child) {
              return LinearProgressIndicator(
                value: animValue,
                minHeight: 20,
                borderRadius: const .all(.circular(10)),
              );
            },
          );
        },
      ),
      SizedBox(
        width: .infinity,
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
  );
}
