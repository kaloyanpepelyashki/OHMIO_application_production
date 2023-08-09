import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/components/drawer_menu.dart';
import 'package:pin_tunnel_application_production/components/grid_layout_component.dart';
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
    return const Scaffold(
      appBar: TopBarBurgerMenu(),
      endDrawer: DrawerMenuComponent(),
      body: GridLayout(),
    );
  }
}
