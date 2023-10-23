import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/inputField_with_heading.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

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
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: InputFieldWithHeading(
                              key: Key("emailField"),
                              controller: _emailController,
                              placeHolder: "Email",
                              obscureText: false,
                            )),
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButtonComponent(
                        key: const Key('resetButton'),
                        onPressed: () async{
                          supabaseManager.supabaseClient.auth.resetPasswordForEmail(_emailController.text.trim(), redirectTo: 'http://ohmio.org/index.html');
                        },
                        text: "OK",
                      )),
                  
                ],
              )),
        ));
  }
}