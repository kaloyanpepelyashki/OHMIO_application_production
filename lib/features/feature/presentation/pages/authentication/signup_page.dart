import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/inputField_with_heading.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/data_sources/supabase_service.dart';

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
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp(
      context, String email, String password, String repeatPassword) async {
    try {
      var signUpSession = await _supabaseManager.signUpUser(context,
          email: email, password: password, repeatPassword: repeatPassword);
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
              Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: const Image(
                    image: AssetImage('assets/brandmark-design.png'),
                  )),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                        child: Column(
                          children: [
                            //<=== | Text fields | ===>
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: InputFieldWithHeading(
                                  controller: _emailController,
                                  placeHolder: "Email",
                                  obscureText: false,
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: InputFieldWithHeading(
                                    controller: _passwordController,
                                    placeHolder: "* Password",
                                    obscureText: true)),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: InputFieldWithHeading(
                                  controller: _repeatPasswordController,
                                  placeHolder: "* Repeat password",
                                  obscureText: true,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ElevatedButtonComponent(
                            onPressed: () {
                              _handleSignUp(
                                  context,
                                  _emailController.text,
                                  _passwordController.text,
                                  _repeatPasswordController.text);
                            },
                            text: "Ok"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
