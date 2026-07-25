import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class PageNavigator extends StatelessWidget {
  const PageNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_left)),
        SizedBox(
          width: 100,
          child: TextInput(
            hint: '0',
            border: OutlineInputBorder(),
            textAlign: .center,
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right)),
      ],
    );
  }
}
