import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AddNewDeviceWidget extends StatelessWidget {
  const AddNewDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 1,
      padding: EdgeInsets.all(4),
      child: Container(
        color: const Color(0xFFF1F1F1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.plus,
                    size: 70, color: Colors.black),
                onPressed: () =>
                    {GoRouter.of(context).push("/chooseSensorPage")},
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child: const Text("Add New Device", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
