import 'package:flutter/material.dart';

class AlertDialogComponent extends StatelessWidget {
  final BuildContext context;
  final String alertTitle;
  final String alertBody;

  const AlertDialogComponent(
    this.context,
    this.alertTitle,
    this.alertBody, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    final GlobalKey<State> _alerDialogComponentKey = GlobalKey();

    Future.delayed(Duration(seconds: 3), () {
      if (_alerDialogComponentKey.currentState?.mounted ?? false) {
        Navigator.of(context).pop();
      }
    });

    return AlertDialog(
      title: Text(alertTitle),
      content: Text(alertBody),
    );
  }
}
