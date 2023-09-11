import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/usecases/subscribe_channel_logic.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/choose_sensor_page.dart';
//Importing page components
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/dashboard_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/authentication/retreive_tunnel_MAC_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/sensor_detail_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/chart_full_screen_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/sensor_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/authentication/signup_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/authentication/user_onboarding_personal.dart';

import '../../features/feature/data/repository/pin_tunnel_repository.dart';
import '../../features/feature/domain/entities/sensor_class.dart';
import '../../features/feature/presentation/bloc/PinTunnelBloc.dart';
import '../../features/feature/presentation/pages/authentication/binary_encoder_page.dart';
import '../../features/feature/presentation/pages/authentication/confirm_email_page.dart';
import '../../features/feature/presentation/pages/authentication/login_page.dart';
import '../../features/feature/presentation/pages/authentication/login_page_ghost.dart';
import '../../features/feature/presentation/pages/authentication/onboarding_page.dart';
import '../../features/feature/presentation/pages/authentication/splash_page.dart';
import '../../main.dart';

GoRouter router = GoRouter(initialLocation: "/", routes: <GoRoute>[
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
          child: DashBoardPage(notificationAppLaunchDetails),
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
      path: "/chooseSensorPage",
      builder: (BuildContext context, GoRouterState state) {
        return const ChooseSensorPage();
      }),
  GoRoute(
      path: "/sensorDetailPage",
      name: "sensorDetailPage",
      builder: (BuildContext context, GoRouterState state) {
        return const SensorDetailPage(sensorClass: SensorClass());
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
