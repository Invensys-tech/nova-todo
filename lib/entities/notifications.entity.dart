class NotificationEntity {
  final int? id;
  final String content;
  final bool isRead;
  final int? userId;
  final String type; // can only be 'USER' or 'APP'

  NotificationEntity({
    this.id,
    required this.content,
    required this.type,
    this.isRead = false,
    this.userId,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> notificationData) =>
      NotificationEntity(
        id: notificationData['id'],
        content: notificationData['content'],
        isRead: notificationData['is_read'],
        userId: notificationData['user_id'],
        type: notificationData['type'],
      );

  factory NotificationEntity.fromDBJson(Map<String, dynamic> notificationData) =>
      NotificationEntity(
        id: notificationData['id'],
        content: notificationData['content'],
        isRead: notificationData['is_read'],
        type: notificationData['type'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'is_read': isRead,
    'user_id': userId,
    'type': type,
  };

  Map<String, dynamic> toDBJson() => {
    'id': id,
    'content': content,
    'is_read': isRead,
    'type': type,
  };
}

enum NotificationType {USER, APP}
