import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/core/util/get_color_from_theme_color.dart';

class HistoricalDataItem extends StatefulWidget {
  final int id;
  final String? sensorName;
  final String? sensorImage;
  final String sensorDescription;
  final String? missingDay;
  final String themeColor;

  const HistoricalDataItem({
    super.key,
    required this.id,
    this.sensorName,
    this.sensorImage,
    required this.sensorDescription,
    this.missingDay,
    required this.themeColor,
  });

  @override
  State<HistoricalDataItem> createState() => _HistoricalDataItemState();
}

class _HistoricalDataItemState extends State<HistoricalDataItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: getColorFromThemeColor(widget.themeColor!, context),
          ),
          child: Column(children: [
            Text(widget.sensorName == null ? "" : widget.sensorName!),
            Text(widget.sensorDescription),
            Text("Missing since: ${widget.missingDay}")
          ]),
        ),
        onTap: () {
          GoRouter.of(context).pushNamed("sensorPage",
              pathParameters: {'id': widget.id.toString()});
        });
  }
}
