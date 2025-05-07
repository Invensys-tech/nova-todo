import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:another_telephony/telephony.dart';
import 'package:flutter_application_1/drawer/Seeting%20Page/SeetingPage.dart';
import 'package:flutter_application_1/drawer/productivity/productivity.home.dart';
import 'package:flutter_application_1/pages/auth/payment.dart';
import 'package:flutter_application_1/pages/pricing/pricing.dart';
import 'package:flutter_application_1/providers/preferences.provider.dart';
import 'package:flutter_application_1/providers/user.provider.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/sms.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/localization/localization_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'drawer/Seeting Page/SeetingPage.dart';

bool isDark = true;
int userId = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  requestNotificationPermission();
  NotificationService().initNotifications(navigatorKey);
  await Hive.initFlutter();
  HiveService hiveService = HiveService();
  await hiveService.initHive(boxName: 'session');
  HiveService hiveService2 = HiveService();
  await hiveService2.initHive(boxName: "dateTime");
  await hiveService2.upsertData("dateTime", "Gregorian");
  updatePreference({'calendar-system': 'Gregorian'});

  HiveService hiveService3 = HiveService();
  await hiveService3.initHive(boxName: "dateTime");

  dynamic data = await hiveService.getData('user');
  // print('printing user data');
  // print(data);
  updateUser(data);
  // print('----------------- user store in hive -----------------');
  // print(jsonEncode(data));
  await Supabase.initialize(
    url: "https://iazgcqadmrjhszpeqxpj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhemdjcWFkbXJqaHN6cGVxeHBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIzODMxNDksImV4cCI6MjA1Nzk1OTE0OX0.v70ChJdX7BiAjvW3DmeZ1ekZ9gKGQ5zNxgbaKfsCC9c",
  );

  InitPage initPage = InitPage.AUTH;

  bool isLoggedIn = data != null && data['phoneNumber'] != null;

  if (isLoggedIn) {
    initPage = InitPage.PAYMENT;
  }

  try {
    bool isSubscriptionActive = DateTime.now().isBefore(
      (await UserRepository().getSubscriptionEndDate(data['phoneNumber'])),
    );

    if (isSubscriptionActive) {
      initPage = InitPage.HOME;
    }
  } catch (e) {
    print('Error getting sub end date initializing Supabase');
  }

  final delegate = await setupLocalization();
  final prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('languageCode');
  if (languageCode != null) {
    await delegate.changeLocale(Locale(languageCode));
  }

  // runApp(LocalizedApp(delegate, MyApp(initPage: InitPage.HOME)));
  runApp(LocalizedApp(delegate, ProviderScope(child: MyApp(initPage: initPage))));
}

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  // final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
  //     ?.requestPermissions(alert: true, badge: true, sound: true);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  final InitPage initPage;
  const MyApp({super.key, this.initPage = InitPage.AUTH});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _currentThemeId = AppThemes.Dark;
  final themeCollection = ThemeCollection(
    themes: {
      AppThemes.LightBlue: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        primaryColorLight: Colors.black.withOpacity(.7),
        primaryColorDark: Colors.white,
        cardColor: Color(0xffD4D4D8),
        disabledColor: Color(0xff00D492),
        fontFamily: 'Outfit',
        scaffoldBackgroundColor: Color(0xffF4F4F5),
      ),
      AppThemes.LightRed: ThemeData(
        brightness: Brightness.light,
        primaryColorLight: Colors.black.withOpacity(.7),
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Color(0xffF4F4F5),
        disabledColor: Color(0xff00D492),
        cardColor: Color(0xffD4D4D8),
        fontFamily: 'Outfit',
      ),
      AppThemes.Dark: ThemeData(
        brightness: Brightness.dark,
        disabledColor: Color(0xff006045),
        cardColor: Color(0xff3F3F47),
        primaryColorDark: Color(0xff1a1a1a),
        fontFamily: 'Outfit',
      ),
    },
    fallbackTheme: ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Outfit'),
    ),
  );

  @override
  void initState() {
    super.initState();
    loadTheme();
    _checkAndListenSms();
    loabThemeApp();
    getId();
  }

  getId() async {
    int id = (await AuthService().findSession())['id'];
    setState(() {
      userId = id;
    });
  }

  Future<void> initAll() async {
    HiveService hiveService3 = HiveService();
    await hiveService3.initHive(boxName: "dateTime");
    final stored = await hiveService3.getData('dateTime');
    setState(() {
      stored == 'Ethiopian' ? 'Ethiopian' : 'Gregorian';
      if (stored == "Ethiopian") {
        setState(() {
          eth = true;
        });
      } else {
        setState(() {
          eth = false;
        });
      }
    });
  }

  Future<void> loabThemeApp() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('ThemeOfApp')!;
    });
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentThemeId = prefs.getInt('ThemeOfApp') ?? AppThemes.Dark;
    });
  }

  Future<void> saveTheme(int themeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('ThemeOfApp', themeId);
    setState(() {
      _currentThemeId = themeId;
    });
  }

  final Telephony telephony = Telephony.instance;
  // StreamSubscription<SmsMessage>? _onSmsReceived;
  String _permission = 'Not Requested';

  Future<void> _checkAndListenSms() async {
    if (kIsWeb) {
      setState(() => _permission = 'Not Available on Web');
      return;
    }

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
  Widget build(BuildContext appContext) {
    final localizationDelegate = LocalizedApp.of(context).delegate;
    return DynamicTheme(
      themeCollection: themeCollection,
      defaultThemeId: _currentThemeId, // optional, default id is 0
      builder: (context, theme) {
        return LocalizationProvider(
          state: LocalizationProvider.of(appContext).state,
          // state: LocalizedApp.of(context).,
          child: MaterialApp(
            // supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale ?? Locale('en'),
            supportedLocales: const [
              Locale('en'), // English
              Locale('am'), // Amharic
            ],
            navigatorKey: navigatorKey,
            title: 'Vita Board',
            theme: theme,
            builder: (context, child) {
              // 👇 This forces text scale factor to be 1.0 across the app
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            // home: const MainScreenPage(),
            // home: widget.isLoggedIn ? const MainScreenPage() : const AuthGate(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              localizationDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FlutterQuillLocalizations
                  .delegate, // Add this line for FlutterQuill localization
            ],
            //locale: Locale('en', 'US'),
            routes: {
              '/':
                  (context) =>
                      widget.initPage == InitPage.HOME
                          ? const MainScreenPage()
                          : widget.initPage == InitPage.PAYMENT
                          ? PricingScreen()
                          : const AuthGate(),
              // (context) => const MainScreenPage(),
              '/login': (context) => const AuthGate(),
              '/expense-form':
                  (context) => AddExpense(datamanager: Datamanager()),
              '/income-form':
                  (context) => IncomeForm(datamanager: Datamanager()),
              '/productivity-home': (context) => ProductivityHome(),
            },
          ),
        );
      },
    );
  }
}

class AppThemes {
  static const int LightBlue = 0;
  static const int LightRed = 1;
  static const int Dark = 2;
}
