import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';

import '../../data/data_sources/supabase_service.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _session = supabaseManager.supabaseSession;

  Future<void> _redirect() async {
    await Future.delayed(Duration(seconds: 5));
    if (!mounted) {
      debugPrint("!mounted");
      return;
    }
    _session = supabaseManager.supabaseClient.auth.currentSession;
    if (_session != null) {
      debugPrint("Going to dashboard");
      GoRouter.of(context).go("/dashboard");
    } else {
      debugPrint("Going to onboarding page");
      GoRouter.of(context).go("/onboarding");
    }
  }

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBarBlank(),
      body: Center(
          heightFactor: 1.0,
          child: Column(children: [CircularProgressIndicator()])),
    );
  }
}
