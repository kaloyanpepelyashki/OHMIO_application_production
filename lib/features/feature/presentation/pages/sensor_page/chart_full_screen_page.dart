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
  String selectedFilter = 'live';
  
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
                    onPressed: () {
                      _openWidget("live");
                      selectedFilter = "live";
                    },
                    style: selectedFilter == "live" ? const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color(0xFF551C50)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ) : const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: Text("Live"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _openWidget("minute");
                      selectedFilter = "minute";
                    },
                    style: selectedFilter == "minute" ? const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color(0xFF551C50)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ) : const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: Text("Minute"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _openWidget("day");
                      selectedFilter = "day";
                      
                      //_openWidget("day");
                    },
                    style: selectedFilter =="day" ? const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color(0xFF551C50)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ) : const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: Text("Day"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _openWidget("week");
                      selectedFilter = "week";
                    },
                   style: selectedFilter =="week" ? const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color(0xFF551C50)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ) : const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: Text("Week"),
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
      GlobalKey<RangeAreaState> rangeAreaKey = GlobalKey<RangeAreaState>();
      setState(() {
        chartToDisplay = RangeArea(key: rangeAreaKey, timeFilter: filter);
      });
    }
  }
}
