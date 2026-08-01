import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class MultySelect extends StatefulWidget {
  final Map<String, dynamic> items;
  final Widget? title;
  final String? hint;
  final void Function(List v)? onChange;
  final Set<String> selecteds;
  const MultySelect({
    super.key,
    required this.items,
    this.title,
    this.hint,
    required this.selecteds,
    this.onChange,
  });

  @override
  State<MultySelect> createState() => _MultySelectState();
}

class _MultySelectState extends State<MultySelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(.circular(5)),
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          ?widget.title,
          Wrap(spacing: 10, alignment: .start, children: itemsWidget()),
          TextInput(
            suggestions: widget.items.keys.toList(),
            showSuggestionsOnEmpty: true,
            hint: widget.hint,
            onSuggestionSelected: (v) {
              widget.selecteds.add(v);
              setState(emptyFunction);
              final r = widget.selecteds.map((k) => widget.items[k]).toList();
              if (widget.onChange != null) widget.onChange!(r);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> itemsWidget() {
    Widget convert(String key) => Chip(
      label: Text(key),
      deleteIcon: Icon(Icons.close),
      onDeleted: () {
        widget.selecteds.remove(key);
        setState(emptyFunction);
        final r = widget.selecteds.map((k) => widget.items[k]).toList();
        if (widget.onChange != null) widget.onChange!(r);
      },
    );
    final w = widget.selecteds.map(convert).toList();
    return w;
  }
}
