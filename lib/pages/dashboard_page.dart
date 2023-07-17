import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../classes/supabase_service.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  void _handleSignOut(context) {
    supabaseManager.signOutUser();
    GoRouter.of(context).go("/onboarding");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            body: Center(
                child: Column(
      children: [
        Text("DashBoard"),
        ElevatedButton(
            onPressed: () {
              debugPrint(supabaseManager.user?.email);
            },
            child: Text("Debug")),
        ElevatedButton(
            onPressed: () {
              _handleSignOut(context);
            },
            child: Text("Sign out")),
      ],
    ))));
  }
}
