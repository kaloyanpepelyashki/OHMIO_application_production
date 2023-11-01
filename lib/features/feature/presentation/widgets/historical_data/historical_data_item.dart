import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/core/util/get_color_from_theme_color.dart';
import 'package:intl/intl.dart';

class HistoricalDataItem extends StatefulWidget {
  final int id;
  final String? sensorName;
  final String? sensorImage;
  final String sensorDescription;
  final String? missingDay;
  final String? sensorPlacement;
  final String? sensorUnit;
  final String themeColor;

  const HistoricalDataItem({
    super.key,
    required this.id,
    this.sensorName,
    this.sensorImage,
    required this.sensorDescription,
    this.missingDay,
    this.sensorPlacement,
    this.sensorUnit,
    required this.themeColor,
  });

  @override
  State<HistoricalDataItem> createState() => _HistoricalDataItemState();
}

class _HistoricalDataItemState extends State<HistoricalDataItem> {
  late DateTime missingDay;

  @override
  void initState() {
    if (widget.missingDay != null) {
      RegExp regExp = RegExp(r"(.*)([+\-]\d{2}:\d{2})");
      Match? match = regExp.firstMatch(widget.missingDay!);
      if (match != null) {
        String datetimePart = match[1]!;
        String offsetPart = match[2]!;

        DateTime dateTime =
            DateFormat("yyyy-MM-dd'T'HH:mm").parse(datetimePart);

        final offsetHours = int.parse(offsetPart.split(":")[0]);
        final offsetMinutes = int.parse(offsetPart.split(":")[1]) *
            (offsetHours ~/ offsetHours.abs());
        dateTime = dateTime
            .subtract(Duration(hours: offsetHours, minutes: offsetMinutes));
        missingDay = dateTime;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: getColorFromThemeColor(widget.themeColor!, context),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: Image.asset('assets/temp_vector.png'),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                              widget.sensorName == null
                                  ? ""
                                  : widget.sensorName!,
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff5D467D))),
                          Text(
                            widget.sensorPlacement!,
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff5D467D)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    missingDay != null
                        ? ("Last active: ${missingDay.day}/${missingDay.month}")
                        : "",
                    style: TextStyle(fontSize: 14, color: Color(0xff5D467D)))
              ],
            ),
          ),
        ),
        onTap: () {
          GoRouter.of(context).pushNamed(
            "sensorPage",
            pathParameters: {
              'id': widget.id.toString(),
              'sensorName': widget.sensorName == "" ? "name" : widget.sensorName!,
              'sensorPlacement':
                      widget.sensorPlacement == "" ? 'placement' : widget.sensorPlacement!,
              'unit': widget.sensorUnit??"unit",
              'isHistoricalData': 'true'
            },
          );
        });
  }
}
