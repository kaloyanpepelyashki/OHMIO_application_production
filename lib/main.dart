import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pin_tunnel_application_production/Providers/global_data_provider.dart';
import 'package:pin_tunnel_application_production/config/routes/routes.dart';
import 'package:pin_tunnel_application_production/config/themes/main_theme.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/dashboard_page.dart';
import "package:provider/provider.dart";
import 'package:supabase_flutter/supabase_flutter.dart';
import "package:timezone/data/latest.dart" as tz;
import 'core/util/notifications/android_notification_settings.dart';
import 'core/util/notifications/general_notification_settings.dart';
import 'core/util/notifications/ios_notification_settings.dart';
import 'dependency_injection.dart';
import 'dependency_injection.dart' as di;
import 'features/feature/data/data_sources/supabase_service.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

NotificationAppLaunchDetails? notificationAppLaunchDetails;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await di.init();
  //ONESIGNAL NOTIFICATIONS
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("714ca8e6-14af-4778-b0d7-02eb3331cffb");
  OneSignal.Notifications.requestPermission(true);

  ///NOTIFICATION SETTINGS
  notificationAppLaunchDetails = !kIsWeb && Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = DashBoardPage.routeName;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    initialRoute = '/sensorPage';
  }

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  //Initializing supabase manager
  await Supabase.initialize(
    url: supabaseManager.supabaseUrl,
    anonKey: supabaseManager.token,
  );

  //* supabaseClient init
  supabaseManager.supabaseClient = Supabase.instance.client;

  //* supabaseSession init
  supabaseManager.supabaseSession =
      supabaseManager.supabaseClient.auth.currentSession;

  FlutterError.onError = (FlutterErrorDetails details) {
    _showError(details.exception.toString());
    debugPrint(details.exception.toString());
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalDataProvider()),
        BlocProvider<PinTunnelBloc>(create: (context) => sl<PinTunnelBloc>())
      ],
      child: const MyApp(),
    ),
  );
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //   if (Platform.isAndroid) {
  //    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  //   }
  // });
}

void _showError(String error) {
  Fluttertoast.showToast(
    msg: error,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 18,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool? _jailbroken;
  bool? _developerMode;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final _session = supabaseManager.supabaseSession;
    String email = _session?.user.email ?? "";
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        BlocProvider.of<PinTunnelBloc>(context)
            .add(UpdateUserStatus(status: "OFFLINE", email: email));
        break;
      case AppLifecycleState.resumed:
        BlocProvider.of<PinTunnelBloc>(context)
            .add(UpdateUserStatus(status: "ONLINE", email: email));
        break;
      default:
        break;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool jailbroken;
    bool developerMode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;
    } on PlatformException {
      jailbroken = true;
      developerMode = true;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _jailbroken = jailbroken;
      _developerMode = developerMode;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return _jailbroken == true
        ? Text("JAILBROKEN DEVICE")
        : MaterialApp.router(
            title: "OHMIO",
            routerConfig: router,
            theme: mainTheme,
          );
  }
}
