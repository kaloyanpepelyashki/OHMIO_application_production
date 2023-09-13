import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/sensor_page/action_popup.dart';

import '../../../domain/entities/action_class.dart';
import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelEvent.dart';

class ActionWidget extends StatelessWidget {
  final ActionClass actionClass;
  int actionNumber;
  final BuildContext context;
  final Function onDelete;

  ActionWidget({
    required this.context,
    required this.actionClass,
    required this.actionNumber,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Action $actionNumber"),
            GestureDetector(
              child: const FaIcon(FontAwesomeIcons.trash),
              onTap: () {
                onDelete(actionNumber - 1);
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: 290,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 152, 151, 151),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Temperature"),
                        Text(
                            "${actionClass.condition!} ${actionClass.conditionValue}"),
                      ],
                    ),
                    const Divider(
                      height: 10,
                      thickness: 2,
                      indent: 3,
                      endIndent: 3,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Action: "),
                        Text(actionClass.action!),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                padding: const EdgeInsets.all(10),
                child: Text(
                    '''If the temperature values is ${actionClass.condition}
                ${actionClass.conditionValue} then the device will ${actionClass.action}'''),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
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
  List<ActionWidget> actions = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 216, 215, 215),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Setting your device"),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.plus,
                        size: 30,
                      ),
                      onPressed: () async {
                        final actionClass = await showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) =>
                                ActionPopup(context: context));
                        if (actionClass != null) {
                          setState(
                            () => actions.add(
                              ActionWidget(
                                  actionClass: actionClass,
                                  actionNumber: actions.length + 1,
                                  context: context,
                                  onDelete: (index) {
                                    setState(() {
                                      actions.removeAt(index);
                                    });
                                    if (index > 0) updateActionNumbers(index);
                                  }),
                            ),
                          );
                          sendActionToDatabase(actionClass);
                        }
                      },
                    ),
                  ],
                ),
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

//Related to the block
  void updateActionNumbers(int index) {
    for (var i = index; i < actions.length; i++) {
      setState(() {
        actions[i].actionNumber = actions.indexOf(actions[i]) + 1;
      });
    }
  }

  void sendActionToDatabase(ActionClass actionClass) {
    print("In sendActionToDatabase");
    BlocProvider.of<PinTunnelBloc>(context)
        .add(AddAction(actionClass: actionClass));
  }
}
