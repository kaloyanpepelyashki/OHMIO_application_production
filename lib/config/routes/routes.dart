import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/usecases/subscribe_channel_logic.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/authentication/password_reset_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/authentication/user_onboarding_personal_username.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/choose_sensor_page.dart';
//Importing page components
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/dashboard_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/authentication/retreive_tunnel_MAC_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/sensor_connect_first_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/sensor_connect_second_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/sensor_detail_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_connect_guide/pintunnel_tutorial_first_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_connect_guide/pintunnel_tutorial_second_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/chart_full_screen_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/dependency_choose_sensor.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page/dependency_condition_page.dart';
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
        return SplashPage();
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
    },
  ),
  GoRoute(
    path: "/resetPassword",
    builder: (BuildContext context, GoRouterState state) {
      return const ResetPasswordPage();
    },
  ),
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
            path: "onboarding-username",
            builder: (BuildContext context, GoRouterState state) {
              return const OnBoardingUsernamePage();
            }),
        GoRoute(
            path: "onboarding-tunnel-mac",
            builder: (BuildContext context, GoRouterState state) {
              return const RetreiveTunnelMACPage();
            })
      ]),
  GoRoute(
      path: "/dashboard/:email",
      name: "dashboard",
      builder: (BuildContext context, GoRouterState state) {
        final repository = PinTunnelRepository();
        final logic = SubscribeChannelLogic(repository);

        return BlocProvider.value(
          value: BlocProvider.of<PinTunnelBloc>(context),
          child: DashBoardPage(
              state.pathParameters['email'], notificationAppLaunchDetails),
        );
      }),
  GoRoute(
      path: "/sensorPage/:id",
      name: "sensorPage",
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: BlocProvider.of<PinTunnelBloc>(context),
          child: SensorPage(mac_address: state.pathParameters['id'],),
        );
      }),
  GoRoute(
      path: "/chooseSensorPage",
      builder: (BuildContext context, GoRouterState state) {
        return const ChooseSensorPage();
      }),
  GoRoute(
      path:
          "/sensorDetailPage/:isActuator/:sensorDescription/:sensorImage/:sensorName",
      name: "sensorDetailPage",
      builder: (BuildContext context, GoRouterState state) {
        return SensorDetailPage(
          isActuator: state.pathParameters['isActuator']!,
          sensorDescription: state.pathParameters['sensorDescription']!,
          sensorImage: state.pathParameters['sensorImage']!,
          sensorName: state.pathParameters['sensorName']!,
        );
      }),
  GoRoute(
      path: "/sensorConnectFirstPage",
      builder: (BuildContext context, GoRouterState state) {
        return const SensorConnectFirstPage();
      }),
  GoRoute(
      path: "/sensorConnectSecondPage",
      builder: (BuildContext context, GoRouterState state) {
        return const SensorConnectSecondPage();
      }),
  GoRoute(
      path: "/binaryEncoderPage",
      builder: (BuildContext context, GoRouterState state) {
        return const BinaryEncoderPage();
      }),
  GoRoute(
      path: "/pintunnelTutorialFirstPage",
      builder: (BuildContext context, GoRouterState state) {
        return const PintunnelTutorialFirstPage();
      }),
  GoRoute(
      path: "/pintunnelTutorialSecondPage",
      builder: (BuildContext context, GoRouterState state) {
        return const PintunnelTutorialSecondPage();
      }),
  GoRoute(
      path: "/dependencyChooseSensor",
      builder: (BuildContext context, GoRouterState state) {
        return const DependencyChooseSensor();
      }),
  GoRoute(
      path: "/dependencyCondition",
      name: "dependencyCondition",
      builder: (BuildContext context, GoRouterState state) {
        return const DependencyConditionPage();
      }),
]);

void clearNavigationStack(context, String path) {
  final router = GoRouter.of(context);
  router.replace(path);
}
