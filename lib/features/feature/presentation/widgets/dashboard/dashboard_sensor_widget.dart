import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/add_new_device_widget.dart';

import '../../../domain/entities/sensor_class.dart';
import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelState.dart';
import 'dashboard_elements.dart';
import 'grid_item_component.dart';

class DashboardSensorWidget extends StatefulWidget {
  final Function onSensorLoaded;
  final List<SensorClass> sensorElements;

  const DashboardSensorWidget(
      {required this.onSensorLoaded, required this.sensorElements, super.key});

  @override
  State<DashboardSensorWidget> createState() => _DashboardSensorWidgetState();
}

class _DashboardSensorWidgetState extends State<DashboardSensorWidget> {
  List<SensorClass> sensorItems = [];

  @override
  void initState() {
    //sensorItems = widget.sensorElements;
    sensorItems = widget.sensorElements;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {
        /*
        if (state is SensorsForUserReceivedState) {
          if(state.sensorList.isNotEmpty){
            sensorItems.clear();
            state.sensorList.forEach((i) {
              print("SENSOR IN DASHBOARD SENSOR WIDGET $i");
              if(i.isActuator == false){
                print("sensor image: ${i.sensorImage}");
                if(! sensorItems.any((item) => item.sensorDescription == i.sensorDescription)){
                  
                  sensorItems.add(i);
                  widget.onSensorLoaded(i);
               }
                //sensorItems.add(Elements(isActuator: i.isActuator!, sensorName: i.sensorName!, sensorImage: i.sensorImage!, sensorDescription: i.sensorDescription!));
              }
            });
          }
        }
        */
      },
      builder: (context, state) {
        return Container(
          height: 500,
          width: 500,
          child: CustomScrollView(primary: false, slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 4,
                children: [
                  if (sensorItems.isNotEmpty)
                    for (final el in sensorItems)
                      GridItem(
                        id: int.parse(el.sensorMac!),
                        isActuator: el.isActuator!,
                        sensorName: el.sensorName,
                        sensorImage: el.sensorImage,
                        sensorDescription: el.sensorDescription!,
                        latestValue:
                            el.latestValue == null ? 0 : el.latestValue,
                      ),
                  AddNewDeviceWidget()
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}
