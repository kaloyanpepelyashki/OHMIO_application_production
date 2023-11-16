import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/mqtt_slot_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/mqtt_test.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

import '../../data/data_sources/mqtt_manager.dart';

class MqttPage extends StatefulWidget {
  MqttPage({super.key});

  final StreamController<Map<String, String>> _controller =
      StreamController<Map<String, String>>();

  @override
  State<MqttPage> createState() => _MqttPageState();
}

class _MqttPageState extends State<MqttPage> {
  late MqttManager mqttManager;
  late MqttServerClient mqttClient;
  late Map<String, int> mqttData = {};
  late Map<String, StreamController<dynamic>> streamControllers = {};

  // late StreamController<Map<String, String>> _controller;

  @override
  void initState() {
    super.initState();
    //Call the class members in the component
    // mqttManager = MqttManager(
    //   brokerUrl: "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
    //   port: 8883,
    //   clientIdentifier: "Kalos1",
    //   topic: "UUID/app",
    // );

    mqttManager = MqttManager(
      brokerUrl: "wss://mqtt.ohmio.org",
      port: 8883,
      clientIdentifier: "TesttOHMIOApp",
      topic: "UUID/App",
    );
    mqttClient = mqttManager.mqttClient;
    mqttData = mqttManager.mqttData;

    //Call the class methods in the component
    mqttManager.establishConnection(
        authUser: "ohmio", authPassword: "9aRUBZ9SETTLzYK");

    streamControllers = mqttManager.streamControllers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const TopBarBackAction(),
        body: CustomScrollView(primary: false, slivers: [
          SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                  children: [
                    for (String key in streamControllers.keys)
                      StreamBuilder(
                        stream: streamControllers[key]!.stream,
                        builder: (context, snapshot) {
                          return ListTile(
                            title: Text('$key: ${snapshot.data}'),
                          );
                        },
                      )

                    // children: mqttData.entries.map((entry) {
                    //   return MqttSlotComponent(
                    //       topic: entry.key, value: entry.value);
                    // }).toList()
                    // StreamBuilder<Map<String, String>>(
                    //   stream: _controller.stream,
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<Map<String, String>> snapshot) {
                    //     if (snapshot.hasData) {
                    //       return Text("${snapshot.data}");
                    //     } else {
                    //       return Text("nothing");
                    //     }
                    //   },
                    // )
                    // MQTTTEST(
                    //     brokerUrl:
                    //         "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
                    //     port: 8883,
                    //     topic: "test/ebits/1",
                    //     authUser: "testtest",
                    //     authPass: "12345678",
                    //     clientIdentifier: "Kalos1"),
                    // MQTTTEST(
                    //     brokerUrl:
                    //         "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
                    //     port: 8883,
                    //     topic: "test/ebits/2",
                    //     authUser: "testtest2",
                    //     authPass: "Eb123456",
                    //     clientIdentifier: "Kalos223"),
                    // MQTTTEST(
                    //     brokerUrl:
                    //         "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
                    //     port: 8883,
                    //     topic: "test/ebits/3",
                    //     authUser: "testtest3",
                    //     authPass: "Eb123456",
                    //     clientIdentifier: "Kalos333"),
                    // MQTTTEST(
                    //     brokerUrl:
                    //         "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
                    //     port: 8883,
                    //     topic: "test/ebits/2",
                    //     authUser: "testtest2",
                    //     authPass: "Eb123456",
                    //     clientIdentifier: "Kalos4444"),
                  ]))
        ]));
    ;
  }
}
