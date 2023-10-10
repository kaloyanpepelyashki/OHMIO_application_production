import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpWidget extends StatefulWidget {
  const HelpWidget({super.key});

  @override
  State<HelpWidget> createState() => HelpWidgetState();
}

class HelpWidgetState extends State<HelpWidget> {
  bool openedHelpPanel = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TapRegion(
          onTapInside: (tap) {
            setState(() {
              openedHelpPanel = true;
            });
          },
          onTapOutside: (tap) {
            setState(() {
              openedHelpPanel = false;
            });
          },
          child: openedHelpPanel
              ? OpenedHelpPanel(onClose: () {
                  setState(() {
                    openedHelpPanel = false;
                  });
                })
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Text(
                        "HELP",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class OpenedHelpPanel extends StatefulWidget {
  final Function onClose;
  const OpenedHelpPanel({super.key, required this.onClose});

  @override
  State<OpenedHelpPanel> createState() => _OpenedHelpPanelState();
}

class _OpenedHelpPanelState extends State<OpenedHelpPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,200,0,0),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    size: 100,
                  ),
                  SizedBox(height: 30),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sensor: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          )),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                        child: Text(
                            " a device that measures the environment around you."),
                      )),
                    ],
                  ),
                  SizedBox(height: 25),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Actuator: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                          child: Text(
                              " a device that can interact with the environment around you, it can be a lamp, switch or speaker."),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 300,
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Text("•", style: TextStyle(fontSize: 30)),
                            Flexible(
                              child: Text(
                                  "Cras tempor eros velit, eget iaculis sem lauctor pharetre"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("•", style: TextStyle(fontSize: 30)),
                            Flexible(
                              child: Text(
                                  "Cras tempor eros velit, eget iaculis sem ]auctor pharetre"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("•", style: TextStyle(fontSize: 30)),
                            Flexible(
                              child: Text(
                                  "Cras tempor eros velit, eget iaculis sem ]auctor pharetra"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.onClose();
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FaIcon(
                    FontAwesomeIcons.arrowDown,
                    size: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "HELP",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
