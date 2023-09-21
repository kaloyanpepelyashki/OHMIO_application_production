import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';

import '../../../data/data_sources/supabase_service.dart';
import '../../../domain/entities/user_class.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _session = supabaseManager.supabaseSession;

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) {
      debugPrint("!mounted");
      return;
    }
    _session = supabaseManager.supabaseClient.auth.currentSession;

    //Checks if the session is null or not
    if (_session != null) {
      debugPrint(_session?.user.id);
      final _userProfileDB =
          await userProfile.getUserProfileFromDB(_session?.user.id);

      // If the session is not null, it checks whether the user has finished the onBoarding process
      if (_userProfileDB["finishedOnBoarding"]) {
        // if the user has finished the onBoarding, they get navigated to the dashboard page
        debugPrint("Going to dashboard");
        GoRouter.of(context).go("/dashboard/:email");
      } else if (!_userProfileDB["finishedOnBoarding"]) {
        //If the user has not finished the onBoarding, they get navigated to finish the onBoarding
        GoRouter.of(context).go("/signup/onboarding-personal-data");
      }
    } else {
      //If the sessions is null, navigates to onboarding screen (login/signup)
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
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
