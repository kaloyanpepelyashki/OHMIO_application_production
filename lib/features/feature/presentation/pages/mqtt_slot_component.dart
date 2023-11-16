import 'package:flutter/material.dart';

class MqttSlotComponent extends StatefulWidget {
  late String value;
  late String topic;
  MqttSlotComponent({super.key, required this.value, required this.topic});

  @override
  State<MqttSlotComponent> createState() => _MqttSlotComponentState();
}

class _MqttSlotComponentState extends State<MqttSlotComponent> {
  String value = "";
  String topic = "";

  @override
  void initState() {
    super.initState();

    value = widget.value;
    topic = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 170,
        width: 160,
        color: Colors.red,
        child: Center(
          child: Column(children: [
            Text(value),
            Text(topic),
          ]),
        ));
  }
}
