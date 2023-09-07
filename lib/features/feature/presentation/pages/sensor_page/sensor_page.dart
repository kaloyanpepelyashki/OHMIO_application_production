import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/line_chart_general.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/line_chart_hourly.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/line_chart_minute.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/sensor_action_config.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/temperature_sensor_widget.dart';

import '../../widgets/top_bar_back_action.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  final Widget lineChartWidget = LineChartGeneral();
  final Widget lineChartMinute = LineChartMinute();
  final Widget lineChartHourly = LineChartHourly();

  List<Widget> carouselItems = [];
  List<Widget> sensorChartItems = [];

  int chartItemIndex = 0;

  @override
  void initState() {
    super.initState();
    carouselItems = [lineChartWidget, TemperatureSensorWidget()];
    sensorChartItems = [lineChartWidget, lineChartHourly, lineChartMinute,];
  }


  final CarouselController _carouselController = CarouselController();
  String sensorName = "temperature sensor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBarBackAction(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(sensorName),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      if(chartItemIndex != 0){
                        carouselItems[0] = sensorChartItems[0],
                        setState((){
                           chartItemIndex = 0;
                        })
                      }
                    },
                    child: Text('Live'),
                  ),
                  SizedBox(width: 10),
        
                  ElevatedButton(
                    onPressed: () =>{
                      if(chartItemIndex != 1){
                        carouselItems[0] = sensorChartItems[1],
                        setState((){
                          chartItemIndex = 1;
                        })
                      }
                    },
                    child: Text('Hour'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => {
                      if(chartItemIndex != 2){
                        carouselItems[0] = sensorChartItems[2],
                        setState((){
                          chartItemIndex = 2;
                        })
                      }
                    },
                    child: Text('Minute'),
                  )
                ],
              ),
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 300.0,
                  enableInfiniteScroll: false,
                  aspectRatio: MediaQuery.of(context).size.width,
                  viewportFraction: 1.0,
                ),
                items: carouselItems.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.sizeOf(context).width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Color(0xF9961E)),
                          child: i);
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _carouselController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear),
                    child: Text('←'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _carouselController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear),
                    child: Text('→'),
                  )
                ],
              ),
              SensorActionConfig(
                context: context,
              )
            ],
          ),
        )
        //LineChartGeneral(),
        //TemperatureSensorWidget(),
        /* Column(
        children: [
          TemperatureSensorWidget(),
          LineChartGeneral()
        ],
      ),*/
        );
  }
}
/*
class _InfoValueString extends StatelessWidget {
  const _InfoValueString({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  final String title;
  final Object? value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: '$title ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '$value',
              )
            ],
          ),
        ),
      );
}
*/