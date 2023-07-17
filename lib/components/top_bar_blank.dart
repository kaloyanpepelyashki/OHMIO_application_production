import 'package:flutter/material.dart';

class TopBarBlank extends StatelessWidget implements PreferredSizeWidget {
  const TopBarBlank({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      leadingWidth: 100,
      elevation: 0,
    );
  }
}
