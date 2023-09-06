import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/usecases/subscribe_channel_logic.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/sensor_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/drawer_menu.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/grid_layout_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_blank.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_burger_menu.dart';

import '../../../../core/util/notifications/android_notification_settings.dart';
import '../../../../core/util/notifications/general_notification_settings.dart';
import '../../../../core/util/notifications/ios_notification_settings.dart';
import '../../../../main.dart';
import '../../data/data_sources/supabase_service.dart';
import '../bloc/PinTunnelBloc.dart';
import '../bloc/PinTunnelEvent.dart';
import '../bloc/PinTunnelState.dart';
import '../widgets/grid_item_component.dart';
import '../widgets/top_bar_back_action.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage(
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

class Elements {
  late String title;
  late int randomIndex;

  Elements(this.title, this.randomIndex);
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool _notificationsEnabled = false;
  List<Elements> elements = [
    Elements("Test item 1", 12),
    Elements("Test item 2", 44),
    Elements("Test item 3", 420),
    //Elements("Test item 4", 440)
  ];

  bool isText1Underlined = true;

  void toggleText(){
    setState((){
      isText1Underlined = !isText1Underlined;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkNotificationPermissions();
    configureDidReceiveLocalNotificationSubject(context);
    configureSelectNotificationSubject(context);
    BlocProvider.of<PinTunnelBloc>(context).add(SubscribeChannel(sensorId: 12345));
    BlocProvider.of<PinTunnelBloc>(context).add(SubscribeMinuteChannel(sensorId: 12345));
    BlocProvider.of<PinTunnelBloc>(context).add(SubscribeHourlyChannel(sensorId: 12345));
    BlocProvider.of<PinTunnelBloc>(context).add(GetSensorRange(sensorId: 12345));
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
  Widget build(BuildContext context) {

    _showNotification();
    
    return Scaffold(
      appBar: const TopBarBlank(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(primary: false, slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              for (final el in elements)
                GridItem(
                  title: el.title,
                  randomIndex: el.randomIndex,
                )
            ],
          ),
        )
      ]),
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
