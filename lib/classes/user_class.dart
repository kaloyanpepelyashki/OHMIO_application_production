import 'package:pin_tunnel_application_production/classes/tunnel_class.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: camel_case_types
class User_Profile {
  late User? userRef;
  late String userId;
  late String email;
  late DateTime? signUpDate;
  late String username;
  late String firstName;
  late String lastName;
  late Tunnel? tunnelDevice;
  late String tunnelMACAddress;
  late String tunnelState;

  User_Profile();

  //The onboarding method
  //Defines the first part of the userProfile object
  void onboarding(String firstName, String lastName, dynamic email,
      DateTime signUpDate, userId) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.signUpDate = signUpDate;
    this.userId = userId;
  }

  void empty() {
    userId = "";
    email = "";
    username = "";
    firstName = "";
    lastName = "";
    signUpDate = DateTime.now();
  }

  void initDevice(
      Tunnel tunnelDevice, String tunnelMACAddress, String tunnelState) {
    this.tunnelDevice = tunnelDevice;
    this.tunnelMACAddress = tunnelMACAddress;
    this.tunnelState = tunnelState;
  }

  //Cleans the object (sets the members to be empty)
  void clearProfile() {
    userId = "";
    email = "";
    signUpDate = null;
    username = "";
    firstName = "";
    lastName = "";
    tunnelDevice = null;
    tunnelMACAddress = "";
    tunnelState = "";
  }
}

//Initializing the userProfile object
final userProfile = User_Profile();
