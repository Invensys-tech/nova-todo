import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notifications.entity.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationItem extends StatefulWidget {
  final NotificationEntity notification;
  const NotificationItem({super.key, required this.notification});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          Expanded(child: Center(child: Text('Mark As Read'),))
        ],
      ),
      child: Column(
        children: [
          Text(widget.notification.content),
        ],
      ),
    );
  }
}
