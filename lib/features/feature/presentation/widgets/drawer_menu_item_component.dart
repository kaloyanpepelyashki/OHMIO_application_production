import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerMenuItemComponent extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final action;
  const DrawerMenuItemComponent(
      {super.key, required this.text, required this.action});

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
        child: Row(children: [
          InkWell(
            child: Text(text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: action,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
          )
        ]));
  }
}
