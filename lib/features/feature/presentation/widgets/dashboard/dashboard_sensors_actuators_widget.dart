import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/add_new_device_widget.dart';

import '../../../domain/entities/sensor_class.dart';
import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelState.dart';
import 'dashboard_elements.dart';
import 'grid_item_component.dart';

class DashboardSensorsActuatorsWidget extends StatefulWidget {
  final List<SensorClass> sensorsActuatorsElements;

  const DashboardSensorsActuatorsWidget(
      {required this.sensorsActuatorsElements, super.key});

  @override
  State<DashboardSensorsActuatorsWidget> createState() =>
      _DashboardSensorWidgetState();
}

class _DashboardSensorWidgetState
    extends State<DashboardSensorsActuatorsWidget> {
  List<SensorClass> sensorItems = [];
  final List<String> themeColors = ['card1', 'card2', 'card3', 'card4'];

  @override
  void initState() {
    sensorItems = widget.sensorsActuatorsElements;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
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
                for (int i=0; i<sensorItems.length; i++)
                  GridItem(
                    id: int.parse(sensorItems[i].sensorMac!),
                    isActuator: sensorItems[i].isActuator!,
                    sensorName: sensorItems[i].sensorName,
                    sensorImage: sensorItems[i].sensorImage,
                    sensorDescription: sensorItems[i].sensorDescription!,
                    latestValue: sensorItems[i].latestValue == null ? 0 : sensorItems[i].latestValue,
                    themeColor: themeColors[i%4],
                  ),
              AddNewDeviceWidget(),
            ],
          ),
        )
      ]),
    );
  }
}
