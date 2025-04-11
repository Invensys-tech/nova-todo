import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
    url: "https://iazgcqadmrjhszpeqxpj.supabase.co",
    anonKey:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhemdjcWFkbXJqaHN6cGVxeHBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIzODMxNDksImV4cCI6MjA1Nzk1OTE0OX0.v70ChJdX7BiAjvW3DmeZ1ekZ9gKGQ5zNxgbaKfsCC9c",
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeCollection = ThemeCollection(
    themes: {
      AppThemes.LightBlue: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Outfit',
      ),
      AppThemes.LightRed: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Outfit',
      ),
      AppThemes.Dark: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Outfit',
      ),
    },
    fallbackTheme: ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Outfit'),
    ),
  );
  int _currentThemeId = AppThemes.LightBlue; // Default theme

  @override
  void initState() {
    super.initState();
    loadTheme(); // Load theme at startup
  }

  /// Load saved theme from SharedPreferences
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentThemeId = prefs.getInt('ThemeOfApp') ?? AppThemes.LightBlue;
    });
  }

  /// Save the selected theme to SharedPreferences
  Future<void> saveTheme(int themeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('ThemeOfApp', themeId);
    setState(() {
      _currentThemeId = themeId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: themeCollection,
      defaultThemeId: _currentThemeId,
      builder: (context, theme) {
        return MaterialApp(
          //supportedLocales: context.supportedLocales,
          //localizationsDelegates: context.localizationDelegates,
          //locale: context.locale,
          title: 'Coffee Masters',
          theme: theme,
          home: MainScreenPage(), // Pass function to change theme
          debugShowCheckedModeBanner: false,
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




