import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/data_sources/supabase_service.dart';
import '../../widgets/elevated_button_component.dart';
import '../../widgets/inputField_with_heading.dart';
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
  void initState() async{
    await ScreenProtector.protectDataLeakageWithColor(Colors.white);
    await ScreenProtector.preventScreenshotOn();
    _emailController.text = _supabaseManager.user?.email ?? "";
    super.initState();
  }

  @override
  void dispose() async{
    _emailController.dispose();
    _passwordController.dispose();
    await ScreenProtector.preventScreenshotOff();
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
        appBar: const TopBarBackAction(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.8,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: InputFieldWithHeading(
                              controller: _emailController,
                              heading: "Let's log you in",
                              placeHolder: "Email",
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    enabledBorder: OutlineInputBorder())))
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButtonComponent(
                        onPressed: () {
                          _handleSignIn(context, _emailController.text.trim(),
                              _passwordController.text);
                        },
                        text: "Ok",
                      ))
                ],
              )),
        ));
  }
}
