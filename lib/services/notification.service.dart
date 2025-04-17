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

  GlobalKey<NavigatorState>? _navigatorKey; // Add a nullable navigatorKey

  Future<void> initNotifications(GlobalKey<NavigatorState> navigatorKey) async {
    if (_isInitialized) return;

    _navigatorKey = navigatorKey;

    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher.png',
      //'ic_notification',
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
          if (payload.contains('add-expense')) {
            List<String> parts = payload.split('||');
            String amount = parts[1];
            // print('Amount: $amount');
            print(_navigatorKey);
            print(_navigatorKey?.currentState);
            _navigatorKey?.currentState?.pushNamedAndRemoveUntil(
              '/',
              (route) => false,
            );
            _navigatorKey?.currentState?.pushNamed(
              '/expense-form',
              arguments: amount,
            );
          } else if (payload.contains('add-income')) {
            List<String> parts = payload.split('||');
            String amount = parts[1];
            print('Amount: $amount');
            _navigatorKey?.currentState?.pushNamedAndRemoveUntil(
              '/',
              (route) => false,
            );
            _navigatorKey?.currentState?.pushNamed(
              '/income-form',
              arguments: amount,
            );
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
    print('showing notification...');
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
