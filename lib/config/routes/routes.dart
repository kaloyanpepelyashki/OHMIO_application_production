import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/usecases/subscribe_channel_logic.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/binary_encoder_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/confirm_email_page.dart';
//Importing page components
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/login_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/login_page_ghost.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/onboarding_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/retreive_tunnel_MAC_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/signup_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/splash_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/user_onboarding_personal.dart';

import '../../features/feature/data/repository/pin_tunnel_repository.dart';
import '../../features/feature/presentation/bloc/PinTunnelBloc.dart';
import '../../main.dart';

GoRouter router = GoRouter(initialLocation: "/",routes: <GoRoute>[
  GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      }),
  GoRoute(
      path: "/onboarding",
      builder: (BuildContext context, GoRouterState state) {
        return const OnBoardingPage();
      }),
  GoRoute(
      path: "/login",
      builder: (BuildContext context, GoRouterState state) {
        return const LogInPage();
      }),
  GoRoute(
      path: "/signup",
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpPage();
      },
      routes: [
        GoRoute(
            path: "confirm-email",
            builder: (BuildContext context, GoRouterState state) {
              return const ConfirmEmailPage();
            }),
        GoRoute(
            path: "login-ghost",
            builder: (BuildContext context, GoRouterState state) {
              return const LogInPageGhost();
            }),
        GoRoute(
            path: "onboarding-personal-data",
            builder: (BuildContext context, GoRouterState state) {
              return const OnBoardingPersonalDataPage();
            }),
        GoRoute(
            path: "onboarding-tunnel-mac",
            builder: (BuildContext context, GoRouterState state) {
              return const RetreiveTunnelMACPage();
            })
      ]),
  GoRoute(
      path: "/dashboard",
      builder: (BuildContext context, GoRouterState state) {
        final repository = PinTunnelRepository();
        final logic = SubscribeChannelLogic(repository);

        return BlocProvider.value(
      value: BlocProvider.of<PinTunnelBloc>(context),
      child:  DashBoardPage(notificationAppLaunchDetails),
    );
      }),
  GoRoute(
      path: "/sensorPage",
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: BlocProvider.of<PinTunnelBloc>(context),
          child: const SensorPage(),
        );
      }),
  GoRoute(
      path: "/binaryEncoderPage",
      builder: (BuildContext context, GoRouterState state) {
        return const BinaryEncoderPage();
      })
]);

void clearNavigationStack(context, String path) {
  final router = GoRouter.of(context);
  router.replace(path);
}
