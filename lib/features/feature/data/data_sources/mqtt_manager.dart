import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttManager {
  final String brokerUrl;
  final int port;
  final String topic;
  final String clientIdentifier;
  late MqttServerClient mqttClient;

  void Function() listenForChanges;

  final MqttConnectMessage connMess = MqttConnectMessage()
      .withClientIdentifier("")
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);

  MqttManager(
      {required this.brokerUrl,
      required this.port,
      required this.clientIdentifier,
      required this.topic,
      required this.listenForChanges}) {
    _initialize();
  }

  _initialize() {
    mqttClient = MqttServerClient.withPort(brokerUrl, clientIdentifier, port);
    mqttClient.logging(on: true);
    mqttClient.secure = true;
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
  void establishConnection(
      {required String authUser, required String authPassword}) async {
    try {
      await mqttClient.connect(authUser, authPassword);
    } on SocketException catch (e) {
      print("Error establishing connection ; Socket Error : $e");
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

  //The method that subscribes to a specifiv topic
  void clientSubscribe() {
    try {
      mqttClient.subscribe(topic, MqttQos.atMostOnce);
      mqttClient.updates!
          .listen((List<MqttReceivedMessage<MqttMessage>>? event) {
        final receivedMessage = event![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToString(receivedMessage.payload.message);

        // Handle the received message here
        print('Received message: $pt');
      });
    } catch (e) {
      print("$e");
    }
  }

  onConnected() {
    try {
      print('Connected to the broker');

      mqttClient.connectionMessage = connMess;
      listenForChanges();
    } catch (e) {
      print("MQTT error: $e");
    }
  }

  void onDisconnected() {
    print('Disconnected from the broker');
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
