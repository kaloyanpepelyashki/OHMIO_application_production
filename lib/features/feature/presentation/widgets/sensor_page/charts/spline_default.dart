import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../bloc/PinTunnelBloc.dart';
import '../../../bloc/PinTunnelEvent.dart';
import '../../../bloc/PinTunnelState.dart';

class SplineDefault extends StatefulWidget {
  final String timeFilter;
  SplineDefault({required this.timeFilter, super.key});

  @override
  State<SplineDefault> createState() => SplineDefaultState();
}

class SplineDefaultState extends State<SplineDefault> {
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late String timeFilter;
  ChartSeriesController? _chartSeriesController;

  List<ChartData> chartData = [];

  @override
  initState() {
    // BlocProvider.of<PinTunnelBloc>(context)
    //     .add(const SubscribeMinuteChannel(sensorId: 12345));
    timeFilter = widget.timeFilter;
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'reading');
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x,
    );
    chartData.clear();
    if(timeFilter.toUpperCase() == "LIVE"){
      BlocProvider.of<PinTunnelBloc>(context)
        .add(const SubscribeChannel(sensorId: 12345));
    }
    if(timeFilter.toUpperCase() == "MINUTE"){
      BlocProvider.of<PinTunnelBloc>(context)
        .add(const SubscribeMinuteChannel(sensorId: 12345));
    }
    if(timeFilter.toUpperCase() == "HOUR"){
      BlocProvider.of<PinTunnelBloc>(context)
        .add(const SubscribeHourlyChannel(sensorId: 12345));
    }
    if(timeFilter.toUpperCase() == "DAY"){
      BlocProvider.of<PinTunnelBloc>(context)
        .add(const SubscribeDailyChannel(sensorId: 12345));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
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

        if (state is MinutePayloadReceivedState &&
            timeFilter.toUpperCase() == "MINUTE" &&
            state.payload != null) {
          print("MINUTE PAYLOAD SPLIE DEFAULT ${state.payload}");
          if (state.payload.containsKey('sensor_data')) {
            for (var record in state.payload['sensor_data']) {
              DateTime dateTime = DateTime.parse(record['created_at']);
              chartData.add(ChartData(
                  DateTime(dateTime.year, dateTime.month, dateTime.day,
                      dateTime.hour, dateTime.minute, dateTime.second),
                  double.parse(record['avg'].toString())));
          //    _chartSeriesController?.updateDataSource(
           //     addedDataIndexes: <int>[chartData.length - 1],
          //    );
            }
            chartData.sort((a, b) => a.x.compareTo(b.x));
          } else {
            DateTime dateTime =
                DateTime.parse(state.payload['new']['created_at']);
            chartData.add(ChartData(
                DateTime(dateTime.year, dateTime.month, dateTime.day,
                    dateTime.hour, dateTime.minute, dateTime.second),
                state.payload['new']['avg']));
          //  _chartSeriesController?.updateDataSource(
          //    addedDataIndexes: <int>[chartData.length - 1],
          //  );
          }
        }

        if (state is HourlyPayloadReceivedState &&
            timeFilter.toUpperCase() == "HOUR" &&
            state.payload != null) {
          if (state.payload.containsKey('sensor_data')) {
            for (var record in state.payload['sensor_data']) {
              DateTime dateTime = DateTime.parse(record['created_at']);
              chartData.add(ChartData(
                  DateTime(dateTime.year, dateTime.month, dateTime.day,
                      dateTime.hour, dateTime.minute, dateTime.second),
                  double.parse(record['avg'].toString())));
           //   _chartSeriesController?.updateDataSource(
          //      addedDataIndexes: <int>[chartData.length - 1],
           //   );
            }
            chartData.sort((a, b) => a.x.compareTo(b.x));
          } else {
            DateTime dateTime =
                DateTime.parse(state.payload['new']['created_at']);
            chartData.add(ChartData(
                DateTime(dateTime.year, dateTime.month, dateTime.day,
                    dateTime.hour, dateTime.minute, dateTime.second),
                state.payload['new']['avg']));
          //  _chartSeriesController?.updateDataSource(
          //    addedDataIndexes: <int>[chartData.length - 1],
          ///  );
          }
        }

        if (state is DailyPayloadReceivedState &&
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
            chartData.sort((a, b) => a.x.compareTo(b.x));
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
        return Scaffold(
          body: Center(
            child: Container(
              child: SfCartesianChart(
                zoomPanBehavior: _zoomPanBehavior,
                tooltipBehavior: _tooltipBehavior,
                primaryXAxis: DateTimeAxis(
                  rangePadding: ChartRangePadding.round,
                  labelAlignment: LabelAlignment.end,
                  autoScrollingDelta: 10,
                  autoScrollingMode: AutoScrollingMode.end,
                  interactiveTooltip: const InteractiveTooltip(
                      // Displays the x-axis tooltip
                      enable: true,
                      borderColor: Colors.red,
                      borderWidth: 2),
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                  minimum: 0.0,
                  maximum: 100.0,
                  decimalPlaces: 2,
                  labelAlignment: LabelAlignment.center,
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
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y),
                  //animationDuration: 1000
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
