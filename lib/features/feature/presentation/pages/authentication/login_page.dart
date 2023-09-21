import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/data_sources/supabase_service.dart';
import '../../../domain/entities/user_class.dart';
import '../../widgets/elevated_button_component.dart';
import '../../widgets/top_bar_back_action.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInComponentState();
}

class _LogInComponentState extends State<LogInPage> {
  final _supabaseManager = supabaseManager;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_emailController.text = _supabaseManager.user?.email ?? "kon";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn(context, String email, String password) async {
    try {
      var signInSession = await _supabaseManager.signInUser(context,
          email: email, password: password);

      signInSession.fold(
          ifRight: (r) async => {
                await userProfile.fetchFromDatabase(supabaseManager.user?.id),
                print("DATA PARSED"),
                OneSignal.login(email),
                OneSignal.User.addEmail(email),
                GoRouter.of(context).go("/")
              },
          ifLeft: (l) => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(l.message),
                  backgroundColor: const Color.fromARGB(156, 255, 1, 1),
                ))
              });
    } on AuthException catch (e) {
      SnackBar(
        content: Text(e.message),
        backgroundColor: const Color.fromARGB(156, 255, 1, 1),
      );
      debugPrint("log in failed");
      debugPrint("Error: $e");
    }
  }

  @override
  //UI represented by this widget
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TopBarBackAction(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.8,
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('assets/brandmark-design.png'),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: TextField(
                                //key for testing purpose
                                key: const Key('emailField'),
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    enabledBorder: OutlineInputBorder()))),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: TextField(
                                key: const Key('passwordField'),
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    enabledBorder: OutlineInputBorder())))
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButtonComponent(
                        key: const Key('loginButton'),
                        onPressed: () {
                          _handleSignIn(context, _emailController.text.trim(),
                              _passwordController.text);
                        },
                        text: "Ok",
                      ))
                ],
              )),
        ));
  }
}
