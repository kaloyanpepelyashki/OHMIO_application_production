import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/secure_storage.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/inputField_with_heading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/data_sources/supabase_service.dart';
import '../../../domain/entities/user_class.dart';
import '../../widgets/elevated_button_component.dart';
import '../../widgets/text_button_component.dart';
import '../../widgets/top_bar_back_action.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInComponentState();
}

class _LogInComponentState extends State<LogInPage> {
  final _supabaseManager = supabaseManager;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String secureStorageEmail = '';
  String secureStoragePassword = '';

  @override
  void initState() {
    readSecureData();
    super.initState();
    //_emailController.text = _supabaseManager.user?.email ?? "kon";
  }

  void readSecureData() async {
    String email = await SecureStorage().readSecureData('email');
    String password = await SecureStorage().readSecureData('password');

    if (email != 'No data found') {
      _emailController.text = email;
      secureStorageEmail = email;
    }
    if (password != 'No data found') {
      _passwordController.text = password;
      secureStoragePassword = password;
    }
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
          ifRight: (r) async => {
                await userProfile.fetchFromDatabase(supabaseManager.user != null
                    ? supabaseManager.user?.id
                    : null),
                print("DATA PARSED"),
                OneSignal.login(email),
                OneSignal.User.addEmail(email),
                GoRouter.of(context).go("/")
              },
          ifLeft: (l) => {
                print("EXCEPTION IS login_page: $l"),
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
  //UI represented by this widget
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
                  Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: const Image(
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
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: InputFieldWithHeading(
                                key: Key("passwordField"),
                                controller: _passwordController,
                                placeHolder: "Password",
                                obscureText: true))
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButtonComponent(
                        key: const Key('loginButton'),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (secureStorageEmail == '' ||
                              secureStoragePassword == '') {
                            await SecureStorage().writeSecureData(
                                'email', _emailController.text.trim());
                            await SecureStorage().writeSecureData(
                                'password', _passwordController.text);
                          }
                          _handleSignIn(context, _emailController.text.trim(),
                              _passwordController.text);
                        },
                        text: "Sign in",
                      )),
                  SizedBox(height: 16),
                  // GestureDetector(
                  //     child: Text("Forgot your password?"),
                  //     onTap: () {
                  //       GoRouter.of(context).push("/resetPassword");
                  //     }),
                  TextButtonComponent(
                      text: "Forgot password?",
                      onPressed: () =>
                          GoRouter.of(context).push("/resetPassword")),
                ],
              )),
        ));
  }
}
