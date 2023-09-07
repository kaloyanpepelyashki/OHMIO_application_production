import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/entities/sensor_class.dart';

class ChooseSensorWidget extends StatelessWidget {
  final bool isActuator;
  final String sensorImage;
  final String sensorName;
  final String sensorDescription;
  const ChooseSensorWidget(
      {
      required this.isActuator,
      required this.sensorImage,
      required this.sensorName,
      required this.sensorDescription,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Center(
          child: Container(
            width: 300,
            height: 200,
            color: Colors.lightBlue,
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/$sensorImage'),
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sensorName),
                      SizedBox(height: 30),
                      Text(sensorDescription)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop(SensorClass(
              isActuator: isActuator,
              sensorImage: sensorImage,
              sensorName: sensorName,
              sensorDescription: sensorDescription));
        });
  }
}
