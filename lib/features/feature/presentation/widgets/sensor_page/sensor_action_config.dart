import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/action_popup.dart';

import '../../../domain/entities/action_class.dart';
import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelEvent.dart';

class ActionWidget extends StatelessWidget {
  final ActionClass actionClass;
  final BuildContext context;
  
  ActionWidget({
    required this.context,
    required this.actionClass,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
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

  final BuildContext context;

  const SensorActionConfig({required this.context, super.key});

  @override
  State<SensorActionConfig> createState() => _SensorActionConfigState();
}

class _SensorActionConfigState extends State<SensorActionConfig> {

  List<Widget> actions = [
     Container(
      width: 150,
      height: 100,
      //color: Colors.lightBlue[50],
      child: const Column(
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
                          barrierDismissible: true,
                          builder: (BuildContext context) =>
                              ActionPopup(context: context));
                      setState(() => 
                            actions.add(
                              ActionWidget(actionClass: actionClass, context: context,),
                            ),
                          );
                      sendActionToDatabase(actionClass);
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

  void sendActionToDatabase(ActionClass actionClass){
    print("In sendActionToDatabase");
    BlocProvider.of<PinTunnelBloc>(context).add(AddAction(actionClass: actionClass));
  }
}
