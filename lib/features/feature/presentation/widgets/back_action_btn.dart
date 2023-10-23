import 'package:flutter/material.dart';

//Back button with arrow
class BackActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const BackActionBtn({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 80.0,
        child: TextButton.icon(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 21.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: Text("Back",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18.0))));
  }
}
