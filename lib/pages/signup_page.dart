import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/components/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/components/top_bar_back_action.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../classes/supabase_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpComponentState();
}

class _SignUpComponentState extends State<SignUpPage> {
  final _supabaseManager = supabaseManager;
  final user = supabaseManager.user;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp(context, String email, String password) async {
    try {
      var signUpSession = await _supabaseManager.signUpUser(context,
          email: email, password: password);
      signUpSession.fold(
          //If signUpSession is success
          ifRight: (r) => {GoRouter.of(context).go("/signup/confirm-email")},
          //If signUpSession is faliure;
          ifLeft: (l) => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(l.message),
                  backgroundColor: const Color.fromARGB(156, 255, 1, 1),
                ))
              });
    } on AuthException catch (e) {
      final snackbar = SnackBar(
        content: Text(e.message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      debugPrint("$e");
      final snackbar = SnackBar(
        content: Text("$e"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  //UI represented by this widget
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBarBackAction(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.8,
              child: Column(
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(fontSize: 40, letterSpacing: 17),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 70, 0, 10),
                      child: Column(children: [
                        //<=== | Text fields | ===>
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
                                    enabledBorder: OutlineInputBorder()))),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: const TextField(
                                decoration: InputDecoration(
                                    hintText: "Repeat Password",
                                    enabledBorder: OutlineInputBorder())))
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButtonComponent(
                          onPressed: () {
                            _handleSignUp(context, _emailController.text,
                                _passwordController.text);
                          },
                          text: "Ok")),
                ],
              )),
        ));
  }
}
