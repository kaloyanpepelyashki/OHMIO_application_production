import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../classes/supabase_service.dart';

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
        child: Column(children: [
      DrawerHeader(child: Text("header")),
      Expanded(
        child: ListView(padding: EdgeInsets.fromLTRB(45, 10, 0, 0), children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Test list item"),
                    Text("Second test list item")
                  ])),
          InkWell(
            onTap: handleSignOut,
            child: Text("Log out"),
            overlayColor: null,
            splashColor: null,
            focusColor: null,
            hoverColor: null,
            onLongPress: null,
            onDoubleTap: null,
          )
        ]),
      )
    ]));
  }
}
