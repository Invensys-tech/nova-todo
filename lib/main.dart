import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:another_telephony/telephony.dart';
import 'package:flutter_application_1/services/sms.service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/finance/income/form.income.dart';
import 'package:flutter_application_1/services/auth.gate.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotifications();
  await Hive.initFlutter();
  HiveService hiveService = HiveService();
  await hiveService.initHive(boxName: 'session');
  dynamic data = await hiveService.getData('user');
  print('----------------- user store in hive -----------------');
  print(jsonEncode(data));
  await Supabase.initialize(
    url: "https://iazgcqadmrjhszpeqxpj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhemdjcWFkbXJqaHN6cGVxeHBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIzODMxNDksImV4cCI6MjA1Nzk1OTE0OX0.v70ChJdX7BiAjvW3DmeZ1ekZ9gKGQ5zNxgbaKfsCC9c",
  );

  runApp(MyApp(isLoggedIn: data != null));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, this.isLoggedIn = false});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final themeCollection = ThemeCollection(
    themes: {
      0: ThemeData(primarySwatch: Colors.blue),
      1: ThemeData(primarySwatch: Colors.red),
      2: ThemeData.dark(),
    },
    fallbackTheme:
        ThemeData.light(), // optional fallback theme, default value is ThemeData.light()
  );

  @override
  void initState() {
    super.initState();
    _checkAndListenSms(); // Call the function here!
  }

  final Telephony telephony = Telephony.instance;
  StreamSubscription<SmsMessage>? _onSmsReceived;
  String _permission = 'Not Requested';

  Future<void> _checkAndListenSms() async {
    if (Platform.isAndroid) {
      final permissions = await Permission.sms.request();
      if (permissions.isGranted) {
        setState(() => _permission = 'Granted');
        _startListener();
        print(_permission);
      } else {
        setState(() => _permission = 'Denied');
        print(_permission);
      }
    } else {
      setState(() => _permission = 'Not Available on iOS');
    }
  }

  void _startListener() {
    print('in start listener');
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage msg) {
        print('New SMS: ${msg.address} - ${msg.body}');
        SmsService().parseSms(msg);
      },
      listenInBackground: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: themeCollection,
      defaultThemeId: AppThemes.Dark, // optional, default id is 0
      builder: (context, theme) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Vita Board',
          theme: theme,
<<<<<<< HEAD
          // home: const MainScreenPage(),
          home: widget.isLoggedIn ? const MainScreenPage() : const AuthGate(),
=======
          // home: const AuthGate(),
          // home: widget.isLoggedIn ? const MainScreenPage() : const AuthGate(),
>>>>>>> 8a9c9a605a969a47ec80e4141047e9e1be265b93
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          routes: {
            '/':
                (context) =>
                    widget.isLoggedIn
                        ? const MainScreenPage()
                        : const AuthGate(),
            '/login': (context) => const AuthGate(),
            '/expense-form':
                (context) => AddExpense(datamanager: Datamanager()),
            '/income-form': (context) => IncomeForm(datamanager: Datamanager()),
          },
        );
      },
    );
    /*return MaterialApp(
      title: 'Coffee Masters',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const IntorPage(),
      debugShowCheckedModeBanner: false,
    );*/
  }
}

class AppThemes {
  static const int LightBlue = 0;
  static const int LightRed = 1;
  static const int Dark = 2;
}
