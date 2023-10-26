import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/secure_storage.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/inputField_with_heading.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/text_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _supabaseManager = supabaseManager;
  final user = supabaseManager.user;
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  void _handleChangePassword(context, String currentPassword,
      String newPassword, String repeatPassword) async {
    try {
      if (newPassword == repeatPassword) {
        var session = supabaseManager.supabaseSession;
        session = supabaseManager.supabaseClient.auth.currentSession;
        var email = session!.user.email;

        var userReponse = await _supabaseManager.supabaseClient.auth
            .updateUser(UserAttributes(password: newPassword));
        if (userReponse.user != null) {
          await SecureStorage().writeSecureData('email', email!);
          await SecureStorage().writeSecureData('password', newPassword);
          GoRouter.of(context)
              .goNamed("dashboard", pathParameters: {"email": email});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("User is null"),
            backgroundColor: Color.fromARGB(156, 255, 1, 1),
          ));
        }
      }
    } on AuthException catch (e) {
      final snackbar = SnackBar(
        content: Text(e.message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      debugPrint("$e");
      final snackbar = SnackBar(
        content: Text("$e"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
              const Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Image(
                    image: AssetImage('assets/brandmark-design.png'),
                  )),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                        child: Column(
                          children: [
                            //<=== | Text fields | ===>
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: InputFieldWithHeading(
                                    controller: _currentPasswordController,
                                    placeHolder: "* Current Password",
                                    obscureText: true)),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: InputFieldWithHeading(
                                    controller: _newPasswordController,
                                    placeHolder: "* New Password",
                                    obscureText: true)),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: InputFieldWithHeading(
                                  controller: _repeatPasswordController,
                                  placeHolder: "* Repeat password",
                                  obscureText: true,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(children: [
                          ElevatedButtonComponent(
                              onPressed: () {
                                _handleChangePassword(
                                    context,
                                    _currentPasswordController.text,
                                    _newPasswordController.text,
                                    _repeatPasswordController.text);
                              },
                              text: "OK"),
                          TextButtonComponent(
                              onPressed: () {
                                GoRouter.of(context).go("/onboarding");
                              },
                              text: "Cancel")
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
