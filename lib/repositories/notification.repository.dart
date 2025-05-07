import 'package:flutter_application_1/entities/notifications.entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationRepository {
  static Future<List<NotificationEntity>> fetchAll(
    String type, {
    bool includeRead = false,
  }) async {
    try {
      final query = supabaseClient
          .from(Entities.NOTIFICATIONS.dbName)
          .select()
          .eq('type', type);

      if (!includeRead) {
        query.eq('is_read', false);
      }

      final data = await query
          .order('is_read', ascending: false)
          .order('created_at', ascending: false);

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
          .insert(notification.toCreateDBJson())
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
          .eq('id', id)
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
