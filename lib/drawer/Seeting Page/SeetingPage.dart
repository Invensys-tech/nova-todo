import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../main.dart';

bool eth = true;

class Seetingpage extends StatefulWidget {
  const Seetingpage({super.key});

  @override
  State<Seetingpage> createState() => _SeetingpageState();
}

class _SeetingpageState extends State<Seetingpage> {
  late HiveService _hiveService;
  String _selectedDateType = 'Gregorian'; // default
  String _selectedlangugetype = 'am';

  @override
  void initState() {
    super.initState();
    _hiveService = HiveService();
    _loadTheme();
    _loadDateType();
    _loadSelectedLanguage();
  }

  void _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLang = prefs.getString('languageCode');
    if (savedLang != null && ['am', 'en'].contains(savedLang)) {
      setState(() {
        _selectedlangugetype = savedLang;
      });
    }
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('ThemeOfApp') ?? false;
    });
  }

  Future<void> _saveBrightness(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ThemeOfApp', value);
  }

  Future<void> _loadDateType() async {
    await _hiveService.initHive(boxName: 'dateTime');
    final stored = await _hiveService.getData('dateType');
    setState(() {
      _selectedDateType = stored ?? 'Gregorian';
    });
  }

  Future<void> _saveDateType(String newType) async {
    await _hiveService.upsertData('dateType', newType);
    setState(() {
      _selectedDateType = newType;
    });
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  AuthService().logout();
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => LogInPage()),
                  // );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogInPage()),
                    (Route<dynamic> route) =>
                        false, // This will remove all previous routes
                  );
                  // Call your logout function here
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Call your delete account function here
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Night mode switch
            Row(
              children: [
                const Text(
                  "Night Mode",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
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
                      _saveBrightness(isDark);
                    },
                  ),
                ),
              ],
            ),

            const Divider(height: 32),

            // --- Language buttons
            // Row(
            //   children: [
            //     const Text(
            //       "Language",
            //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            //     ),
            //     const Spacer(),
            //     Column(
            //       children: [
            //         ElevatedButton(
            //           onPressed: () async{  await changeLocale(context, 'am');
            //
            //            setLocale(Locale('am'));
            //
            //
            //           },
            //           child: const Text('Change to Amharic'),
            //
            //         ),
            //         ElevatedButton(
            //           onPressed: () async {
            //             await changeLocale(context, 'en');
            //              setLocale(Locale('en'));
            //             },
            //           child: const Text('Change to English'),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "languge",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(.4),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedlangugetype,
                      items: const [
                        DropdownMenuItem(value: "am", child: Text("Amargna")),
                        DropdownMenuItem(value: "en", child: Text("English")),
                      ],
                      onChanged: (value) async {
                        if (value != null) {
                          await changeLocale(context, value);
                          setLocale(Locale(value));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- Date type dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(.4),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedDateType,
                      items: const [
                        DropdownMenuItem(
                          value: "Ethiopian",
                          child: Text("Ethiopian"),
                        ),
                        DropdownMenuItem(
                          value: "Gregorian",
                          child: Text("Gregorian"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          _saveDateType(value);
                          setState(() {
                            eth = value == "Ethiopian";
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // --- Logout button
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _confirmLogout,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .45,
                      height: MediaQuery.of(context).size.height * .05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(width: 1, color: Colors.red),
                      ),
                      child: Center(child: Text('Logout')),
                    ),
                  ),

                  GestureDetector(
                    onTap: _confirmDeleteAccount,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .45,
                      height: MediaQuery.of(context).size.height * .05,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(width: 1, color: Colors.red),
                      ),
                      child: Center(child: const Text('Delete Account')),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- Delete Account button
          ],
        ),
      ),
    );
  }
}
