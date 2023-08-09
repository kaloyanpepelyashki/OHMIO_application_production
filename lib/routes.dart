import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/pages/binary_encoder_page.dart';
import 'package:pin_tunnel_application_production/pages/confirm_email_page.dart';
//Importing page components
import 'package:pin_tunnel_application_production/pages/dashboard_page.dart';
import 'package:pin_tunnel_application_production/pages/login_page.dart';
import 'package:pin_tunnel_application_production/pages/login_page_ghost.dart';
import 'package:pin_tunnel_application_production/pages/onboarding_page.dart';
import 'package:pin_tunnel_application_production/pages/signup_page.dart';
import 'package:pin_tunnel_application_production/pages/splash_page.dart';
import 'package:pin_tunnel_application_production/pages/user_onboarding_personal.dart';

GoRouter router = GoRouter(routes: <GoRoute>[
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
            })
      ]),
  GoRoute(
      path: "/dashboard",
      builder: (BuildContext context, GoRouterState state) {
        return const DashBoardPage();
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
