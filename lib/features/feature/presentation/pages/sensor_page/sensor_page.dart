import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/chart_full_screen_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/choose_chart_type_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/back_action_btn.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/sensor_action_config.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/temperature_sensor_widget.dart';

import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelEvent.dart';
import '../../widgets/sensor_page/charts/line_chart_general.dart';
import '../../widgets/sensor_page/charts/range_area.dart';
import '../../widgets/sensor_page/charts/spline_default.dart';
import '../../widgets/top_bar_back_action.dart';

class SensorPage extends StatefulWidget {
  final String? mac_address;

  const SensorPage({
    required this.mac_address,
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

  String selectedFilter = 'day';

  double carouselSliderHeight = 300;
  String? mac_address;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    rangeArea = RangeArea(
      timeFilter: selectedFilter, /*key: rangeAreaKey*/
    );
    mac_address = widget.mac_address;
    splineDefault =
        SplineDefault(timeFilter: selectedFilter, mac_address: mac_address!);
    carouselItems = [splineDefault, temperatureSensorWidget];
  }

  final CarouselController _carouselController = CarouselController();
  String sensorName = "temperature sensor";
  double sensorValue = 0;

  Widget _buildButton(String label, String filter, String mac_address) {
    return ElevatedButton(
      child: Text(label, style: TextStyle(color: Colors.black)),
      style: selectedFilter == filter
          ? const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF551C50)),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
            )
          : const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              foregroundColor: MaterialStatePropertyAll(Colors.black),
            ),
      onPressed: () {
        selectedFilter = filter;
        changeChartsBasedOnFilter(filter, mac_address);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          appBar: orientation == Orientation.landscape
              ? AppBar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  leading: BackActionBtn(
                      icon: Icons.arrow_back,
                      onPressed: () {
                        //Removes layer from the navigation stack

                        GoRouter.of(context).pop();
                      }),
                  leadingWidth: 100,
                  title: Row(
                    children: [
                      SizedBox(width: 150),
                      _buildButton('Day', 'day', mac_address!),
                      SizedBox(width: 15), // Add space between buttons
                      _buildButton('Week', 'week', mac_address!),
                      SizedBox(width: 15), // Add space between buttons
                      _buildButton('Month', 'month', mac_address!),
                    ],
                  ),
                )
              : const TopBarBackAction(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                orientation == Orientation.landscape
                    ? SizedBox()
                    : Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(sensorName.toUpperCase(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                              Text("Living Room", style: TextStyle(fontSize: 18)),
                            
                            ],
                          ),
                      ),
                    ),
                Text(sensorValue.toString() + '°C', style: TextStyle(fontSize: 55)),
                SizedBox(height: 10),
                Divider(color: Colors.black, height: 10, thickness: 2, indent: 30, endIndent: 30,),
                SizedBox(height: 15),
                Stack(
                  children: [
                    Column(
                      children: [
                        orientation == Orientation.landscape
                            ? SizedBox()
                            : Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        selectedFilter = 'day';
                                        changeChartsBasedOnFilter(
                                            "day", mac_address!);
                                      },
                                      child: Text("Day"),
                                      style: selectedFilter == "day"
                                          ? const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xFFDD6E42)),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white),
                                            )
                                          : const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.black),
                                            ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        selectedFilter = 'week';
                                        changeChartsBasedOnFilter(
                                            "week", mac_address!);
                                      },
                                      child: Text("Week"),
                                      style: selectedFilter == "week"
                                          ? const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xFFDD6E42)),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white),
                                            )
                                          : const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.black),
                                            ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        selectedFilter = 'month';
                                        changeChartsBasedOnFilter(
                                            "month", mac_address!);
                                      },
                                      child: Text("Month"),
                                      style: selectedFilter == "month"
                                          ? const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xFFDD6E42)),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white),
                                            )
                                          : const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.black),
                                            ),
                                    ),
                                  ],
                                ),
                            ),
                        Container(
                          height: orientation == Orientation.landscape
                              ? MediaQuery.of(context).size.height * 0.75
                              : carouselSliderHeight,
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: orientation == Orientation.landscape
                                  ? MediaQuery.of(context).size.height * 0.75
                                  : carouselSliderHeight,
                              enableInfiniteScroll: false,
                              disableCenter: true,
                              viewportFraction: 1.0,
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                            ),
                            items: carouselItems.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0),
                                    child: Container(
                                        height: orientation ==
                                                Orientation.landscape
                                            ? MediaQuery.of(context).size.height *
                                                0.75
                                            : carouselSliderHeight,
                                        width: MediaQuery.sizeOf(context).width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: const BoxDecoration(
                                            color: Color(0x00f9961e)),
                                        child: i),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    /* isChartPage
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
                                              chartWidget: carouselItems[0], mac_address: widget.mac_address!)));
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
                                                SplineDefault(timeFilter: 'live', mac_address: widget.mac_address!);
                                          });
                                        }
                                        if (result == "range area chart") {
                                          setState(() {
                                            carouselItems[0] = RangeArea(
                                              timeFilter: 'live',
                                            );
                                          });
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),*/
                  ],
                ),
                /*Row(
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
                  )*/
              ],
            ),
          ),
        );
      },
    );
  }

  void changeChartsBasedOnFilter(String filter, String mac_address) {
    GlobalKey<SplineDefaultState> splineDefaultKey =
        GlobalKey<SplineDefaultState>();
    if (carouselItems[0] is SplineDefault) {
      setState(() {
        carouselItems[0] = SplineDefault(
            key: splineDefaultKey,
            timeFilter: filter,
            mac_address: mac_address);
      });
    } else if (carouselItems[0] is RangeArea) {
      setState(() {
        carouselItems[0] = RangeArea(key: splineDefaultKey, timeFilter: filter);
      });
    }
  }
}
