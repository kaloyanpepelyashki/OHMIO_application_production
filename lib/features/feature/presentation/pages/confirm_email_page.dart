import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/data_sources/supabase_service.dart';

class ConfirmEmailPage extends StatefulWidget {
  const ConfirmEmailPage({super.key});

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {
  //The function that whatches for changes in the AuthState
  //! The method doesn't work as intended!
  void watchEmailConfirmationState() {
    debugPrint("got inside watchEmailConfirmationState");
    debugPrint("supabaseSession: ${supabaseManager.supabaseSession}");
    debugPrint(
        "supabaseSession.user: ${supabaseManager.supabaseSession?.user.id}");

    //Creates a stream to listen for changes in the AuthState
    //!There is a problem here
    supabaseManager.supabaseClient.auth.onAuthStateChange.listen((event) {
      debugPrint("onAuthStateChange event triggered");
      final userConfirmationState = event.session?.user.emailConfirmedAt;
      if (userConfirmationState != null) {
        debugPrint("email confirmed");
        GoRouter.of(context).go("/dashboard");
      }
    });
  }

  //Transfers to dashboard on click
  //! To be removed after the watchEmailConfirmationState() method is fixed
  // transferOnConfirmation() async {
  //   final User? _user = supabaseManager.user;

  //   debugPrint("${_user?.email}");

  //   if (_user?.emailConfirmedAt != null) {
  //     debugPrint("email confirmed");
  //     GoRouter.of(context).go("/dashboard");
  //   } else {
  //     const snackbar = SnackBar(content: Text("Please confirm your email"));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //   }
  // }

  void navigateToLogIn() {
    GoRouter.of(context).go("/signup/login-ghost");
  }

  @override
  void initState() {
    watchEmailConfirmationState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBarBlank(),
        body: Center(
            child: FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 0.52,
                child: Column(children: [
                  const Text(
                    "Open your mail box and confirm email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textWidthBasis: TextWidthBasis.parent,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 35, 0, 10),
                      child: Column(children: [
                        ElevatedButtonComponent(
                            onPressed: () {
                              navigateToLogIn();
                            },
                            text: "Ok")
                      ]))
                ]))));
  }
}
