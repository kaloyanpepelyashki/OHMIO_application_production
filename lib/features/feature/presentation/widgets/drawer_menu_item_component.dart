import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerMenuComponent extends StatelessWidget
    implements PreferredSizeWidget {
  const DrawerMenuComponent({super.key});

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //     height: 40,
    //     width: 100,
    //     child: Row(
    //       children: [
    //         Flexible(child: InkWell(child: Text("Test"), onTap: () {})),
    //         const Icon(Icons.arrow_forward, size: 29)
    //       ],
    //     ));
    return SizedBox(
        height: 40,
        width: 40,
        child: Icon(
          Icons.arrow_forward,
          size: 42,
        ));
  }
}
