import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/core/util/notifications/android_notification_settings.dart';
import 'package:pin_tunnel_application_production/core/util/notifications/general_notification_settings.dart';
import 'package:pin_tunnel_application_production/core/util/notifications/ios_notification_settings.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_class.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelState.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dahboard_top_bar_burger_menu.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/dashboard_actuator_widget.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/dashboard_sensor_widget.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/dashboard_sensors_actuators_widget.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/drawer_menu.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/help_widget.dart';

import '../../widgets/top_bar_burger_menu.dart';

class DashBoardPage extends StatefulWidget {
  final String? email;

  const DashBoardPage(
    this.email,
    this.notificationAppLaunchDetails, {
    Key? key,
  }) : super(key: key);

  static const String routeName = '/';

  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  State<DashBoardPage> createState() => DashBoardPageState();
}

class DashBoardPageState extends State<DashBoardPage> {
  bool _notificationsEnabled = false;

  List<SensorClass> sensorsActuatorsElements = [];

  late SensorClass selectedSensor;

  @override
  void initState() {
    //_checkNotificationPermissions();
    //configureDidReceiveLocalNotificationSubject(context);
    //configureSelectNotificationSubject(context);
    //_showNotification();

    BlocProvider.of<PinTunnelBloc>(context)
        .add(GetSensorsForUser(email: widget.email!));
    super.initState();
  }

  Future<void> _checkNotificationPermissions() async {
    if (Platform.isAndroid) {
      final bool granted = await requestAndroidPermissions();
      setState(() {
        _notificationsEnabled = granted;
      });
    } else if (Platform.isIOS || Platform.isMacOS) {
      await requestIOSPermissions();
    }
  }

  Future<void> _showNotification() async {
    if (Platform.isAndroid) {
      await showAndroidNotification();
    }
  }

  @override
  //Widget presentation
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        if (state is SensorsForUserReceivedState) {
          if (state.sensorList.isNotEmpty) {
            //  List<int> listOfMacs = [];
            state.sensorList.forEach((i) {
              if(!sensorsActuatorsElements.contains(i)){
                sensorsActuatorsElements.add(i);
              }
            });
            print("Sensors added");
            //BlocProvider.of<PinTunnelBloc>(context)
            //   .add(GetLatestData(listOfMacs: listOfMacs));
          } else {
            print("Sensor list is empty");
          }
        }

        return Scaffold(
          appBar: const DashboardTopBarBurgerMenu(),
          backgroundColor: Theme.of(context).colorScheme.background,
          endDrawer: const DrawerMenuComponent(),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  DashboardSensorsActuatorsWidget(
                      sensorsActuatorsElements: sensorsActuatorsElements),
                ],
              ),
              //const Positioned(
             //   child: HelpWidget(),
             // )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    closeNotificationStreams();
    super.dispose();
  }

  void _handleSignOut(context) {
    supabaseManager.signOutUser();
    GoRouter.of(context).go("/onboarding");
  }
}
