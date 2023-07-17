import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../classes/supabase_service.dart';
import '../components/top_bar_back_action.dart';

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
          ifRight: (r) => {GoRouter.of(context).go("/dashboard")},
          ifLeft: (l) => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(l.message),
                  backgroundColor: Color.fromARGB(156, 255, 1, 1),
                ))
              });
    } on AuthException catch (e) {
      SnackBar(
        content: Text(e.message),
        backgroundColor: Color.fromARGB(156, 255, 1, 1),
      );
      debugPrint("log in failed");
      debugPrint("Error: $e");
    }
  }

  @override
  //UI represented by this widget
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBarBackAction(),
        body: Center(
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.8,
              child: Column(
                children: [
                  Text(
                    "Title",
                    style: TextStyle(fontSize: 40, letterSpacing: 17),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    enabledBorder: OutlineInputBorder()))),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    enabledBorder: OutlineInputBorder())))
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          _handleSignIn(context, _emailController.text.trim(),
                              _passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(70, 5, 70, 5)),
                        child: const Text(
                          "Ok",
                          style: TextStyle(
                            fontSize: 29,
                          ),
                        ),
                      ))
                ],
              )),
        ));
  }
}
