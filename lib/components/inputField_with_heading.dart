import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';

class InputFieldWithHeading extends StatelessWidget {
  final TextEditingController controller;
  final String heading;
  final String placeHolder;
  const InputFieldWithHeading(
      {super.key,
      required this.controller,
      required this.heading,
      required this.placeHolder});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 17),
          child: Text(heading,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 15, letterSpacing: 1.5))),
      TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: placeHolder, enabledBorder: const OutlineInputBorder()))
    ]));
  }
}
