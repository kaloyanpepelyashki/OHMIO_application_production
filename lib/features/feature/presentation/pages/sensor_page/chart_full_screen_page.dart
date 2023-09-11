import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/charts/range_area.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';

import '../../widgets/top_bar_rotated_back_action.dart';

class ChartFullScreenPage extends StatefulWidget {
  final Widget chartWidget;

  const ChartFullScreenPage({required this.chartWidget, super.key});

  @override
  State<ChartFullScreenPage> createState() => _ChartFullScreenPageState();
}

class _ChartFullScreenPageState extends State<ChartFullScreenPage> {

  late dynamic chartToDisplay;
   GlobalKey<RangeAreaState> rangeAreaKey = GlobalKey<RangeAreaState>();

  @override
  void initState(){
    chartToDisplay = widget.chartWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarRotatedBackAction(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: Container(
              width: MediaQuery.sizeOf(context).height,
              height: MediaQuery.sizeOf(context).width,
              child: chartToDisplay,
            ),
          ),
          Positioned(
            width: 200,
            top: 0,
            right: 80,
            child: RotatedBox(
              quarterTurns: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Month"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: Text("Week"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        chartToDisplay = RangeArea(key: rangeAreaKey, timeFilter: "day");
                      });
                      
                      //_openWidget("day");
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: Text("Day"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    
  }

  _openWidget(String filter){
    if(widget.chartWidget is RangeArea){
      setState(() {
        chartToDisplay = RangeArea(timeFilter: filter);
      });
    }
  }
}
