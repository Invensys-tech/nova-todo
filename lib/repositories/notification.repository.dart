import 'package:flutter_application_1/entities/notifications.entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationRepository {
  static Future<List<NotificationEntity>> fetchAll(
    String type, {
    bool includeRead = false,
  }) async {
    try {
      final data = await supabaseClient
          .from(Entities.NOTIFICATIONS.dbName)
          .select()
          .eq('type', type)
          .eq('is_read', includeRead);

      final notifications =
          data.map((notification) {
            return NotificationEntity.fromJson(notification);
          }).toList();

      return notifications;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> createNotification(
    NotificationEntity notification,
  ) async {
    try {
      final data = await supabaseClient
          .from(Entities.NOTIFICATIONS.dbName)
          // .insert(notification.toJson())
          .insert(notification.toDBJson())
          .count(CountOption.exact);

      if (data.count == 0) {
        throw Exception('Notification not created');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> markAsRead(int id) async {
    try {
      final data = await supabaseClient
          .from(Entities.NOTIFICATIONS.dbName)
          .update({'is_read': true})
          .count(CountOption.exact);

      if (data.count == 0) {
        throw Exception('Notification not created');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
