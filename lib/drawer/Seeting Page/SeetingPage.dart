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

  @override
  void initState() {
    super.initState();
    _hiveService = HiveService();
    _loadTheme();
    _loadDateType();
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInPage()),
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
                    activeColor: const Color(0xff0D8054),
                    value: isDark,
                    onChanged: (value) {
                      setState(() => isDark = value);
                      isDark
                          ? DynamicTheme.of(context)!.setTheme(AppThemes.Dark)
                          : DynamicTheme.of(
                            context,
                          )!.setTheme(AppThemes.LightBlue);
                      _saveBrightness(value);
                    },
                  ),
                ),
              ],
            ),

            const Divider(height: 32),

            // --- Language buttons
            Row(
              children: [
                const Text(
                  "Language",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => changeLocale(context, 'am'),
                      child: const Text('Change to Amharic'),
                    ),
                    ElevatedButton(
                      onPressed: () => changeLocale(context, 'en'),
                      child: const Text('Change to English'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --- Date type dropdown
            const Text(
              "Date",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            DropdownButtonHideUnderline(
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

            const SizedBox(height: 32),

            // --- Logout button
            Center(
              child: ElevatedButton(
                onPressed: _confirmLogout,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Logout'),
              ),
            ),

            const SizedBox(height: 16),

            // --- Delete Account button
            Center(
              child: ElevatedButton(
                onPressed: _confirmDeleteAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('Delete Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
