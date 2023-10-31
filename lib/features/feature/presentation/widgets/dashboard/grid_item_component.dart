import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/config/themes/custom_theme.dart';
import 'package:pin_tunnel_application_production/core/util/get_color_from_theme_color.dart';
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
  final String? themeColor;
  final String? nickname;
  final String? unit;
  final String? placement;

  const GridItem(
      {super.key,
      this.id,
      this.isActuator,
      this.sensorName,
      this.sensorImage,
      this.sensorDescription,
      this.latestValue,
      this.themeColor,
      this.nickname,
      this.unit,
      this.placement});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  final symbolList = ['° C', '%'];
  double latestValue = 0;

  @override
  void initState() {
    print("WIDGET.ID IN GRID_ITEM_COMP: ${widget.id}");
    BlocProvider.of<PinTunnelBloc>(context)
        .add(SubscribeChannel(sensorId: widget.id!));
    // BlocProvider.of<PinTunnelBloc>(context)
    //   .add(SubscribeChannel(sensorId: widget.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {
        if (state is PayloadReceivedState) {
          if (state.payload['sensor_mac'] == widget.id) {
            latestValue = double.parse(state.payload['sensor_data']);
          }
        }
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
      },
      builder: (context, state) {
        /*if (state is LatestDataReceivedState) {
          for(int i=0; i<state.listOfLatestData.length; i++){
            if(widget.id == state.listOfLatestData[i].sensorMac){
              print("Latest value $i: ${state.listOfLatestData[i]}");
              print("SUCCESSFULY ADDED TO sensors");
              if (state.listOfLatestData[i].value != null) {
                latestValue = state.listOfLatestData[i].value!;
              }
            }
          }
        }*/
        return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: getColorFromThemeColor(widget.themeColor!, context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,16,8,16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            child: FaIcon(FontAwesomeIcons.penToSquare, color: Color(0xFF5D467D),),
                            onTap: () {
                              GoRouter.of(context).pushNamed("customizeSensor",
                                  pathParameters: {
                                    "sensorId": widget.id.toString()
                                  });
                            }),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 60,
                        height: 70,
                        child: widget.sensorName!
                                .toUpperCase()
                                .contains("TEMPERATURE")
                            ? Image.asset('assets/temp_vector.png')
                            : SizedBox(),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Wrap(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  latestValue.toString(),
                                  style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5D467D)),
                                ),
                                Text(
                                  widget.unit ?? "",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Color(0xFF5D467D)
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.sensorName == null
                                  ? ""
                                  : widget.sensorName![0].toUpperCase() +
                                      widget.sensorName!.substring(1),
                              style: TextStyle(color:Color(0xFF5D467D)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0,0,0,0),
                    child: Column(
                      children: [
                        Text(widget.nickname!, style: TextStyle(color: Color(0xFF5D467D)),),
                        Text(widget.placement ?? "", style: TextStyle(color: Color(0xFF5D467D)),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              GoRouter.of(context).pushNamed(
                "sensorPage",
                pathParameters: {
                  'id': widget.id.toString(),
                  'sensorName': widget.sensorName.toString(),
                  'sensorPlacement':
                      widget.placement == "" ? 'placement' : widget.placement!,
                  'unit': widget.unit.toString()
                },
              );
            });
      },
    );
  }
}
