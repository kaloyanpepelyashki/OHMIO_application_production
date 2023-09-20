import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/sensor_class.dart';
import '../../pages/dashboard/sensor_detail_page.dart';

class ChooseSensorWidget extends StatelessWidget {
  final bool isActuator;
  final String sensorImage;
  final String sensorName;
  final String sensorDescription;
  const ChooseSensorWidget(
      {required this.isActuator,
      required this.sensorImage,
      required this.sensorName,
      required this.sensorDescription,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        GestureDetector(
          child: Center(
            child: Container(
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFD9D9D9),
              ),
              height: 90,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/$sensorImage'),
                      width: 50,
                      height: 50,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 17, 8, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sensorName,
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              sensorDescription,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            SensorClass sensorClass = SensorClass(
                isActuator: isActuator,
                sensorImage: sensorImage,
                sensorName: sensorName,
                sensorDescription: sensorDescription);

            GoRouter.of(context).pushNamed("sensorDetailPage", pathParameters: {
              "isActuator": isActuator.toString(),
              "sensorImage": sensorImage.toString(),
              "sensorName": sensorName,
              "sensorDescription": sensorDescription
            });

            //SensorDetailPage(sensorClass: sensorClass);

            /*

GoRouter.of(context)
                          .push(
                        "/sensorDetailPage",
                      ) .then((result) {
                        Navigator.of(context).pop(SensorClass(
                isActuator: isActuator,
                sensorImage: sensorImage,
                sensorName: sensorName,
                sensorDescription: sensorDescription));
                      });

            Navigator.of(context).pop(SensorClass(
                isActuator: isActuator,
                sensorImage: sensorImage,
                sensorName: sensorName,
                sensorDescription: sensorDescription));*/
          },
        ),
      ],
    );
  }
}
