import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'dashboard_elements.dart';
import 'grid_item_component.dart';

class DashboardSensorWidget extends StatefulWidget {
  final List<Elements> sensorElements;

  const DashboardSensorWidget({
    required this.sensorElements,
    super.key});

  @override
  State<DashboardSensorWidget> createState() => _DashboardSensorWidgetState();
}


class _DashboardSensorWidgetState extends State<DashboardSensorWidget> {

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
                  childAspectRatio: 1/2,
                  children: [
                    if (widget.sensorElements.isNotEmpty)
                      for (final el in widget.sensorElements)
                        GridItem(
                          isActuator: el.isActuator,
                          sensorDescription: el.sensorDescription,
                          sensorImage: el.sensorImage,
                          sensorName: el.sensorName,
                        ),
                    Container(
                      color: Color.fromARGB(255, 218, 217, 217),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.plus,
                                size: 50,
                                color: Color.fromARGB(255, 132, 131, 131)),
                            onPressed: () => {
                              GoRouter.of(context).push("/chooseSensorPage")
                            },
                          ),
                          Text("Add New Device",
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