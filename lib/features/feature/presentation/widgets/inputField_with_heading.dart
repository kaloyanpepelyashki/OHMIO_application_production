import 'package:flutter/material.dart';

class InputFieldWithHeading extends StatelessWidget {
  final TextEditingController controller;
  final String? heading;
  final String placeHolder;
  final bool obscureText;

  const InputFieldWithHeading(
      {super.key,
      required this.controller,
      this.heading,
      required this.placeHolder,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          heading == null
              ? Container()
              : Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 17),
                  child: Text(heading ?? " ",
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(fontSize: 15, letterSpacing: 1.5))),
          TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                  hintText: placeHolder,
                  enabledBorder: const OutlineInputBorder()))
        ]));
  }
}
