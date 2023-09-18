import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/user_class.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/dashboard_actuator_widget.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/dashboard_sensor_widget.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/drawer_menu.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_burger_menu.dart';

import '../../../../../core/util/notifications/android_notification_settings.dart';
import '../../../../../core/util/notifications/general_notification_settings.dart';
import '../../../../../core/util/notifications/ios_notification_settings.dart';
import '../../../data/data_sources/supabase_service.dart';
import '../../../domain/entities/sensor_class.dart';
import '../../bloc/PinTunnelBloc.dart';
import '../../bloc/PinTunnelEvent.dart';
import '../../widgets/dashboard/dashboard_elements.dart';

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
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool _notificationsEnabled = false;
  List<Elements> sensorElements = [
    //Elements("Test item 4", 440)
  ];

  List<Elements> actuatorElements = [];

  bool isText1Underlined = true;

  late SensorClass selectedSensor;

  void toggleText() {
    setState(() {
      isText1Underlined = !isText1Underlined;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkNotificationPermissions();
    configureDidReceiveLocalNotificationSubject(context);
    configureSelectNotificationSubject(context);
    _showNotification();
/*
    BlocProvider.of<PinTunnelBloc>(context)
        .add(const SubscribeHourlyChannel(sensorId: 12345));
    BlocProvider.of<PinTunnelBloc>(context)
        .add(const SubscribeChannel(sensorId: 12345));
    BlocProvider.of<PinTunnelBloc>(context)
        .add(const GetSensorRange(sensorId: 12345));
        */
    if (widget.email != null) {
      BlocProvider.of<PinTunnelBloc>(context)
      .add(GetSensorsForUser(email: "kuba.kolando.02.01@gmail.com"));
          //.add(GetSensorsForUser(email: widget.email!));
    }
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
    //Not working yet
    debugPrint("email: ${userProfile.email}");
    return Scaffold(
      appBar: const TopBarBurgerMenu(),
      backgroundColor: Theme.of(context).colorScheme.background,
      endDrawer: const DrawerMenuComponent(),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My system",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                    ),
                    onPressed: () => {
                      GoRouter.of(context)
                          .push(
                        "/chooseSensorPage",
                      )
                          .then((result) {
                        if (result != null) {
                          selectedSensor = result as SensorClass;
                          selectedSensor.isActuator!
                              ? actuatorElements.add(Elements(
                                  isActuator: selectedSensor.isActuator!,
                                  sensorDescription:
                                      selectedSensor.sensorDescription!,
                                  sensorImage: selectedSensor.sensorImage!,
                                  sensorName: selectedSensor.sensorName!))
                              : sensorElements.add(Elements(
                                  isActuator: selectedSensor.isActuator!,
                                  sensorDescription:
                                      selectedSensor.sensorDescription!,
                                  sensorImage: selectedSensor.sensorImage!,
                                  sensorName: selectedSensor.sensorName!));
                          print(selectedSensor);
                        }
                      })
                    },
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 11, 0),
                      child: GestureDetector(
                        onTap: toggleText,
                        child: Text(
                          "Sensor",
                          style: TextStyle(
                            fontSize: 17,
                            decoration: isText1Underlined
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: toggleText,
                    child: Text(
                      "Actuator",
                      style: TextStyle(
                        fontSize: 17,
                        decoration: isText1Underlined
                            ? TextDecoration.none
                            : TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )),
          isText1Underlined
              ? DashboardSensorWidget(
                  sensorElements: sensorElements,
                )
              : DashboardActuatorWidget(actuatorElements: actuatorElements)
        ],
      ),
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
