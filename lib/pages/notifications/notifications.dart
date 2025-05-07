import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notifications.entity.dart';
import 'package:flutter_application_1/repositories/notification.repository.dart';
import 'package:flutter_application_1/pages/notifications/widgets/notification.item.dart';
import 'package:flutter_translate/flutter_translate.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<List<NotificationEntity>> notifications =
      NotificationRepository.fetchAll('APP');

  @override
  void initState() {
    super.initState();
  }

  refetchData() {
    // print('refetch data');
    notifications = NotificationRepository.fetchAll('APP');
  }

  @override
  Widget build(BuildContext context) {
    final testnotifications = [
      NotificationEntity.fromDBJson({
        'id': 1,
        'content': 'This is my sixth notification',
        'type': 'APP',
      }),
      NotificationEntity.fromDBJson({
        'id': 2,
        'content': 'This is my seventh notification',
        'type': 'APP',
      }),
      NotificationEntity.fromDBJson({
        'id': 3,
        'content': 'This is my eighth notification',
        'type': 'APP',
      }),
      NotificationEntity.fromDBJson({
        'id': 4,
        'content': 'This is my ninth notification',
        'type': 'APP',
        'is_read': true,
      }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(translate("Notifications")),
            SizedBox(width: MediaQuery.of(context).size.width * .015),
            Container(
              height: MediaQuery.of(context).size.height * .03,
              width: MediaQuery.of(context).size.width * .06,
              child: Image.asset('assets/Gif/Habit.gif'),
            ),
          ],
        ),
        centerTitle: false,
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left, color: Colors.green),
            ),
          ],
        ),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: notifications,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                spacing: MediaQuery.of(context).size.height * .015,
                children: [
                  ...snapshot.data!.map(
                    (notification) => NotificationItem(
                      notification: notification,
                      refetchData: refetchData,
                    ),
                  ),
                ],
              );
            } else {
              if (snapshot.hasError) {
                // return Column(
                //   spacing: MediaQuery.of(context).size.height * .015,
                //   children: [
                //     ...testnotifications.map(
                //       (notification) =>
                //           NotificationItem(notification: notification, refetchData: refetchData,),
                //     ),
                //   ],
                // );
                return Center(child: Text('Error getting notifications'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          },
        ),
      ),
    );
  }
}
