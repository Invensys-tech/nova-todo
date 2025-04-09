import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/drawerpage.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';

class HomePage extends StatefulWidget {
  final Datamanager datamanager;
  const HomePage({super.key, required this.datamanager});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(child: Drawerpage()),
      // body: Column(children: [Container(child: Text("he"))]),
      body: Column(
        children: [
          // FutureBuilder(future: future, builder: builder),
          ElevatedButton(
            onPressed: () {
              print("Sending notification...");
              NotificationService().showNotification(
                1,
                'Reminder',
                'Time for you task',
              );
            },
            child: Icon(Icons.notification_add),
          ),
          ElevatedButton(
            onPressed: () {
              print("Sending timed notification...");
              NotificationService().scheduleNotification(
                id: 1,
                title: 'Todo Reminder',
                body: 'Time for you task in 5',
                time: DateTime.now().add(Duration(seconds: 5)),
              );
            },
            child: Icon(Icons.notification_important),
          ),
          ElevatedButton(
            onPressed: () {
              AuthService().logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogInPage()),
              );
            },
            child: Text('Logout'),
          ),
          ElevatedButton(
            onPressed: () {
              UserRepository().fetchUsers();
            },
            child: Text('Log Users'),
          ),
          ElevatedButton(
            onPressed: () async {
              HiveService hiveService = HiveService();
              await hiveService.initHive(boxName: 'session');
              dynamic data = await hiveService.getData('user');
              print('----------------- user store in hive -----------------');
              print(jsonEncode(data));
            },
            child: Text('Print Session'),
          ),
          ElevatedButton(
            onPressed: () async {
              print("Sending expense notification...");
              NotificationService().showNotification(
                2,
                'Expense',
                'Tap to add expense',
                payload: 'add-expense',
              );
            },
            child: Text('Expense Notification'),
          ),
          ElevatedButton(
            onPressed: () async {
              print("Sending income notification...");
              NotificationService().showNotification(
                2,
                'Income',
                'Tap to add income',
                payload: 'add-income',
              );
            },
            child: Text('Income Notification'),
          ),
        ],
      ),
    );
  }
}
