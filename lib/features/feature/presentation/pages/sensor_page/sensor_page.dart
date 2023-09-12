import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/chart_full_screen_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/choose_chart_type_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/sensor_action_config.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/temperature_sensor_widget.dart';

import '../../widgets/sensor_page/charts/line_chart_general.dart';
import '../../widgets/sensor_page/charts/range_area.dart';
import '../../widgets/sensor_page/charts/spline_default.dart';
import '../../widgets/top_bar_back_action.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  //GlobalKey<RangeAreaState> rangeAreaKey = GlobalKey<RangeAreaState>();

  final Widget lineChartWidget = const LineChartGeneral();
  final Widget splineDefault = const SplineDefault();
  late Widget rangeArea;
  final Widget temperatureSensorWidget = TemperatureSensorWidget();

  List<Widget> carouselItems = [];
  List<Widget> sensorChartItems = [];

  int chartItemIndex = 0;
  bool isChartPage = true;

  double carouselSliderHeight = 400;

  @override
  void initState() {
    super.initState();
    rangeArea = RangeArea(
      timeFilter: 'month', /*key: rangeAreaKey*/
    );
    carouselItems = [splineDefault, temperatureSensorWidget];
    sensorChartItems = [
      splineDefault,
      rangeArea
      // lineChartWidget,
      // lineChartHourly,
      // lineChartMinute,
    ];
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
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      if (chartItemIndex != 0)
                        {
                          carouselItems[0] = sensorChartItems[0],
                          setState(() {
                            chartItemIndex = 0;
                          })
                        }
                    },
                    child: const Text('spline chart'),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      if (chartItemIndex != 1)
                        {
                          carouselItems[0] = sensorChartItems[1],
                          setState(() {
                            chartItemIndex = 1;
                          })
                        }
                    },
                    child: const Text('range area chart'),
                  ),
                ],
              ),
              /*Wrap(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      if (chartItemIndex != 0)
                        {
                          carouselItems[0] = sensorChartItems[0],
                          setState(() {
                            chartItemIndex = 0;
                          })
                        }
                    },
                    child: const Text('Live'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => {
                      if (chartItemIndex != 1)
                        {
                          carouselItems[0] = sensorChartItems[1],
                          setState(() {
                            chartItemIndex = 1;
                          })
                        }
                    },
                    child: const Text('Hour'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => {
                      if (chartItemIndex != 2)
                        {
                          carouselItems[0] = sensorChartItems[2],
                          setState(() {
                            chartItemIndex = 2;
                          })
                        }
                    },

                    //child: Text('Minute'),
                    child: const Text('minute'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => {
                      if (chartItemIndex != 3)
                        {
                          carouselItems[0] = sensorChartItems[3],
                          setState(() {
                            chartItemIndex = 3;
                          })
                        }
                    },
                    child: const Text('spline chart'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => {
                      if (chartItemIndex != 4)
                        {
                          carouselItems[0] = sensorChartItems[4],
                          setState(() {
                            chartItemIndex = 4;
                          })
                        }
                    },
                    child: const Text('range area chart'),
                  )
                  
                ],
              ),*/
              Stack(
                children: [
                  Container(
                    child: CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: carouselSliderHeight,
                        enableInfiniteScroll: false,
                        disableCenter: true,
                        viewportFraction: 1.0,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                      ),
                      items: carouselItems.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                height: carouselSliderHeight,
                                width: MediaQuery.sizeOf(context).width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: const BoxDecoration(
                                    color: Color(0x00f9961e)),
                                child: i);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  isChartPage
                      ? Positioned(
                          top: 10,
                          right: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.upRightAndDownLeftFromCenter,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (carouselSliderHeight != 400)
                                      carouselSliderHeight = 400;
                                    else
                                      carouselSliderHeight =
                                          MediaQuery.of(context).size.height -
                                              200;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.rotate,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChartFullScreenPage(
                                          chartWidget: carouselItems[0])));
                                },
                              ),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ChooseChartTypePage()))
                                      .then((result) {
                                    if (result == "spline chart") {
                                      setState(() {
                                        carouselItems[0] = SplineDefault();
                                      });
                                    }
                                    if (result == "range area chart") {
                                      setState(() {
                                        carouselItems[0] = RangeArea(timeFilter: 'month',);
                                      });
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      _carouselController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear),
                      Future.delayed(Duration(milliseconds: 800), () {
                        setState(() {
                          isChartPage = true;
                        });
                        // isChartPage = true;
                      })
                    },
                    child: const Text('←'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => {
                      _carouselController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear),
                      setState(() {
                        isChartPage = false;
                      })
                    },
                    child: const Text('→'),
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