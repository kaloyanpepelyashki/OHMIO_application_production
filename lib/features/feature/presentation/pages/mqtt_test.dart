import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/mqtt_manager.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class MQTTTEST extends StatefulWidget {
  final String brokerUrl;
  final String topic;
  final int port;
  final String authUser;
  final String authPass;
  final String clientIdentifier;

  MQTTTEST(
      {super.key,
      required this.brokerUrl,
      required this.port,
      required this.topic,
      required this.authUser,
      required this.authPass,
      required this.clientIdentifier});

  @override
  State<MQTTTEST> createState() => _MQTTTESTState();
}

class _MQTTTESTState extends State<MQTTTEST> {
  late String brokerUrl;
  late String topic;
  late int port;
  late String clientIdentifier;

  late String authUser;
  late String authPassword;

  //MQTT manager object
  late MqttManager mqttManager;

  //MQTT client object
  late MqttServerClient mqttClient = mqttManager.mqttClient;

  late ValueNotifier<String> messageNotifier;

  @override
  void initState() {
    super.initState();
    brokerUrl = widget.brokerUrl;
    topic = widget.topic;
    port = widget.port;
    clientIdentifier = widget.clientIdentifier;
    authUser = widget.authUser;
    authPassword = widget.authPass;

    mqttManager = MqttManager(
        brokerUrl: brokerUrl,
        port: port,
        clientIdentifier: clientIdentifier,
        topic: topic,
        listenForChanges: listenForMessages);

    mqttManager.establishConnection(
        authUser: authUser, authPassword: authPassword);

    mqttClient.onConnected = mqttManager.onConnected();

    messageNotifier = ValueNotifier<String>("0");
  }

  late String messageToDisplay = " ";
  //Listens for messages on the subscribed topic
  void listenForMessages() {
    try {
      if (mqttClient.published != null) {
        mqttClient.published!.listen((MqttPublishMessage message) {
          debugPrint("message:: $message");
          debugPrint("messgae:: ${message.payload}");
          debugPrint("message HEADER:: ${message.payload.header}");
          final String newMessage =
              String.fromCharCodes(message.payload.message);
          messageNotifier.value = newMessage;
          setState(() {
            //Re-renders the widget state, so the message can show on screen
            //Decodes the ASCII

            messageToDisplay = String.fromCharCodes(message.payload.message);
          });
        });
      }
    } catch (e) {
      debugPrint("e");
    }
  }

  //!! <<<- OLD CODE ->>> */
//   //The topic we wish to subscribe to
//   late String mqttTopic = "test/ebits/1";
//   //Authentication crediths
//   late String authUser = "testtest";
//   late String authPass = "12345678";
//   late String clientIdentifier;

//   late MqttServerClient mqClient;

//   late String messsageToDispaly = " ";

//   @override
//   void initState() {
//     super.initState();
//     //MQTT variables
//     mqttTopic = widget.topic;
//     authUser = widget.authUser;
//     authPass = widget.authPass;
//     clientIdentifier = widget.clientIdentifier;

//     mqClient = MqttServerClient.withPort(
//         "47a9fe53d82b455a8423023b4c923c51.s2.eu.hivemq.cloud",
//         clientIdentifier,
//         8883);
//     //MQTT methods
//     mqClient.logging(on: true);
//     mqClient.secure = true;
//     mqClient.useWebSocket = true;
//     mqClient.onConnected = onConnected;
//     mqClient.onDisconnected = onDisconnected;
//     mqClient.onSubscribed = onSubscribed;
//     mqClient.onSubscribeFail = onSubscribeFail;
//     mqClient.onAutoReconnect = onAutoReconnect;
//     mqClient.pongCallback = pong;
//     mqClient.keepAlivePeriod = 60;
//     mqClient.logging(on: true);
//     mqClient.setProtocolV311();
//     connectTest();
//   }

//   final MqttConnectMessage connMess = MqttConnectMessage()
//       .withClientIdentifier("")
//       .startClean()
//       .withWillQos(MqttQos.atLeastOnce);

//   void connectTest() async {
//     try {
//       //Connects to the broker with the authentication credits provided
//       await mqClient.connect(authUser, authPass);
//     } on NoConnectionException catch (e) {
//       debugPrint("NoConnectionException: $e");
//       mqClient.disconnect();
//     } on SocketException catch (e) {
//       debugPrint("socketException: $e");
//       mqClient.disconnect();
//     } on Exception catch (e) {
//       debugPrint("Exception: $e");
//     }
//     if (mqClient.connectionStatus?.state == MqttConnectionState.connected) {
//       debugPrint("Connecteeeeedddd");
//       clientSubscribe();
//     } else {
//       debugPrint("Not connected, status: ${mqClient.connectionStatus}");
//       mqClient.disconnect();
//     }
//   }

// //The method that subscribes to a specifiv topic
//   void clientSubscribe() {
//     mqClient.subscribe(mqttTopic, MqttQos.atMostOnce);
//     mqClient.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? event) {
//       final receivedMessage = event![0].payload as MqttPublishMessage;
//       final pt =
//           MqttPublishPayload.bytesToString(receivedMessage.payload.message);
//       // Handle the received message here
//       debugPrint('Received message: $pt');
//     });
//   }

// //Listens for messages on the subscribed topic
//   void listenForMessages() {
//     mqClient.published!.listen((MqttPublishMessage message) {
//       debugPrint("message:: $message");

//       setState(() {
//         //Re-renders the widget state, so the message can show on screen
//         //Decodes the ASCII
//         messsageToDispaly = String.fromCharCodes(message.payload.message);
//       });
//     });
//   }

//   void onConnected() {
//     try {
//       debugPrint('Connected to the broker');

//       mqClient.connectionMessage = connMess;
//       listenForMessages();
//     } catch (e) {
//       debugPrint("MQTT error: $e");
//     }
//   }

//   void onDisconnected() {
//     debugPrint('Disconnected from the broker');
//   }

//   void onSubscribed(String topic) {
//     debugPrint('Subscribed to topic: $topic');
//   }

//   void onSubscribeFail(String topic) {
//     debugPrint('Failed to subscribe to topic: $topic');
//   }

//   void onUnsubscribed(String topic) {
//     debugPrint('Unsubscribed from topic: $topic');
//   }

//   void onAutoReconnect() {
//     debugPrint('Reconnecting to the broker');
//   }

//   void pong() {
//     debugPrint("pong");
//   }

//   void test() {
//     debugPrint("${mqClient.connectionStatus}");
//   }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 170,
        width: 160,
        color: Colors.red,
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ValueListenableBuilder(
            valueListenable: messageNotifier,
            builder: (context, value, child) {
              return Text(
                value.toString().isNotEmpty ? value.toString() : "0",
                style: const TextStyle(fontSize: 40),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text("Topic: $topic"),
          ),
        ])));
  }
}
