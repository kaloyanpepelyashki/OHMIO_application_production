import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/data_sources/supabase_service.dart';
import '../../widgets/elevated_button_component.dart';
import '../../widgets/inputField_with_heading.dart';
import '../../widgets/text_button_component.dart';
import '../../widgets/top_bar_back_action.dart';

class LogInPageGhost extends StatefulWidget {
  const LogInPageGhost({super.key});

  @override
  State<LogInPageGhost> createState() => _LogInPageGhostState();
}

class _LogInPageGhostState extends State<LogInPageGhost> {
  final _supabaseManager = supabaseManager;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = _supabaseManager.user?.email ?? "";
  }

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
          ifRight: (r) =>
              {GoRouter.of(context).go("/signup/onboarding-personal-data")},
          ifLeft: (l) => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(l.message),
                  backgroundColor: const Color.fromARGB(156, 255, 1, 1),
                ))
              });
    } on AuthException catch (e) {
      SnackBar(
        content: Text(e.message),
        backgroundColor: const Color.fromARGB(156, 255, 1, 1),
      );
      debugPrint("log in failed");
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBarBlank(),
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
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                      child: Column(children: [
                        Text("Let's log you in",
                        style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary,)),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: InputFieldWithHeading(
                              controller: _emailController,
                              placeHolder: "Email",
                              obscureText: false,
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    enabledBorder: OutlineInputBorder())))
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(children: [
                        ElevatedButtonComponent(
                          onPressed: () {
                            _handleSignIn(context, _emailController.text.trim(),
                                _passwordController.text);
                          },
                          text: "OK",
                        ),
                        TextButtonComponent(
                            onPressed: () {
                              GoRouter.of(context).go("/onboarding");
                            },
                            text: "Cancel")
                      ]))
                ],
              )),
        ));
  }
}
