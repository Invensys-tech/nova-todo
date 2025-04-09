// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotifications() async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings(
      // '@mipmap/ic_launcher',
      'ic_notification',
    );
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) async {
        final String? payload = details.payload;
        if (payload != null && payload.isNotEmpty) {
          switch (payload) {
            case 'test':
              // print('Notification tapped with payload: $payload');
              break;
            case 'add-expense':
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              );
              navigatorKey.currentState?.pushNamed('/expense-form');
              break;
            case 'add-income':
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              );
              navigatorKey.currentState?.pushNamed('/income-form');
              break;
            default:
            // print('Notification tapped with unknown payload: $payload');
          }
        }
      },
    );

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'test_notification_channel',
        'Test Notification',
        channelDescription: 'This is a test notification channel',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  Future<void> showNotification(
    int id,
    String title,
    String body, {
    String payload = '',
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
      payload: payload,
    );
  }

  scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
