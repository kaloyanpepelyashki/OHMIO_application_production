

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
    try {
      print("USER ID $sessionUUID");
      final databaseData = await supabaseManager.supabaseClient
          .from("profiles")
          .select('username, email, first_name, last_name')
          .eq("id", sessionUUID);

      debugPrint("user data is : $databaseData");

      if (databaseData.isEmpty) {
        return Either.left(Exception("Unexpected error occured"));
      } else {
        final parsedData = databaseData as List<dynamic>;
        print("PARSED DATA: ${parsedData}");

        if (parsedData.isEmpty) {
          return Either.left(Exception("No data found for the given ID"));
        }
        final username = parsedData[0]['username'] ?? "";
        final email = parsedData[0]['email'] ?? "";
        final firstName = parsedData[0]['first_name'] ?? "";
        final lastName = parsedData[0]['last_name'] ?? "";

        userProfile.username = username;
        userProfile.email = email;
        userProfile.firstName = firstName;
        userProfile.lastName = lastName;
        return Right(Future<void>);
      }
    } catch (e) {
      print("EXCEPTION FETCH FROM DATABASE $e");
    }
    return Left(Exception("Unexpected error"));
  }

  Future<Map<String, dynamic>> getUserProfileFromDB(userID) async {
    final result = await supabaseManager.supabaseClient
        .from("profiles")
        .select()
        .eq("id", userID);

    return result[0];
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

class UserData {
  final String firstName;
  final String lastName;
  final String username;
  final String email;

  UserData(
      {required this.firstName,
      required this.lastName,
      required this.username,
      required this.email});

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
        firstName: map['firstName'],
        lastName: map['lastName'],
        username: map['username'],
        email: map['email']);
  }
}
