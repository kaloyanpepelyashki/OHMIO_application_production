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
      strokeWidth: 0.2,
      padding: EdgeInsets.all(4),
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Theme.of(context).colorScheme.background,
              width: 90,
              height: 90,
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.plus,
                  size: 70,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () =>
                    {GoRouter.of(context).push("/chooseSensorPage")},
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Text("Add New Device",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
