import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/choose_sensor_widget.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class ChooseSensorPage extends StatelessWidget {
  const ChooseSensorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarBackAction(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ChooseSensorWidget(isActuator:false, sensorDescription: 'A small and super simple NTC thermistor in a voltage divider configuration', sensorImage: 'temperature_sensor.png', sensorName: 'Temperature sensor',),
            SizedBox(height: 50),
            ChooseSensorWidget(isActuator: false, sensorDescription: 'The MQ2 is one of the commonly used analog gas sensors in the MQ sensor series', sensorImage: 'smoke_sensor.png', sensorName: 'Smoke sensor',),
            SizedBox(height: 50),
            ChooseSensorWidget(isActuator: true, sensorDescription: 'This laser is made to operate at 5V.', sensorImage: 'laser_actuator.png', sensorName: 'Laser atuator',),
          ],
        ),
      ),
      );
  }
}