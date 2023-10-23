import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/drawer_user_profile_item.dart';

import '../../data/data_sources/supabase_service.dart';
import 'drawer_menu_item_component.dart';

class DrawerMenuComponent extends StatelessWidget {
  const DrawerMenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    void handleSignOut() async {
      var signOutResult = await supabaseManager.signOutUser();

      signOutResult.fold(
          ifRight: (r) => {GoRouter.of(context).go("/onboarding")},
          ifLeft: (l) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(l.message),
                backgroundColor: const Color.fromARGB(156, 255, 1, 1),
              )));
    }

    return Drawer(
        width: 240,
        child: Stack(
          children: [
            // Other widgets in the Stack
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
                      height: 160,
                      child: const DrawerHeader(
                          margin: EdgeInsets.only(bottom: 0),
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 14),
                          child: UserProfileHeader())),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.fromLTRB(25, 10, 12, 0),
                      children: [
                        DrawerMenuItemComponent(
                            text: "Change password",
                            action: () =>
                                GoRouter.of(context).push("/changePassword")),
                        DrawerMenuItemComponent(
                            text: "Log-out", action: handleSignOut),
                        DrawerMenuItemComponent(
                          text: "MQTT stream",
                          action: () => GoRouter.of(context).push('/mqttPage'),
                        ),
                        DrawerMenuItemComponent(
                            text: "SupabaseRealtime",
                            action: () => GoRouter.of(context)
                                .push("/supabaseRealtimeTest")),
                        DrawerMenuItemComponent(
                            text: "SupabaseChannels",
                            action: () => GoRouter.of(context)
                                .push("/supabaseChannelsTest"))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              height: 40,
              bottom: 20,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("VERSION: 1.0.3"),
                ),
              ),
            ),
          ],
        ));
  }
}
