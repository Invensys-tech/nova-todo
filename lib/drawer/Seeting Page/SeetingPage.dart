import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../main.dart';

class Seetingpage extends StatefulWidget {
  const Seetingpage({super.key});

  @override
  State<Seetingpage> createState() => _SeetingpageState();
}

class _SeetingpageState extends State<Seetingpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loabThemeApp();
  }

  Future<void> loabThemeApp() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('ThemeOfApp')!;
    });
  }

  Future<void> SaveBrightness(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ThemeOfApp', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                "Night Mode",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .25),
              Transform.scale(
                scale: .65,
                child: Switch(
                  activeColor: Color(0xff0D8054),
                  splashRadius: 10,
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      if (isDark) {
                        setState(() {
                          isDark = false;
                        });
                      } else {
                        setState(() {
                          isDark = true;
                        });
                      }
                      isDark
                          ? DynamicTheme.of(context)!.setTheme(AppThemes.Dark)
                          : DynamicTheme.of(
                            context,
                          )!.setTheme(AppThemes.LightBlue);
                    });
                    SaveBrightness(isDark);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * .015),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.width * .015),
          Row(
            children: [
              Text(
                "Language",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .25),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      changeLocale(context, 'am');
                    },
                    child: Text('Change to amharic'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      changeLocale(context, 'en');
                    },
                    child: Text('Change to english'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
