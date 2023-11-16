import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MqttManager {
  final String brokerUrl;
  final int port;
  final String clientIdentifier;
  //The list that holds the topic strings
  final String topic;
  //The map that gets the pair {topicName: message value}
  late MqttServerClient mqttClient;
  late Map<String, int> mqttData = {};
  final Map<String, StreamController<dynamic>> streamControllers = {};

  final MqttConnectMessage connMess = MqttConnectMessage()
      .withClientIdentifier(" ")
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);

  MqttManager({
    required this.brokerUrl,
    required this.port,
    required this.clientIdentifier,
    required this.topic,
  }) {
    _initialize();
  }

  _initialize() {
    mqttClient = MqttServerClient.withPort(brokerUrl, clientIdentifier, port);
    mqttClient.port = 8883;
    SecurityContext context = SecurityContext()
      ..useCertificateChain(
          "/Users/kaloyanpepelyashki/Desktop/Programming/Ebits/Pin-Tunnel-Production/pin_tunnel_application_production/lib/features/feature/data/data_sources/key_and_cert/fullchain.pem")
      ..usePrivateKey(
        '/Users/kaloyanpepelyashki/Desktop/Programming/Ebits/Pin-Tunnel-Production/pin_tunnel_application_production/lib/features/feature/data/data_sources/key_and_cert/privkey.pem',
      );
    mqttClient.secure = true; //adds (wss://) infront of the url
    mqttClient.securityContext = context;
    mqttClient.useWebSocket = true;
    mqttClient.onDisconnected = onDisconnected;
    mqttClient.onSubscribed = onSubscribed;
    mqttClient.onSubscribeFail = onSubscribeFail;
    mqttClient.onAutoReconnect = onAutoReconnect;
    mqttClient.pongCallback = pong;
    mqttClient.keepAlivePeriod = 60;
    mqttClient.logging(on: true);
    mqttClient.setProtocolV311();
  }

  //Attempts connecting to the broker
  void establishConnection({
    required String authUser,
    required String authPassword,
  }) async {
    try {
      await mqttClient.connect(authUser, authPassword);
    } on SocketException catch (e) {
      print("Error establishing connection;  Socket Error : $e");
      mqttClient.disconnect();
    } on NoConnectionException catch (e) {
      print("No connection : $e");
      mqttClient.disconnect();
    } catch (e) {
      print("Error establishing connection : $e");
      mqttClient.disconnect();
    }
    if (mqttClient.connectionStatus?.state == MqttConnectionState.connected) {
      print("Connection status : ${mqttClient.connectionStatus?.state}");
      clientSubscribe();
    } else {
      print(
          "Connection failed. Connection status: ${mqttClient.connectionStatus}");
      mqttClient.disconnect();
    }
  }
//TODO Write a method to validate the message format (if it's a correct json)

  //The method that subscribes to a specifiv topic
  void clientSubscribe() {
    try {
      mqttClient.subscribe(topic, MqttQos.exactlyOnce);

      mqttClient.updates!
          .listen((List<MqttReceivedMessage<MqttMessage>>? event) {
        final receivedMessage = event![0].payload as MqttPublishMessage;
        final pt = String.fromCharCodes(receivedMessage.payload.message);

        print('Received message: $pt');
        try {
          //Checks if the payload is a valid JSON (if it starts with "{" and ends with "}")
          if (pt.startsWith('{') && pt.endsWith('}')) {
            //Decodes the string to be a JSON object
            final Map<String, dynamic> jsonMessage = json.decode(pt);
            print("jsonMessage decoded: $jsonMessage");

            //Checks if the object has "sensors" list and if the list is a list
            if (jsonMessage.containsKey('sensors') &&
                jsonMessage['sensors'] is List) {
              List<dynamic> sensors = jsonMessage['sensors'];
              //Iterates over the list for every element in the list
              for (final element in sensors) {
                //If the element is of type Map<String, String> and checks if the element is not empty
                if (element is Map<String, dynamic> && element.isNotEmpty) {
                  final String sensorName = element.keys.first;

                  Map<String, dynamic> sensorData = element[sensorName];

                  print("sensorData: $sensorData");
                  mqttData[sensorName] = sensorData['value'];

                  //Checks if the Map streamControllers allready contains the key
                  if (!streamControllers.containsKey(sensorName)) {
                    print("$sensorName added to the stream");
                    //If it doesn't, it adds a new stream.
                    streamControllers[sensorName] =
                        StreamController<dynamic>.broadcast();

                    streamControllers[sensorName]!.stream.listen((value) {
                      print(
                          "Stream:: $sensorName : ${sensorData['value']} updated to $value");
                    });
                  }

                  //Performs action when the key value is updated
                  if (streamControllers.containsKey(sensorName)) {
                    streamControllers[sensorName]!.add(sensorData['value']);
                  }
                }
                print(mqttData);
              }
            } else {
              print('Invalid sensors format in the message: $jsonMessage');
            }
          } else {
            print("$pt is not a valid JSON format");
            return;
          }
        } catch (e) {
          print('Error decoding JSON: $e');
          print("$e");
        }
      });
    } catch (e) {
      print("$e");
    }
  }

  onConnected() {
    try {
      print('Connected to the broker');

      mqttClient.connectionMessage = connMess;
      // listenForChanges();
    } catch (e) {
      print("MQTT error: $e");
    }
  }

  void onDisconnected() {
    if (mqttClient.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('Disconnected from broker; Disconection origin: Solicited');
    }
    if (mqttClient.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.unsolicited) {
      print('Disconnected from broker; Disconection origin: Unsolicited');
    } else {
      print('Disconnected from the broker');
    }
  }

  void onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe to topic: $topic');
  }

  void onUnsubscribed(String topic) {
    print('Unsubscribed from topic: $topic');
  }

  void onAutoReconnect() {
    print('Reconnecting to the broker');
  }

  void pong() {
    print("pong");
  }
}
