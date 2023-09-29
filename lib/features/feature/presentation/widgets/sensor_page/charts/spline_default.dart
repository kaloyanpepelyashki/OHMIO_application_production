import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../bloc/PinTunnelBloc.dart';
import '../../../bloc/PinTunnelEvent.dart';
import '../../../bloc/PinTunnelState.dart';

class SplineDefault extends StatefulWidget {
  final String mac_address;
  final String timeFilter;

  SplineDefault(
      {required this.mac_address, required this.timeFilter, super.key});

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
    // if(timeFilter.toUpperCase() == "LIVE"){
    // BlocProvider.of<PinTunnelBloc>(context)
    //    .add(const SubscribeChannel(sensorId: 12345));
    //}
    if (timeFilter.toUpperCase() == "DAY") {
      print(widget.mac_address);
      BlocProvider.of<PinTunnelBloc>(context)
          .add(GetDailyData(sensorId: int.parse(widget.mac_address)));
    }
    if (timeFilter.toUpperCase() == "WEEK") {
      BlocProvider.of<PinTunnelBloc>(context)
          .add(GetWeeklyData(sensorId: int.parse(widget.mac_address)));
    }
    if (timeFilter.toUpperCase() == "MONTH") {
      BlocProvider.of<PinTunnelBloc>(context)
          .add(GetMonthlyData(sensorId: int.parse(widget.mac_address)));
    }
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
                  dateTime: DateTime(dateTime.year, dateTime.month, dateTime.day,
                      dateTime.hour, dateTime.minute, dateTime.second),
                  value: double.parse(
                    record['data'].toString(),
                  ),
                ),
              );
            }
          } else {
            DateTime dateTime = DateTime.parse(state.payload['new']['time']);
            print("STATE PAYLOAD ${state.payload['new']['data']}");
            chartData.add(ChartData(
                dateTime: DateTime(dateTime.year, dateTime.month, dateTime.day,
                    dateTime.hour, dateTime.minute, dateTime.second),
                value: state.payload['new']['data']));
        //    _chartSeriesController?.updateDataSource(
          //    addedDataIndexes: <int>[chartData.length - 1],
          //  );
          }
        }
        */

        if (state is DailyDataReceivedState &&
            timeFilter.toUpperCase() == "DAY" &&
            state.data.isNotEmpty) {
          print("SPLINE_DEFAULT: DAILY PAYLOAD ");
          for (var record in state.data) {
            chartData.add(record);
          }
          //chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        }

        if (state is WeeklyDataReceivedState &&
            timeFilter.toUpperCase() == "WEEK" &&
            state.data.isNotEmpty) {
          for (var record in state.data) {
            print("WEEKLY RECORD: ${record.dateTime}");
            chartData.add(record);
          }
          //chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        }

        if (state is MonthlyDataReceivedState &&
            timeFilter.toUpperCase() == "MONTH" &&
            state.data.isNotEmpty) {
          for (var record in state.data) {
            chartData.add(record);
          }
          //  chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
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
                      xValueMapper: (ChartData data, _) => data.dateTime,
                      yValueMapper: (ChartData data, _) => data.value),
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
