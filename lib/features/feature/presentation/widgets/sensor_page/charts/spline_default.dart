import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineDefault extends StatelessWidget {
  const SplineDefault({
    super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 13),
      ChartData(2012, 34),
      ChartData(2013, 27),
      ChartData(2014, 40)
    ];
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            series: <ChartSeries>[
              // Renders spline chart
              //Use SplineAreaSeries if you want to color area below spline
              SplineSeries<ChartData, int>(
                  //color - provide color for area
                  dataSource: chartData,
                  splineType: SplineType.cardinal,
                  cardinalSplineTension: 0.5,
                  dataLabelSettings: const DataLabelSettings(
                      showCumulativeValues: true,
                      isVisible: true,
                      color: Colors.blue),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),
              //animationDuration: 1000
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}
