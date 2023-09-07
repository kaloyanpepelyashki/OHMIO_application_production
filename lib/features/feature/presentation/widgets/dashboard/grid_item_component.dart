import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridItem extends StatelessWidget {
  final bool isActuator;
  final String sensorName;
  final String sensorImage;
  final String sensorDescription;

  const GridItem(
      {super.key,
      required this.isActuator,
      required this.sensorName,
      required this.sensorImage,
      required this.sensorDescription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: isActuator ? Colors.lightBlue : Colors.green[200],
        child: Column(
          children: [
            Image.asset("assets/$sensorImage", width: 100, height: 100),
            Text(
              sensorName,
            ),
            Text(sensorDescription)
          ],
        ),
      ),
      onTap:(){
        GoRouter.of(context).push("/sensorPage");
      }
    );
  }
}
