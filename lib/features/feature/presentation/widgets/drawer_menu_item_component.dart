import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerMenuItemComponent extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final VoidCallback action;

  const DrawerMenuItemComponent(
      {super.key, required this.text, required this.action});

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: action,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
            child: Row(
              children: [
                Text(text,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              ],
            )));
  }
}
