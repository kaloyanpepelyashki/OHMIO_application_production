import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/sensor_class.dart';
import 'dashboard_elements.dart';
import 'grid_item_component.dart';

class DashboardActuatorWidget extends StatefulWidget {
  final List<Elements> actuatorElements;
  const DashboardActuatorWidget(
    {
      required this.actuatorElements,
      super.key
    });

  @override
  State<DashboardActuatorWidget> createState() => _DashboardActuatorWidgetState();
}

class _DashboardActuatorWidgetState extends State<DashboardActuatorWidget> {

  late SensorClass selectedSensor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: CustomScrollView(primary: false, slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  //set size of grid item
                  childAspectRatio: 1/2,
                  children: [
                    if (widget.actuatorElements.isNotEmpty)
                      for (final el in widget.actuatorElements)
                          GridItem(
                            isActuator: el.isActuator,
                            sensorDescription: el.sensorDescription,
                            sensorImage: el.sensorImage,
                            sensorName: el.sensorName,
                          ),
                    Container(
                      color: const Color.fromARGB(255, 218, 217, 217),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.plus,
                                size: 50,
                                color: Color.fromARGB(255, 132, 131, 131)),
                            onPressed: () => {
                              GoRouter.of(context).push("/chooseSensorPage").then((result) {
                    if (result != null) {
                      selectedSensor = result as SensorClass;
                      
                    }
                  })
                            },
                          ),
                          const Text("Add New Device",
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
          );
  }
}