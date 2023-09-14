import 'dart:ffi';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/tunnel_class.dart';
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
  late bool finishedOnBoarding = false;

  //User_Profile();

  User_Profile(
      {this.userRef,
      required this.userId,
      required this.email,
      this.signUpDate,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.tunnelDevice,
      required this.tunnelMACAddress,
      required this.tunnelState});

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

  void finishOnBoarding() {
    finishedOnBoarding = true;
  }

//Data binding with the database
  Future<Either<Exception, void>> fetchFromDatabase(sessionUUID) async {
    final databaseData = await supabaseManager.supabaseClient
        .from("profiles")
        .select('username, email, first_name, last_name')
        .eq("id", sessionUUID);

    debugPrint("user data is : $databaseData");

    if (databaseData == null) {
      return Either.left(Exception("Unexpected error occured"));
    } else {
      final parsedData = databaseData.data as List<Map<String, dynamic>>;

      for (final row in parsedData) {
        final username = row['username'];
        final email = row['email'];
        final firstName = row['first_name'];
        final lastName = row['last_name'];

        userProfile.username = username;
        userProfile.email = email;
        userProfile.firstName = firstName;
        userProfile.lastName = lastName;
      }
    }
    return Either.left(Exception("Unexpected error occured"));
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
final userProfile = User_Profile(
    userId: "",
    email: "",
    signUpDate: null,
    username: "",
    firstName: "",
    lastName: "",
    tunnelDevice: null,
    tunnelMACAddress: "",
    tunnelState: "");
