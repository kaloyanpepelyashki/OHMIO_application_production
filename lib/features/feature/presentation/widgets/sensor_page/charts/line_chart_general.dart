import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelState.dart';

class LineChartGeneral extends StatefulWidget {
  const LineChartGeneral({
     super.key
    });

  @override
  State<LineChartGeneral> createState() => _LineChartGeneralState();
}

class _LineChartGeneralState extends State<LineChartGeneral> {
  double xValue = 1;
  double minX = 0;
  double maxX = 10;
  double minY = 0;
  double maxY = 90;
  List<FlSpot> spotValues = [
    const FlSpot(0, 3),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PayloadReceivedState) {
          spotValues.add(FlSpot(xValue, state.payload['new']['data']));
          xValue++;
          if(spotValues.length > 9){
            minX++;
            maxX++;
          }
          if (minX < 0) {
            minX = 0;
          }
          if(spotValues.length >9){
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
                  return const FlLine(
                    color: Color(0xff37433d),
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Color(0xff37433d),
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
