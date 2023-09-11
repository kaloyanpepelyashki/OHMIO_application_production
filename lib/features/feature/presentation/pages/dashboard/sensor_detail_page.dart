import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/sensor_class.dart';

class SensorDetailPage extends StatelessWidget {
  final SensorClass sensorClass;

  const SensorDetailPage({
    required this.sensorClass,
    super.key,
  });

  /*late String sensorImage;
  late bool isActuator;
  late String sensorName;
  late String sensorDescription;


  @override
  void initState() {
    super.initState();
    sensorImage = widget.sensorClass.sensorImage!;
    isActuator = widget.sensorClass.isActuator!;
    sensorName = widget.sensorClass.sensorName!;
    sensorDescription = widget.sensorClass.sensorDescription!;
  }
  */
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image(
              image: AssetImage('assets/${sensorClass.sensorImage}'),
              width: 100,
              height: 100,
            ),
            const Column(
              children: [
                Text("Sensor Name"),
                Text("Specifications"),
                Text("Type: "),
                Text("Max sensitivity: "),
                Text("Output: "),
              ],
            ),
          ],
        ),
        const Text("Description"),
        const Text("Lorem ipsum dolor sit amet,"),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(SensorClass(
                isActuator: sensorClass.isActuator,
                sensorImage: sensorClass.sensorImage,
                sensorName: sensorClass.sensorName,
                sensorDescription: sensorClass.sensorDescription));

            GoRouter.of(context).go(
              "/dashboard",
            );
          },
          child: const Text("Connect"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Buy"),
        )
      ],
    );
  }
}
