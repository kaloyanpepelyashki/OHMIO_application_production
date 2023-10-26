import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/inputField_with_heading.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();

  @override
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
                  const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Image(
                        image: AssetImage('assets/brandmark-design.png'),
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                      child: Column(children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: TextField(
                              key: Key("emailField"),
                              controller: _emailController,
                              decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(fontSize: 18)),
                              obscureText: false,
                            )),
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButtonComponent(
                        key: const Key('resetButton'),
                        onPressed: () async {
                        FocusScope.of(context).unfocus();
                         signup();
                        },
                        text: "OK",
                      )),
                ],
              )),
        ));
  }

  void signup() {
    try {
      supabaseManager.supabaseClient.auth.resetPasswordForEmail(
          _emailController.text.trim(),
          redirectTo: 'http://ohmio.org/index.html');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email sent to your mailbox'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      final snackbar = SnackBar(
        content: Text("$e"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
