import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notifications.entity.dart';
import 'package:flutter_application_1/repositories/notification.repository.dart';
import 'package:flutter_application_1/pages/notifications/widgets/notification.item.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                ...snapshot.data!.map(
                  (notification) =>
                      NotificationItem(notification: notification),
                ),
              ],
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error getting notificatoins'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
