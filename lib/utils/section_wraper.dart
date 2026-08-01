import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_temp/shadow.dart';

Widget sectionWraper({List<Widget> children = const <Widget>[]}) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      boxShadow: shadowA,
      color: Colors.white,
      borderRadius: const .all(.circular(10)),
    ),
    child: Column(spacing: 10, children: children),
  );
}
