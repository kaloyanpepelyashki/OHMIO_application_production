import 'package:flutter/material.dart';

//Back button with arrow
class BackActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const BackActionBtn({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 90.0,
        child: TextButton.icon(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_back,
              size: 22.0,
              color: Color.fromARGB(255, 18, 18, 18),
            ),
            label: const Text("Back",
                style: TextStyle(
                    color: Color.fromARGB(255, 18, 18, 18), fontSize: 18.0))));
  }
}
