import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/usecases/subscribe_channel_logic.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/drawer_menu.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/grid_layout_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_burger_menu.dart';

import '../../data/data_sources/supabase_service.dart';
import '../bloc/PinTunnelBloc.dart';
import '../bloc/PinTunnelEvent.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  void _handleSignOut(context) {
    supabaseManager.signOutUser();
    GoRouter.of(context).go("/onboarding");
  }

  @override
  Widget build(BuildContext context) {
    //supabaseManager.subscribeToChannel("*");
    BlocProvider.of<PinTunnelBloc>(context).add(SubscribeChannel(channelName: "*"));
    return const Scaffold(
      appBar: TopBarBurgerMenu(),
      endDrawer: DrawerMenuComponent(),
      body: GridLayout(),
    );
  }
}
