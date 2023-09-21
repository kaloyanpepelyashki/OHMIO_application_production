import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/chart_full_screen_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/choose_chart_type_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/sensor_action_config.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/temperature_sensor_widget.dart';

import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelEvent.dart';
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
  late Widget splineDefault;
  late Widget rangeArea;
  final Widget temperatureSensorWidget = TemperatureSensorWidget();

  List<Widget> carouselItems = [];
  List<Widget> sensorChartItems = [];

  bool isChartPage = true;

  String selectedFilter = 'live';

  double carouselSliderHeight = 400;

  @override
  void initState() {
    super.initState();
    rangeArea = RangeArea(
      timeFilter: selectedFilter, /*key: rangeAreaKey*/
    );
    splineDefault = SplineDefault(timeFilter: selectedFilter);
    carouselItems = [splineDefault, temperatureSensorWidget];
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
              Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              selectedFilter = 'live';
                              changeChartsBasedOnFilter("live");
                            },
                            child: Text("Live"),
                            style: selectedFilter == "live"
                                ? const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF551C50)),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  )
                                : const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                  ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              selectedFilter = 'minute';
                              changeChartsBasedOnFilter("minute");
                            },
                            child: Text("Minute"),
                            style: selectedFilter == "minute"
                                ? const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF551C50)),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  )
                                : const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                  ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              selectedFilter = 'hour';
                              changeChartsBasedOnFilter("hour");
                            },
                            child: Text("Hour"),
                            style: selectedFilter == "hour"
                                ? const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF551C50)),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  )
                                : const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                  ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              selectedFilter = 'day';
                              changeChartsBasedOnFilter("Day");
                            },
                            child: Text("Day"),
                            style: selectedFilter == "day"
                                ? const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF551C50)),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  )
                                : const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                  ),
                          ),
                        ],
                      ),
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: const BoxDecoration(
                                        color: Color(0x00f9961e)),
                                    child: i);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  isChartPage
                      ? Positioned(
                          top: 50,
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
                                        carouselItems[0] =
                                            SplineDefault(timeFilter: 'day');
                                      });
                                    }
                                    if (result == "range area chart") {
                                      setState(() {
                                        carouselItems[0] = RangeArea(
                                          timeFilter: 'day',
                                        );
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
        ),);
  }

  void changeChartsBasedOnFilter(String filter) {
    GlobalKey<SplineDefaultState> splineDefaultKey =
        GlobalKey<SplineDefaultState>();
    if (carouselItems[0] is SplineDefault) {
      setState(() {
        carouselItems[0] =
            SplineDefault(key: splineDefaultKey, timeFilter: filter);
      });
    } else if (carouselItems[0] is RangeArea) {
      setState(() {
        carouselItems[0] = RangeArea(key: splineDefaultKey, timeFilter: filter);
      });
    }
  }
}
