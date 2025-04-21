import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/drawerpage.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/habit/components/habit.view.dart';
import 'package:flutter_application_1/pages/goal/form.goal.dart';
import 'package:flutter_application_1/pages/habit/form.habit.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity.dart';
import 'package:flutter_application_1/pages/quotes/components/quotes-list.dart';
import 'package:flutter_application_1/pages/todopage/todo-view.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_application_1/repositories/quote.repository.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/chapa.service.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:flutter_application_1/services/sms.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/pages/homepage/dashboard.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
      drawer: Drawer(child: Drawerpage(), backgroundColor: Colors.transparent),
      body: Dashboard(),
      // body: Column(
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {
      //         changeLocale(context, 'am');
      //       },
      //       child: Text('Change to amharic'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         changeLocale(context, 'en');
      //       },
      //       child: Text('Change to english'),
      //     ),
      //   ],
      // ),
      // body: HabitForm(refetchData: () {}),
      // body: StepperForm(),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   spacing: MediaQuery.of(context).size.height * 0.02,
      //   children: [
      //     // FutureBuilder(future: future, builder: builder),
      //     ElevatedButton(
      //       onPressed: () {
      //         // print("Sending notification...");
      //         NotificationService().showNotification(
      //           1,
      //           'Reminder',
      //           'Time for you task',
      //         );
      //       },
      //       child: Icon(Icons.notification_add),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         // print("Sending timed notification...");
      //         NotificationService().scheduleNotification(
      //           id: 1,
      //           title: 'Todo Reminder',
      //           body: 'Time for you task in 5',
      //           time: DateTime.now().add(Duration(seconds: 5)),
      //         );
      //       },
      //       child: Icon(Icons.notification_important),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         AuthService().logout();
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => LogInPage()),
      //         );
      //       },
      //       child: Text('Logout'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         UserRepository().fetchUsers();
      //       },
      //       child: Text('Log Users'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         HiveService hiveService = HiveService();
      //         await hiveService.initHive(boxName: 'session');
      //         dynamic data = await hiveService.getData('user');
      //         print('----------------- user store in hive -----------------');
      //         print(jsonEncode(data));
      //       },
      //       child: Text('Print Session'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         print("Sending expense notification...");
      //         NotificationService().showNotification(
      //           -2,
      //           'Income',
      //           'Tap to add expense from CBE',
      //           payload: 'add-expense||200.00',
      //         );
      //       },
      //       child: Text('Expense Notification'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         print("Sending income notification...");
      //         NotificationService().showNotification(
      //           -2,
      //           'Income',
      //           'Tap to add income from CBE',
      //           payload: 'add-income||300.00',
      //         );
      //       },
      //       child: Text('Income Notification'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         print("Sending message...");
      //         // NotificationService().showNotification(
      //         //   2,
      //         //   'Income',
      //         //   'Tap to add income',
      //         //   payload: 'add-income',
      //         // );
      //         // SmsService().sendSms('0943656931', 'good morning');
      //       },
      //       child: Text('Send Message'),
      //     ),
      //   ],
      // ),
    );
  }
}
