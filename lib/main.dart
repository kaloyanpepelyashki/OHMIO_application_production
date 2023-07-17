import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/Providers/global_data_provider.dart';
import 'package:pin_tunnel_application_production/routes.dart';
import 'package:flutter/cupertino.dart';
import "package:supabase_flutter/supabase_flutter.dart";
import "package:provider/provider.dart";

import 'classes/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseManager.supabaseUrl,
    anonKey: supabaseManager.token,
  );

  //* supabaseClient init
  supabaseManager.supabaseClient = Supabase.instance.client;

  //* supabaseSession init
  supabaseManager.supabaseSession =
      supabaseManager.supabaseClient.auth.currentSession;

  runApp(ChangeNotifierProvider(
      create: (context) => GlobalDataProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Pin Tunnel",
      routerConfig: router,
    );
  }
}
