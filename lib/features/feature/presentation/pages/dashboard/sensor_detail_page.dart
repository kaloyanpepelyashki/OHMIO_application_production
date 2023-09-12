import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

import '../../../domain/entities/sensor_class.dart';

class SensorDetailPage extends StatelessWidget {
  final String isActuator;
  final String sensorImage;
  final String sensorName;
  final String sensorDescription;

  const SensorDetailPage({
    required this.isActuator,
    required this.sensorImage,
    required this.sensorName,
    required this.sensorDescription,
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
    return Scaffold(
      appBar: const TopBarBackAction(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body:  Column(
      children: [
           Row(
            children: [
              Image(
                image: AssetImage('assets/${sensorImage}'),
                width: 100,
                height: 100,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text("Sensor Name: $sensorName"),
                      Text("Specifications: $sensorDescription "),
                      Text("Type: "),
                      Text("Max sensitivity: "),
                      Text("Output: "),
                    ],
                  ),
                ),
              ),
            ],
          ),
        const Text("Description"),
        const Text("Lorem ipsum dolor sit amet,"),
        ElevatedButton(
          onPressed: () {
           
          },
          child: const Text("Connect"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Buy"),
        )
      ],
    ),
      );
  }
}