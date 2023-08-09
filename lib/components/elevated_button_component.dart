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
            minimumSize: const Size(199, 44)),
        onPressed: onPressed,
        child: Text(text,
            style: const TextStyle(fontSize: 29, color: Color(0xFFFFFFFF))));
  }
}
