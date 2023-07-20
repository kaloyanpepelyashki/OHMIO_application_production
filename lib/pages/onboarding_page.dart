import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/components/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/components/top_bar_blank.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarBlank(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.8,
              child: Column(children: [
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 40, letterSpacing: 17),
                ),
                Container(

                    //<=== Controlls the margin of the two buttons
                    margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                    child: Column(children: [
                      ElevatedButtonComponent(
                          onPressed: () {
                            context.push('/login');
                          },
                          text: "Log in"),
                      TextButton(
                          child: const Text('Sign up',
                              style: TextStyle(fontSize: 18)),
                          onPressed: () {
                            context.push("/signup");
                          }),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(30, 7, 30, 7)),
                        onPressed: () {
                          context.push('/blinkerPage');
                        },
                        child: const Text('Blinker',
                            style: TextStyle(fontSize: 30)),
                      ),
                    ]))
              ]))),
    );
  }
}
