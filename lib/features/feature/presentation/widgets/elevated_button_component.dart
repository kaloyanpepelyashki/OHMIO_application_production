import 'package:flutter/material.dart';

class ElevatedButtonComponent extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  const ElevatedButtonComponent(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            minimumSize: const Size(199, 44),
            backgroundColor: Theme.of(context).colorScheme.secondary),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
                fontSize: 29, color: Theme.of(context).colorScheme.primary)));
  }
}
