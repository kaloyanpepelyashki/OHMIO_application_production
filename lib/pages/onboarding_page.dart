import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

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
