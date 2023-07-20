import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/components/drawer_menu.dart';
import 'package:pin_tunnel_application_production/components/top_bar_burger_menu.dart';
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
        appBar: const TopBarBurgerMenu(),
        endDrawer: const DrawerMenuComponent(),
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
