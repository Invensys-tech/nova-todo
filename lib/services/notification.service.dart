// import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
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

    const  AndroidInitializationSettings initSettingsAndroid= AndroidInitializationSettings(
      //'@mipmap/ic_launcher',
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
        icon:  'ic_notification'
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

  checkSetNotification() async {
    final hiveService = HiveService();
    await hiveService.initHive(boxName: 'notification');
    final lastQuoteNotificationDate = await hiveService.getData('last-quote-notification-date');
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    if (
      lastQuoteNotificationDate == null
          || lastQuoteNotificationDate != getDateOnly(DateTime.now())
      ) {
      int userId = (await AuthService().findSession())['id'];
      final quotes = await supabaseClient
          .from('quotes')
          .select('text')
          .eq('user_id', userId);

      final notificationService = NotificationService();
      if (lastQuoteNotificationDate != getDateOnly(yesterday)) {
        if (quotes.isNotEmpty) {
          final random = Random();
          String randomQuote = quotes[random.nextInt(quotes.length)]['quote'];
          notificationService.showNotification(-23, 'Daily Quote', randomQuote);
        } 
      }

      if (quotes.isNotEmpty) {
        final random = Random();
        String randomQuote = quotes[random.nextInt(quotes.length)]['quote'];
        await notificationService.showNotification(-23, 'Daily Quote', randomQuote);

        DateTime tomorrow = DateTime.now().add(Duration(days: 1));
        await notificationService.scheduleNotification(id: -23, title: 'Daily Quote', body: randomQuote, time: getStartOfDay(tomorrow));
        await hiveService.upsertData('last-quote-notification-date', getDateOnly(DateTime.now()));
      }
    }
  }

  sendQuoteNotification() async {
    int userId = (await AuthService().findSession())['id'];

    final quotes = await supabaseClient
        .from('quotes')
        .select('text')
        .eq('user_id', userId);

    final notificationService = NotificationService();
      if (quotes.isNotEmpty) {
        final random = Random();
        String randomQuote = quotes[random.nextInt(quotes.length)]['quote'];
        notificationService.showNotification(-23, 'Daily Quote', randomQuote);
      }
  }
}
