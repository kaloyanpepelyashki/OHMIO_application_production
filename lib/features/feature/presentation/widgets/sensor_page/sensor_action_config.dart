import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/action_popup.dart';

import '../../../domain/entities/action_class.dart';

class ActionWidget extends StatelessWidget {
  final ActionClass actionClass;
  
  ActionWidget({
    required this.actionClass,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      //color: Colors.lightBlue[50],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(this.actionClass.action!),
              FaIcon(FontAwesomeIcons.trash),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Temperature"),
              Text(this.actionClass.condition! +
                  " " +
                  this.actionClass.conditionValue.toString()),
            ],
          )
        ],
      ),
    );
  }
}

class SensorActionConfig extends StatefulWidget {
  const SensorActionConfig({super.key});

  @override
  State<SensorActionConfig> createState() => _SensorActionConfigState();
}

class _SensorActionConfigState extends State<SensorActionConfig> {

  List<Widget> actions = [
    Container(
      width: 150,
      height: 100,
      //color: Colors.lightBlue[50],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Action 1"),
              FaIcon(FontAwesomeIcons.trash),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Temperature"),
              Text("> 32"),
            ],
          )
        ],
      ),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        //color: Colors.lightBlue[300],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Setting your device"),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                    ),
                    onPressed: () async {
                      final actionClass = await showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              ActionPopup(context: context));
                      setState(() => 
                            actions.add(
                              ActionWidget(actionClass: actionClass),
                            ),
                          );
                    },
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [...actions],
                ),
              ),
            ],
          ),
        ));
  }
}
