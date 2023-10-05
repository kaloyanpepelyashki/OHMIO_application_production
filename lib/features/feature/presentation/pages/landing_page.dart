import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/text_button_component.dart';

//<== Initial first screen of the application (Landing page)
class InitialLandingPage extends StatelessWidget {
  const InitialLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(30, 7, 30, 7)),
                        onPressed: () {
                          context.push('/login');
                        },
                        child: const Text('Log in',
                            style: TextStyle(fontSize: 30)),
                      ),
                      TextButtonComponent(
                          onPressed: () {
                            GoRouter.of(context).go("/signup");
                          },
                          text: "Sign up"),
                    ]))
              ]))),
    );
  }
}
