import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notifications.entity.dart';
import 'package:flutter_application_1/repositories/notification.repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationItem extends StatefulWidget {
  final NotificationEntity notification;
  final void Function() refetchData;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.refetchData,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isSaving = false;

  updateIsSaving(newIsSaving) {
    setState(() {
      isSaving = newIsSaving;
    });
  }

  markAsRead() async {
    updateIsSaving(true);
    NotificationRepository.markAsRead(widget.notification.id!)
        .then((response) {
          if (response) {
            widget.refetchData();
          }
          updateIsSaving(false);
        })
        .catchError((error) {
          updateIsSaving(false);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // Expanded(child: Center(child: Text('Mark As Read'))),
          Expanded(
            flex: 1,
            child: Container(
              color:
                  widget.notification.isRead
                      ? Colors.grey.shade200
                      : Color(0xFFEC003F),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (isSaving || widget.notification.isRead) {
                      return;
                    }

                    markAsRead();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(.4),
                  ),
                  child:
                      isSaving
                          ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.grey.shade300,
                            ),
                          )
                          : Text(
                            'Mark Read',
                            style: TextStyle(
                              color:
                                  widget.notification.isRead
                                      ? Colors.grey
                                      : Color(0xFFF4F4F5),
                            ),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          //   Todo: actions on tap
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .025,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * .1,
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.02,
            ),
            decoration: BoxDecoration(
              // color: Colors.blueGrey.shade900,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.grey.withOpacity(.5), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  spacing: MediaQuery.of(context).size.width * 0.01,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(Icons.book),
                    Text(
                      widget.notification.content,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: MediaQuery.of(context).size.width * 0.01,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // widget.notification.isRead
                    //     ? Icon(Icons.mark_chat_read, color: Colors.grey)
                    //     : Icon(Icons.mark_chat_unread, color: Colors.green.shade300),
                    Icon(Icons.mark_chat_unread, color: Colors.green.shade300),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
