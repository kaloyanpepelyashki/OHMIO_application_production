import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/sensor_class.dart';
import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelState.dart';
import 'dashboard_elements.dart';
import 'grid_item_component.dart';

class DashboardActuatorWidget extends StatefulWidget {
  final Function onActuatorLoaded;
  final List<SensorClass> actuatorElements;
  const DashboardActuatorWidget({required this.onActuatorLoaded, required this.actuatorElements, super.key});

  @override
  State<DashboardActuatorWidget> createState() =>
      _DashboardActuatorWidgetState();
}

class _DashboardActuatorWidgetState extends State<DashboardActuatorWidget> {
   List<SensorClass> actuatorItems = [];

  @override
  void initState() {
    actuatorItems = widget.actuatorElements;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {
        /*
        if (state is SensorsForUserReceivedState) {
          if(state.sensorList.isNotEmpty){
            state.sensorList.forEach((i) {
              if(i.isActuator!){

                if(! actuatorItems.any((item) => item.sensorDescription == i.sensorDescription)){
                  actuatorItems.add(i);
                  widget.onActuatorLoaded(i);
               }
              }
            });
          }
        }
        */
      },
      builder: (context, state) {
        
        return Expanded(
          child: CustomScrollView(primary: false, slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                //set size of grid item
                childAspectRatio: 3/4,
                children: [
                  if (actuatorItems.isNotEmpty)
                    for (final el in actuatorItems)
                      GridItem(
                        isActuator: el.isActuator,
                        sensorDescription: el.sensorDescription,
                        sensorImage: el.sensorImage,
                        sensorName: el.sensorName,
                      ),
                  DottedBorder(

                    strokeWidth: 1,
                    padding: EdgeInsets.all(4),
                    child: Container(
                      color:const Color(0xFFF1F1F1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  
                            Container(
                              width: 90,
                              height: 90,
                              child: IconButton(
                                icon: const FaIcon(FontAwesomeIcons.plus,
                                    size: 90,
                                    color: Colors.black),
                                onPressed: () =>
                                    {GoRouter.of(context).push("/chooseSensorPage")},
                              ),
                            ),
                            SizedBox(height: 20),
                          const Text("Add New Device",
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}
