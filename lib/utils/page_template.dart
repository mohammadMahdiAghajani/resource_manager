import 'package:book_adder_2/utils/scrollbar_wraper.dart';
import 'package:flutter/material.dart';

Widget pageTemplate<T>({
  required Widget Function(AsyncSnapshot<T> asyncSnapshot) page,
  required Future<T>? Function() future,
  required Listenable listenable,
  required BuildContext context,
  ScrollController? controller,
}) {
  return Align(
    alignment: .topCenter,
    child: SizedBox(
      width: 1000,
      child: scrollBarWraper(
        context: context,
        controller: controller,
        child: ListenableBuilder(
          listenable: listenable,
          builder: (context, child) {
            return FutureBuilder(
              future: future(),
              builder: (context, asyncSnapshot) {
                return page(asyncSnapshot);
              },
            );
          },
        ),
      ),
    ),
  );
}
