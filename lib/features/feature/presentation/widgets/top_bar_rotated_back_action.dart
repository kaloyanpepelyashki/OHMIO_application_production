import 'package:flutter/material.dart';

import 'back_action_btn.dart';

class TopBarRotatedBackAction extends StatelessWidget
    implements PreferredSizeWidget {
  const TopBarRotatedBackAction({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(
          width: 90.0,
          child: TextButton.icon(
            onPressed: () {
              //Removes layer from the navigation stack
              Navigator.pop(context);
            },
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_back,
                size: 22.0,
                color: Color.fromARGB(255, 18, 18, 18),
              ),
            ),
            label: const RotatedBox(
              quarterTurns: 1,
              child: Text("Back",
                  style: TextStyle(
                      color: Color.fromARGB(255, 18, 18, 18), fontSize: 18.0)),
            ),
          ),
        ),
        Text("DAY"),
        Text("WEEK"),
        Text("MONTH")
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      leadingWidth: 100,
      elevation: 0,
    );
  }
}
