import 'package:flutter/material.dart';

Widget scrollBarWraper({
  required BuildContext context,
  ScrollController? controller,
  required Widget child,
}) {
  return ScrollConfiguration(
    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
    child: Scrollbar(
      controller: controller,
      thumbVisibility: true,
      trackVisibility: true,
      thickness: 15,
      radius: const Radius.circular(3),
      interactive: true,
      scrollbarOrientation: ScrollbarOrientation.right,
      child: child,
    ),
  );
}
