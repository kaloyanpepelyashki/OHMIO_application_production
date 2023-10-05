import 'package:flutter/material.dart';

class TextButtonComponent extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const TextButtonComponent(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 20)));
  }
}
