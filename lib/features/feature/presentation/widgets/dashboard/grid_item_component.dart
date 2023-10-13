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
  final double? latestValue;

  const GridItem(
      {super.key,
      this.id,
      this.isActuator,
      this.sensorName,
      this.sensorImage,
      this.sensorDescription,
      this.latestValue});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  final symbolList = ['° C', '%'];
  double latestValue = 0;

  @override
  void initState() {
    print("WIDGET.ID IN GRID_ITEM_COMP: ${widget.id}");
    // BlocProvider.of<PinTunnelBloc>(context)
    //   .add(SubscribeChannel(sensorId: widget.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LatestDataReceivedState) {
          for (int i = 0; i < state.listOfLatestData.length; i++) {
            if (widget.id == state.listOfLatestData[i].sensorMac) {
              print("Latest value $i: ${state.listOfLatestData[i]}");
              print("SUCCESSFULY ADDED TO sensors");
              if (state.listOfLatestData[i].value != null) {
                latestValue = state.listOfLatestData[i].value!;
              }
            }
          }
        }
        return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFF1F1F1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        latestValue.toString(),
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
                ],
              ),
            ),
            onTap: () {
              GoRouter.of(context).pushNamed("sensorPage",
                  pathParameters: {'id': widget.id.toString()});
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
