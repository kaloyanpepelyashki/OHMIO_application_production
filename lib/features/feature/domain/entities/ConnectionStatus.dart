import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusSingleton {
  static final _singleton = ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  //This is what we use to retrieve the sigleton throughout the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  bool connectedToInternet = false;

  StreamController internetConnectionChange = StreamController.broadcast();

  final _connectivity = Connectivity();

  Stream get connectionChange => internetConnectionChange.stream;

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  void _connectionChange(ConnectivityResult? result) {
    checkConnection();
  }

  void dispoose() {
    internetConnectionChange.close();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = connectedToInternet;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectedToInternet = true;
      } else {
        connectedToInternet = false;
      }
    } on SocketException catch (e) {
      connectedToInternet = false;
    }

    if (previousConnection != connectedToInternet) {
      internetConnectionChange.add(connectedToInternet);
    }

    return connectedToInternet;
  }
}
