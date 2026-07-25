import 'package:flutter/material.dart';
import 'package:zu_widgets/zu_widgets.dart';

class TitledColumn extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final IconData? actionIcon;
  final VoidCallback? onActionIcon;
  final List<Widget> children;
  final Widget? actionButton;
  const TitledColumn({
    super.key,
    this.title = '',
    this.icon,
    this.onTap,
    this.actionIcon,
    this.onActionIcon,
    this.actionButton,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: 5,
      crossAxisAlignment: .start,
      children: [
        TagBox(
          title: title,
          icon: icon,
          backgroundColor: false,
          color: Colors.black,
          onTap: onTap,
          mainAxisSize: .max,
          // actionIcon: actionIcon,
          // onIconAction: onActionIcon,
          // actionToolTip: 'بیشتر',
          moreActions: actionButton,
        ),
        Container(
          width: .infinity,
          clipBehavior: .antiAlias,
          decoration: BoxDecoration(
            boxShadow: shadowA,
            color: Colors.white,
            borderRadius: const .all(.circular(10)),
          ),
          child: Column(crossAxisAlignment: .start, children: children),
        ),
      ],
    );
  }
}
