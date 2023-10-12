import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/core/util/notifications/alert_dialog_component.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/ConnectionStatus.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
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

  void validateSession() async {
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

        BlocProvider.of<PinTunnelBloc>(context).add(UpdateUserStatus(
            status: "ONLINE", email: _session?.user.email ?? ""));
        GoRouter.of(context).goNamed("dashboard",
            pathParameters: {"email": _session?.user.email ?? ""});
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

//Checks if valid internet connection is present
  void _checkInternetConnection() async {
    try {
      bool hasConnection = await singletonInstance.checkConnection();
      debugPrint("$hasConnection");

      setState(() {
        _isInternetPresent = hasConnection;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) {
      debugPrint("!mounted");
      return;
    }

    try {
      if (_isInternetPresent) {
        validateSession();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialogComponent(
                context, "Fail", "No internet connection present");
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    singletonInstance.initialize();
    _checkInternetConnection();
    _redirect();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isInternetPresent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage('assets/brandmark-design.png'),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    ),
                    CircularProgressIndicator(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
