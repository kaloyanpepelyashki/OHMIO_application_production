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

class DashboardSensorWidget extends StatefulWidget {
  final List<Elements> sensorElements;

  const DashboardSensorWidget({required this.sensorElements, super.key});

  @override
  State<DashboardSensorWidget> createState() => _DashboardSensorWidgetState();
}

class _DashboardSensorWidgetState extends State<DashboardSensorWidget> {

  final List<SensorClass> sensorItems = [];

  @override
  void initState() {
    //sensorItems = widget.sensorElements;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SensorsForUserReceivedState) {
          if(state.sensorList != null){
            state.sensorList.forEach((i) {
              if(i.isActuator == false){
                print("sensor image: ${i.sensorImage}");
                if(! sensorItems.any((item) => item.sensorDescription == i.sensorDescription)){
                  sensorItems.add(i);
               }
                //sensorItems.add(Elements(isActuator: i.isActuator!, sensorName: i.sensorName!, sensorImage: i.sensorImage!, sensorDescription: i.sensorDescription!));
              }
            });
          }
        }
        return Expanded(
          child: CustomScrollView(primary: false, slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3/4,
                children: [
                  if (sensorItems.isNotEmpty)
                    for (final el in sensorItems)
                      GridItem(
                        isActuator: el.isActuator!,
                        sensorName: el.sensorName,
                        sensorImage: el.sensorImage,
                        sensorDescription: el.sensorDescription!,
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
