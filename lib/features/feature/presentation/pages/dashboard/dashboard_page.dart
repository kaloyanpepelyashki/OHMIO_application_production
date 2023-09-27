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
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/dashboard_actuator_widget.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/dashboard_sensor_widget.dart';
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
  List<SensorClass> sensorElements = [
    //Elements("Test item 4", 440)
  ];

  List<SensorClass> actuatorElements = [];

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

    //BlocProvider.of<PinTunnelBloc>(context)
    //  .add(GetSensorsForUser(email: widget.email!));

    //BlocProvider.of<PinTunnelBloc>(context)
    //  .add(const SubscribeHourlyChannel(sensorId: 12345));
    //  BlocProvider.of<PinTunnelBloc>(context)
    //   .add(const SubscribeMinuteChannel(sensorId: 12345));
    //BlocProvider.of<PinTunnelBloc>(context)
    //    .add(const GetSensorRange(sensorId: 12345));
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
        if (state is SensorsForUserReceivedState) {
          if (state.sensorList.isNotEmpty) {
            state.sensorList.forEach((i) {
              if (i.isActuator!) {
                print("ACTUATOR ADDED");
                actuatorElements.add(i);
              }
              if (i.isActuator! == false) {
                sensorElements.add(i);
              }
            });
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const TopBarBurgerMenu(),
          backgroundColor: Theme.of(context).colorScheme.background,
          endDrawer: const DrawerMenuComponent(),
          body: Stack(
            children: [
              Column(
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
                              GoRouter.of(context).push(
                                "/chooseSensorPage",
                              )
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
                                onTap: isText1Underlined ? () {} : toggleText,
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
                            onTap: isText1Underlined ? toggleText : () {},
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
                          onSensorLoaded: (i) {
                            if (!sensorElements.contains(i)) {
                              sensorElements.add(i);
                            }
                          },
                          sensorElements: sensorElements,
                        )
                      : DashboardActuatorWidget(
                          onActuatorLoaded: (i) {
                            if (!actuatorElements.contains(i)) {
                              actuatorElements.add(i);
                            }
                          },
                          actuatorElements: actuatorElements),
                ],
              ),
              HelpWidget(),
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
