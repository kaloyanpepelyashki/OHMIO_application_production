import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/mqtt_test.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class MqttPage extends StatelessWidget {
  const MqttPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBarBackAction(),
        body: CustomScrollView(primary: false, slivers: [
          SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                  children: [
                    MQTTTEST(
                        brokerUrl:
                            "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
                        port: 8883,
                        topic: "test/ebits/1",
                        authUser: "testtest",
                        authPass: "12345678",
                        clientIdentifier: "Kalos1"),
                    MQTTTEST(
                        brokerUrl:
                            "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
                        port: 8883,
                        topic: "test/ebits/2",
                        authUser: "testtest2",
                        authPass: "Eb123456",
                        clientIdentifier: "Kalos223"),
                    MQTTTEST(
                        brokerUrl:
                            "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
                        port: 8883,
                        topic: "test/ebits/3",
                        authUser: "testtest3",
                        authPass: "Eb123456",
                        clientIdentifier: "Kalos333"),
                    MQTTTEST(
                        brokerUrl:
                            "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
                        port: 8883,
                        topic: "test/ebits/2",
                        authUser: "testtest2",
                        authPass: "Eb123456",
                        clientIdentifier: "Kalos4444"),
                  ]))
        ]));
  }
}
