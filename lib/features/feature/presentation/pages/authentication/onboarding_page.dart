import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';

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
                const Image(
                  image: AssetImage('assets/brandmark-design.png'),
                ),
                Container(
                    //<=== Controlls the margin of the two buttons
                    margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                    child: Column(children: [
                      ElevatedButtonComponent(
                          onPressed: () {
                            GoRouter.of(context).push("/login");
                          },
                          text: "Log in"),
                      TextButton(
                          child: const Text('Sign up',
                              style: TextStyle(fontSize: 18)),
                          onPressed: () {
                            GoRouter.of(context).push("/signup");
                          }),
                    ]))
              ]))),
    );
  }
}
