import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/inputField_with_heading.dart';

class PasswordResetConfirmationPage extends StatefulWidget {
  const PasswordResetConfirmationPage({super.key});

  @override
  State<PasswordResetConfirmationPage> createState() => _PasswordResetConfirmationPageState();
}

class _PasswordResetConfirmationPageState extends State<PasswordResetConfirmationPage> {
  
  TextEditingController? passwordController;
  TextEditingController? repeatPasswordController;

  @override
  void initState() {
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: InputFieldWithHeading(
                  controller: passwordController!,
                  placeHolder: 'New Password',
                  obscureText: false),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: InputFieldWithHeading(
                  controller: repeatPasswordController!,
                  placeHolder: 'Repeat Password',
                  obscureText: false),
            ),
            ElevatedButton(onPressed: (){
              
            }, child: Text("OK")),
            
          ],
        ));
  }
}
