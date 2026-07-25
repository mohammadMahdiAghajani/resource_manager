import 'package:book_adder_2/utils/scrollbar_wraper.dart';
import 'package:book_adder_2/v_widgets/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_temp/shadow.dart';

class RecordPaging extends StatefulWidget {
  final List<Widget>? records;
  const RecordPaging({super.key, this.records});

  @override
  State<RecordPaging> createState() => _RecordPagingState();
}

class _RecordPagingState extends State<RecordPaging> {
  final scrollCon = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: scrollBarWraper(
            context: context,
            controller: scrollCon,
            child: ListView(
              controller: scrollCon,
              children: widget.records ?? const [],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: .infinity,
          alignment: .center,
          decoration: BoxDecoration(
            boxShadow: shadowA,
            color: Colors.white,
            borderRadius: const .all(.circular(10)),
          ),
          child: PageNavigator(),
        ),
      ],
    );
  }
}
