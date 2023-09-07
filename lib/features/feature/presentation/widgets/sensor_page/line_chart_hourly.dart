import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelState.dart';

class LineChartHourly extends StatefulWidget {
  const LineChartHourly({super.key});

  @override
  State<LineChartHourly> createState() => _LineChartHourlyState();
}

class _LineChartHourlyState extends State<LineChartHourly> {
  double xValue = 1;
  double minX = 10;
  double maxX = 20;
  double minY = 10;
  double maxY = 90;
  List<FlSpot> spotValues = [
    FlSpot(10, 10),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PayloadReceivedState) {
          spotValues.add(FlSpot(xValue, state.payload['new']['data']));
          xValue++;
          if (spotValues.length > 9) {
            minX++;
            maxX++;
          }
          if (minX < 0) {
            minX = 0;
          }
          if (spotValues.length > 9) {
            spotValues.removeAt(0);
          }
        }
        return LineChart(
          LineChartData(
            minX: minX,
            maxX: maxX,
            minY: minY,
            maxY: maxY,
            gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: const Color(0xff37433d),
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: const Color(0xff37433d),
                    strokeWidth: 1,
                  );
                }),
            lineBarsData: [
              LineChartBarData(spots: spotValues),
            ],
          ),
        );
      },
    );
  }
}

