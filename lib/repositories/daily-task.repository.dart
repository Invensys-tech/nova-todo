import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DailyTaskRepository {
  Future<DailyTask> addDailyTask(DailyTask dailyTask) async {
    try {
      final response = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .insert(dailyTask.toJson())
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating daily task');
      }

      final data = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .select('*');

      return DailyTask.fromJson(data[data.length - 1]);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<DailyTask>> fetchAll(DateTime? date) async {
    try {
      final query = supabaseClient.from(Entities.DAILY_TASK.dbName).select('*');

      if (date != null) {
        query.eq('date', date.toIso8601String());
      }

      final data = await query;

      return data.map((dailyTask) => DailyTask.fromJson(dailyTask)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DailyTask> fetchById(int id) async {
    try {
      final data =
          await supabaseClient
              .from(Entities.DAILY_TASK.dbName)
              .select('*')
              .eq('id', id)
              .maybeSingle();

      if (data == null) {
        throw Exception('Daily task not found!');
      }

      return DailyTask.fromJson(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DailyTask> fetchView(int id) async {
    try {
      final data =
          await supabaseClient
              .from(Entities.DAILY_TASK.dbName)
              .select('*, daily_sub_tasks(*)')
              .eq('id', id)
              .maybeSingle();

      if (data == null) {
        throw Exception('Daily task not found!');
      }

      return DailyTask.fromJson(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> deleteById(int id) async {
    try {
      final response = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .delete()
          .eq('id', id)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Daily task not found!');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
