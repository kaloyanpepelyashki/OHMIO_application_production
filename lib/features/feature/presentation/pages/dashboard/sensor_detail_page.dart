import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/help_widget.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/sensor_class.dart';

class SensorDetailPage extends StatelessWidget {
  final String? isActuator;
  final String? sensorImage;
  final String sensorName;
  final String? sensorDescription;

  const SensorDetailPage({
    this.isActuator,
    this.sensorImage,
    required this.sensorName,
    this.sensorDescription,
    super.key,
  });

  /*late String sensorImage;
  late bool isActuator;
  late String sensorName;
  late String sensorDescription;


  @override
  void initState() {
    super.initState();
    sensorImage = widget.sensorClass.sensorImage!;
    isActuator = widget.sensorClass.isActuator!;
    sensorName = widget.sensorClass.sensorName!;
    sensorDescription = widget.sensorClass.sensorDescription!;
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarBackAction(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20, 20.0, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sensorImage != null
                    ? Image(
                        image: AssetImage('assets/${sensorImage}'),
                        width: 140,
                        height: 140,
                      )
                    : SizedBox(),
                Container(
                  width: 166,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 8, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sensorName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Type: ",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              isActuator == null
                                  ? ""
                                  : (isActuator!.toUpperCase() == "TRUE"
                                      ? "actuator"
                                      : "sensor"),
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Max sensitivity: ",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(""),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Output: ",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        sensorDescription == null ? "" : sensorDescription!,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 194,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push("/sensorConnectFirstPage");
                },
                child: Text(
                  "Connect",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 29,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: 194,
              height: 44,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFDF9C1E)),
                ),
                onPressed: () => launchUrl(
                    Uri.https('ebits.dk', 'products/temperatur-sensor-analog')),
                child: Text(
                  "Buy",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //  HelpWidget(),
      //],
      // ),
    );
  }
}
