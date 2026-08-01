import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class PageNavigator extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onPrevios;
  final void Function(int v)? onSetPage;
  final int pageNumber;
  const PageNavigator({
    super.key,
    this.onNext,
    this.onPrevios,
    this.onSetPage,
    this.pageNumber = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        IconButton(onPressed: onPrevios, icon: Icon(Icons.arrow_left)),
        SizedBox(
          width: 100,
          child: TextInput(
            textEditingController: TextEditingController(
              text: pageNumber.toString(),
            ),
            maxLines: 1,
            border: OutlineInputBorder(),
            textAlign: .center,
            onSubmit: onSubmit,
          ),
        ),
        IconButton(onPressed: onNext, icon: Icon(Icons.arrow_right)),
      ],
    );
  }

  void onSubmit(String v) {
    final n = int.tryParse(v);
    if (n != null && onSetPage != null) onSetPage!(n);
  }
}
