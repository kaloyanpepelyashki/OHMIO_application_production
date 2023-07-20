import 'package:flutter/material.dart';

class TopBarBlank extends StatelessWidget implements PreferredSizeWidget {
  const TopBarBlank({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leadingWidth: 100,
      elevation: 0,
    );
  }
}
