import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../bloc/PinTunnelBloc.dart';
import '../../../bloc/PinTunnelState.dart';

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
  List<ChartData> chartData = [];
  ChartSeriesController? _chartSeriesController;

  void setTimeFilter(String newTimeFilter) {
    setState(() {
      timeFilter = newTimeFilter;
    });
  }

  @override
  initState() {
    timeFilter = widget.timeFilter;
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'reading');
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x,
    );
    chartData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        /*
        if (state is PayloadReceivedState &&
            timeFilter.toUpperCase() == "LIVE" &&
            state.payload != null) {
          if (state.payload.containsKey('sensor_data')) {
            for (var record in state.payload['sensor_data']) {
              DateTime dateTime = DateTime.parse(record['time']);
              chartData.add(
                ChartData(
                  DateTime(dateTime.year, dateTime.month, dateTime.day,
                      dateTime.hour, dateTime.minute, dateTime.second),
                  double.parse(
                    record['data'].toString(),
                  ),
                ),
              );
            }
          } else {
            DateTime dateTime = DateTime.parse(state.payload['new']['time']);
            print("STATE PAYLOAD ${state.payload['new']['data']}");
            chartData.add(ChartData(
                DateTime(dateTime.year, dateTime.month, dateTime.day,
                    dateTime.hour, dateTime.minute, dateTime.second),
                state.payload['new']['data']));
            //    _chartSeriesController?.updateDataSource(
            //    addedDataIndexes: <int>[chartData.length - 1],
            //  );
          }
        }

        if (state is DailyDataReceivedState &&
            timeFilter.toUpperCase() == "DAY" &&
            state.payload != null) {
          print("SPLINE_DEFAULT: DAILY PAYLOAD ");
          if (state.payload.containsKey('sensor_data')) {
            for (var record in state.payload['sensor_data']) {
              DateTime dateTime = DateTime.parse(record['created_at']);
              chartData.add(ChartData(
                  DateTime(dateTime.year, dateTime.month, dateTime.day,
                      dateTime.hour, dateTime.minute, dateTime.second),
                  double.parse(record['avg'].toString())));
              //   _chartSeriesController?.updateDataSource(
              //     addedDataIndexes: <int>[chartData.length - 1],
              //  );
            }
            chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
          } else {
            DateTime dateTime =
                DateTime.parse(state.payload['new']['created_at']);
            chartData.add(ChartData(
                DateTime(dateTime.year, dateTime.month, dateTime.day,
                    dateTime.hour, dateTime.minute, dateTime.second),
                state.payload['new']['avg']));
            // _chartSeriesController?.updateDataSource(
            //    addedDataIndexes: <int>[chartData.length - 1],
            //  );
          }
        }

        if (state is WeeklyDataReceivedState &&
            timeFilter.toUpperCase() == "WEEK" &&
            state.payload != null) {
          print("WEEKLY PAYLOAD SPLIE DEFAULT ${state.payload}");
          if (state.payload.containsKey('sensor_data')) {
            for (var record in state.payload['sensor_data']) {
              DateTime dateTime = DateTime.parse(record['created_at']);
              chartData.add(ChartData(
                  DateTime(dateTime.year, dateTime.month, dateTime.day),
                  double.parse(record['avg'].toString())));
              //    _chartSeriesController?.updateDataSource(
              //     addedDataIndexes: <int>[chartData.length - 1],
              //    );
            }
            chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
          } else {
            DateTime dateTime =
                DateTime.parse(state.payload['new']['created_at']);
            chartData.add(ChartData(
                DateTime(dateTime.year, dateTime.month, dateTime.day),
                state.payload['new']['avg']));
            //  _chartSeriesController?.updateDataSource(
            //    addedDataIndexes: <int>[chartData.length - 1],
            //  );
          }
        }

        if (state is MonthlyDataReceivedState &&
            timeFilter.toUpperCase() == "MONTH" &&
            state.payload != null) {
          if (state.payload.containsKey('sensor_data')) {
            for (var record in state.payload['sensor_data']) {
              DateTime dateTime = DateTime.parse(record['created_at']);
              chartData.add(ChartData(DateTime(dateTime.year, dateTime.month),
                  double.parse(record['avg'].toString())));
              //   _chartSeriesController?.updateDataSource(
              //      addedDataIndexes: <int>[chartData.length - 1],
              //   );
            }
            chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
          } else {
            DateTime dateTime =
                DateTime.parse(state.payload['new']['created_at']);
            chartData.add(ChartData(DateTime(dateTime.year, dateTime.month),
                state.payload['new']['avg']));
            //  _chartSeriesController?.updateDataSource(
            //    addedDataIndexes: <int>[chartData.length - 1],
            ///  );
          }
        }
        */
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
                  // Renders spline chart
                  //Use SplineAreaSeries if you want to color area below spline
                  SplineSeries<ChartData, DateTime>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      //color - provide color for area
                      dataSource: chartData,
                      enableTooltip: true,
                      splineType: SplineType.natural,
                      cardinalSplineTension: 0.5,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.diamond,
                        borderColor: Colors.black,
                      ),
                      dataLabelSettings: const DataLabelSettings(
                          showCumulativeValues: true,
                          isVisible: true,
                          color: Colors.blue),
                      xValueMapper: (ChartData data, _) => data.dateTime,
                      yValueMapper: (ChartData data, _) => data.value),
                  //animationDuration: 1000
                ],
            ),
          ),
        );
      },
    );
  }
}