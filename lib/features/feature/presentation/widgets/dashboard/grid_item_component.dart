import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';

import '../../bloc/PinTunnelState.dart';

class GridItem extends StatefulWidget {
  final int? id;
  final bool? isActuator;
  final String? sensorName;
  final String? sensorImage;
  final String? sensorDescription;

  const GridItem(
      {super.key,
      this.id,
      this.isActuator,
      this.sensorName,
      this.sensorImage,
      this.sensorDescription});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  final symbolList = ['° C', '%'];
  String valueString = '0';

  @override
  void initState() {
    BlocProvider.of<PinTunnelBloc>(context)
        .add(const SubscribeChannel(sensorId: 12345));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PayloadReceivedState) {
          if (state.payload.containsKey('sensor_data')) {
            valueString = state.payload['sensor_data'][state.payload['sensor_data'].length-1]['data'].toString();
          } else {
            valueString = state.payload['new']['data'].toString();
            //    _chartSeriesController?.updateDataSource(
            //    addedDataIndexes: <int>[chartData.length - 1],
            //  );
          }
        }
        return GestureDetector(
            child: Container(
              color: const Color(0xFFF1F1F1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        valueString,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      determineSymbol(),
                    ],
                  ),
                  SizedBox(height: 50),
                  /*sensorImage == null
                      ? SizedBox()
                      : Image.network(
                          sensorImage!,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('assets/laser_actuator.png'),
                        ),*/
                  Text(
                    widget.sensorName == null ? "" : widget.sensorName!,
                  ),
                  Text(widget.sensorDescription == null
                      ? ""
                      : widget.sensorDescription!)
                ],
              ),
            ),
            onTap: () {
              GoRouter.of(context).push("/sensorPage");
            });
      },
    );
  }

  Widget determineSymbol() {
    if (widget.sensorName?.toUpperCase() == "TEMPERATURE SENSOR") {
      return Text(
        symbolList[0],
        style: TextStyle(fontSize: 30),
      );
    } else {
      return Text(
        symbolList[1],
        style: TextStyle(fontSize: 30),
      );
    }
  }
}
