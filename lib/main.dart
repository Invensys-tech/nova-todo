import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/pages/intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    fallbackTheme: ThemeData.light(), // optional fallback theme, default value is ThemeData.light()
  );

  @override
  Widget build(BuildContext context) {

    return DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: AppThemes.Dark, // optional, default id is 0
        builder: (context, theme) {
          return MaterialApp(
            title: 'Coffee Masters',
            theme: theme,
            home: const MainScreenPage(),
            debugShowCheckedModeBanner: false,
          );
        }
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