import 'package:pin_tunnel_application_production/classes/tunnel_class.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: camel_case_types
class User_Profile {
  User? userRef;
  String userId;
  String email;
  DateTime signUpDate;
  late String username;
  late String firstName;
  late String lastName;
  late Tunnel tunnelDevice;
  late String tunnelMACAddress;
  late String tunnelState;

  User_Profile(
      {required this.userRef,
      required this.userId,
      required this.email,
      required this.signUpDate});

  User_Profile.empty()
      : userId = "",
        email = "",
        username = "",
        firstName = "",
        lastName = "",
        signUpDate = DateTime.now();

  void initDevice(
      Tunnel tunnelDevice, String tunnelMACAddress, String tunnelState) {
    this.tunnelDevice = tunnelDevice;
    this.tunnelMACAddress = tunnelMACAddress;
    this.tunnelState = tunnelState;
  }
}
