import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'general_notification_settings.dart';

AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');


Future<void> showAndroidNotification() async{
  const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, 'Ebits', 'Temperature sensor above max limit !', notificationDetails,
        //payload: 'item x'
        );
}

Future<bool> requestAndroidPermissions() async {
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  final bool? grantedNotificationPermission =
      await androidImplementation?.requestPermission();
  return grantedNotificationPermission ?? false;
}