import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';

import '../../../data/data_sources/supabase_service.dart';

class ConfirmEmailPage extends StatefulWidget {
  const ConfirmEmailPage({super.key});

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {
  void navigateToLogIn() {
    GoRouter.of(context).go("/signup/login-ghost");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const TopBarBlank(),
        body: Center(
            child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.52,
                child: Column(children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 65),
                      child: Text(
                        "Open your mail box and confirm your email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                        textWidthBasis: TextWidthBasis.parent,
                      )),
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
