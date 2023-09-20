import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/data_sources/supabase_service.dart';
import '../../widgets/top_bar_blank.dart';

class LoginSplashPage extends StatefulWidget {
  final String? email;

  const LoginSplashPage(
    this.email, {
    Key? key,
  }) : super(key: key);

  @override
  State<LoginSplashPage> createState() => _LoginSplashPageState();
}

class _LoginSplashPageState extends State<LoginSplashPage> {
  var _session = supabaseManager.supabaseSession;

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) {
      debugPrint("!mounted");
      return;
    }

    _session = supabaseManager.supabaseClient.auth.currentSession;

    final _userProfileDB = await supabaseManager.supabaseClient
        .from("profiles")
        .select()
        .eq("id", _session?.user.id);

    if (!_userProfileDB[0]["finishedOnBoarding"]) {
      GoRouter.of(context).go("/signup/onboarding-personal-data");
    } else {
      GoRouter.of(context).go("/dashboard/:email");
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
