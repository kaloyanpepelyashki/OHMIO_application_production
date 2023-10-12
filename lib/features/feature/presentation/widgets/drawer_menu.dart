import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/drawer_user_profile_item.dart';

import '../../data/data_sources/supabase_service.dart';

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
                  padding: const EdgeInsets.fromLTRB(40, 10, 10, 20),
                  height: 160,
                  child: const DrawerHeader(
                      margin: EdgeInsets.only(bottom: 0),
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 14),
                      child: UserProfileHeader())),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.fromLTRB(50, 10, 15, 0),
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                        child: Row(children: [
                          InkWell(
                            child: const Text("Log-out",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            onTap: () {
                              handleSignOut();
                            },
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          )
                        ])),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        child: Row(children: [
                          InkWell(
                            child: const Text("Log-out",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            onTap: () {
                              handleSignOut();
                            },
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          )
                        ])),
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
              child: Text("VERSION: 1.0.0"),
            ),
          ),
        ),
      ],
    ));
  }
}
