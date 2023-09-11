import 'package:flutter/material.dart';

class TopBarBurgerMenu extends StatelessWidget implements PreferredSizeWidget {
  const TopBarBurgerMenu({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            //Opens the drawer menu/burger menu programtically
            Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(color: Colors.black, size: 50.0, Icons.menu_rounded),
          padding: const EdgeInsets.fromLTRB(0, 5, 40.0, 0),
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      leadingWidth: 100,
      elevation: 0,
    );
  }
}
