import 'package:flutter/material.dart';

import '../components/elevated_button_component.dart';
import '../components/inputField_with_heading.dart';
import '../components/top_bar_back_action.dart';

class RetreiveTunnelMACPage extends StatefulWidget {
  const RetreiveTunnelMACPage({super.key});

  @override
  State<RetreiveTunnelMACPage> createState() => _RetreiveTunnelMACPageState();
}

class _RetreiveTunnelMACPageState extends State<RetreiveTunnelMACPage> {
  final TextEditingController _macAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBarBackAction(),
        body: Center(
            child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 0.8,
                child: Column(
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(fontSize: 40, letterSpacing: 17),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: InputFieldWithHeading(
                                controller: _macAddressController,
                                heading: "Let's find your device",
                                placeHolder: "MAC Address",
                              )),
                        ])),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ElevatedButtonComponent(
                          onPressed: () {},
                          text: "Next",
                        )),
                  ],
                ))));
  }
}
