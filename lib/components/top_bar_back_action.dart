// App bar with only back button
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'back_action_btn.dart';

class TopBarBackAction extends StatelessWidget implements PreferredSizeWidget {
  const TopBarBackAction({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackActionBtn(
          icon: Icons.arrow_back,
          onPressed: () {
            //Removes layer from the navigation stack
            Navigator.pop(context);
          }),
      leadingWidth: 100,
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      elevation: 0,
    );
  }
}
