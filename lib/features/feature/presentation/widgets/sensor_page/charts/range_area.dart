import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RangeArea extends StatefulWidget {
  final String timeFilter;

  RangeArea({required this.timeFilter, super.key});

  @override
  State<RangeArea> createState() => RangeAreaState();
}

class RangeAreaState extends State<RangeArea> {
  double seriesAnimation = 1500;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late String timeFilter;

  void setTimeFilter(String newTimeFilter) {
    setState(() {
      timeFilter = newTimeFilter;
    });
  }

  @override
  initState() {
    timeFilter = widget.timeFilter;
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'range');
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late List<ChartData> chartData;
    if (timeFilter == "day") {
      chartData = [
        ChartData(DateTime(2010, 1, 1, 0, 0), 20.0, 10),
        ChartData(DateTime(2010, 1, 2, 0, 0), 22.0, 15),
        ChartData(DateTime(2010, 1, 3, 0, 0), 26.5, 20),
        ChartData(DateTime(2010, 1, 4, 0, 0), 18.5, 18),
        ChartData(DateTime(2010, 1, 5, 0, 0), 19.9, 17),
        ChartData(DateTime(2010, 1, 6, 0, 0), 20.1, 18),
        ChartData(DateTime(2010, 1, 7, 0, 0), 25, 19),
        ChartData(DateTime(2010, 1, 8, 0, 0), 24, 20),
        ChartData(DateTime(2010, 1, 9, 0, 0), 19.9, 17),
      ];
    } else {
      chartData = [
        ChartData(DateTime(2010, 1, 1, 1, 0), 20.0, 10),
        ChartData(DateTime(2010, 1, 1, 1, 1), 22.0, 15),
        ChartData(DateTime(2010, 1, 1, 1, 2), 26.5, 20),
        ChartData(DateTime(2010, 1, 1, 1, 3), 18.5, 18),
        ChartData(DateTime(2010, 1, 1, 1, 4), 19.9, 17),
        ChartData(DateTime(2010, 1, 1, 1, 5), 20.1, 18),
        ChartData(DateTime(2010, 1, 1, 1, 6), 25, 19),
        ChartData(DateTime(2010, 1, 1, 1, 7), 24, 20),
        ChartData(DateTime(2010, 1, 1, 1, 8), 19.9, 17),
      ];
    }
    return Center(
      child: Container(
        width: 500,
        child: SfCartesianChart(
          zoomPanBehavior: _zoomPanBehavior,
          tooltipBehavior: _tooltipBehavior,
          primaryXAxis: DateTimeAxis(
            rangePadding: ChartRangePadding.round,
            labelAlignment: LabelAlignment.end,
            autoScrollingDelta: 5,
            autoScrollingMode: AutoScrollingMode.end,

            //additional offset from both sides - plotOffset: 10
            //intervalType: DateTimeIntervalType.minutes
          ),
          primaryYAxis: NumericAxis(
            labelFormat: '{value}°C',
            minimum: 0.0,
            maximum: 50.0,
            decimalPlaces: 2,
            labelAlignment: LabelAlignment.center,
            plotBands: <PlotBand>[
              //chart area colored
              PlotBand(
                isVisible: true,
                start: 30,
                end: 50,
                color: Colors.red,
                opacity: 0.5,
              ),
              PlotBand(
                isVisible: true,
                start: 0,
                end: 5,
                color: Colors.blue,
                opacity: 0.5,
              ),
            ],
            //numberFormat: NumberFormat.compactCurrency()
          ),
          series: <ChartSeries>[
            RangeAreaSeries<ChartData, DateTime>(
              enableTooltip: true,
              dataSource: chartData,
              borderDrawMode: RangeAreaBorderMode.excludeSides,
              color: Colors.white,
              opacity: 0.5,
              markerSettings: const MarkerSettings(
                isVisible: true,
                shape: DataMarkerType.diamond,
                borderColor: Colors.black,
              ),
              //dataLabelSettings: const DataLabelSettings(
              //    showCumulativeValues: true,
              //    isVisible: true,
              //    color: Colors.blue,
              //    ),
              borderColor: Colors.black,
              borderWidth: 2,
              xValueMapper: (ChartData data, _) => data.x,
              lowValueMapper: (ChartData data, _) => data.low,
              highValueMapper: (ChartData data, _) => data.high,
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.high, this.low);
  final DateTime x;
  final double high;
  final double low;
}
