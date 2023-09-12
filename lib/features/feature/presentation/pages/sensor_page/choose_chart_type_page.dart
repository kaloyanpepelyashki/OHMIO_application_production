import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class ChooseChartTypePage extends StatelessWidget {
  const ChooseChartTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBackAction(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        ChartType(text: "spline chart"),
        ChartType(text: "range area chart")
      ],)
    );
  }
}


class ChartType extends StatelessWidget {
  final String text;
  const ChartType({
    required this.text,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 100,
        height: 100,
        child: Text(text),
      ),
      onTap:(){
        if(text == null){
          Navigator.of(context).pop("");
        }
        else{
          Navigator.of(context).pop(text);
        }
      }
    );
  }
}