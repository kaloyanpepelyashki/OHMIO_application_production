// App bar with only back button
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
      backgroundColor: Theme.of(context).colorScheme.background,
      leadingWidth: 100,
      elevation: 0,
    );
  }
}
