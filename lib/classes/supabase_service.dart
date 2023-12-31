import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  String supabaseUrl;
  String token;

  late SupabaseClient supabaseClient;
  late Session? supabaseSession;
  User? user;

  //* Defining constructor for SupabaseManager class
  //Assigning a constructor for the SupabaseManager class
  SupabaseManager({
    required this.supabaseUrl,
    required this.token,
  }) : supabaseClient = SupabaseClient(supabaseUrl, token);

  //* Defining the SIGN-UP method
  Future<Either<AuthException, User?>> signUpUser(dynamic context,
      {String? email, String? password}) async {
    try {
      //signUp method by supabase
      final AuthResponse response =
          await supabaseClient.auth.signUp(email: email!, password: password!);

      if (response.user?.id != null) {
        user = response.user;
        supabaseSession = response.session;

        //Return right part of Either< > if success
        return Either.right(user);
      } else if (response.user?.id == null) {
        debugPrint("A error occured");
        //Returns left part of Either< > if faliure
        return const Either.left(AuthException("An error occured"));
      }
    } on AuthException catch (e) {
      //Returns left part of Either< > if faliure
      return Either.left(AuthException(e.message));
    } catch (e) {
      debugPrint("not working");
      //Returns left part of Either< > if faliure
      return Either.left(AuthException("$e"));
    }

    //Fallback return statement (if none of the preceding return statements are executed)
    return const Either.left(AuthException("An unexpected error occured"));
  }

  //* Defining the SIGN-IN method
  Future<Either<AuthException, User?>> signInUser(dynamic context,
      {String? email, String? password}) async {
    try {
      //signInWithPassword method by supabase
      final response = await supabaseClient.auth
          .signInWithPassword(email: email!, password: password!);

      if (response.user?.id != null) {
        user = supabaseClient.auth.currentUser;
        //Return right part of Either< > if success
        return Either.right(user);
      } else if (response.user?.id == null) {
        //Returns left part of Either< > if faliure
        return const Either.left(AuthException("Invalid email or password"));
      }
    } on AuthException catch (e) {
      //Returns left part of Either< > if faliure
      return Either.left(AuthException(e.message));
    } catch (e) {
      debugPrint("Error:");
      debugPrint("$e");
      //Returns left part of Either< > if faliure
      return Either.left(AuthException("Error $e"));
    }

    //Fallback return statement (if none of the preceding return statements are executed)
    return const Either.left(AuthException("An unexpected error occured"));
  }

  //* Defining SIGN-OUT method
  Future<void> signOutUser() async {
    //TODO Figure out if the signOutUser method is doing everything it's supposed to
    await supabaseClient.auth.signOut();
    return;
  }
}

final SupabaseManager supabaseManager = SupabaseManager(
    supabaseUrl: "https://xkvzvrqmpqhfhutbvlry.supabase.co",
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhrdnp2cnFtcHFoZmh1dGJ2bHJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODcxNzY0ODQsImV4cCI6MjAwMjc1MjQ4NH0.73RTVlB2J7OTLRdMQBsOmnKLJb3cOU_jMJxiomkh4-A");
