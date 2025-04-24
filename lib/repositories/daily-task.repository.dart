import 'dart:convert';

import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DailyTaskRepository {
  AuthService authService = AuthService();

  Future<DailyTask> addDailyTask(DailyTask dailyTask) async {
    try {
      final userId = (await authService.findSession())['id'];
      final response = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          // .insert({...dailyTask.toJson(), 'user_id': userId})
          .insert({...dailyTask.toJson(), 'user_id': userId})
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating daily task');
      }

      final createdTodos = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .select('*')
          .order('created_at', ascending: false);

      int currentTodoId = createdTodos[0]['id'];

      final subTasks =
          dailyTask.subTasks
              .map(
                (subTask) => {
                  ...subTask.toJson(),
                  'daily_task_id': currentTodoId,
                },
              )
              .toList();

      for (var subTask in subTasks) {
        // print(jsonEncode(subTask));
        final subTaskResponse = await supabaseClient
            .from(Entities.DAILY_SUBTASK.dbName)
            .insert(subTask)
            .count(CountOption.exact);

        if (subTaskResponse.count == 0) {
          throw Exception('Error creating daily-sub-task');
        }
      }

      final data = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .select('*, daily_sub_tasks(*)')
          .order('created_at', ascending: false);

      NotificationService().scheduleNotification(
        id: data[0]['id'],
        title: 'Daily Task Reminder',
        body: data[0]['name'],
        time: DateTime.parse(dailyTask.reminderTime),
      );

      return DailyTask.fromJson(data[0]);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Future<DailyTask> addDailyTaskFromJson(Map<String, dynamic> dailyTask) async {
  Future<bool> addDailyTaskFromJson(Map<String, dynamic> dailyTask) async {
    try {
      // print(jsonEncode(dailyTask));

      Map<String, dynamic> convertedData = {
        "name": dailyTask['name'],
        "type": dailyTask['type'] ?? 'Essential',
        "date": dailyTask['date'],
        "description": dailyTask['description'],
        'task_time': '${dailyTask['date']}T${dailyTask['task_time']}',
        'end_time': '${dailyTask['date']}T${dailyTask['end_time']}',
        'reminder_time': '${dailyTask['date']}T${dailyTask['reminder_time']}',
      };

      final response = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .insert(convertedData)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating daily task');
      }
      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> addDailySubTask(Map<String, dynamic> subTask) async {
    try {
      final response = await supabaseClient
          .from(Entities.DAILY_SUBTASK.dbName)
          .insert(subTask)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating daily subtask');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<DailyTask>> fetchAll(DateTime date) async {
    // Future<dynamic> fetchAll(DateTime? date) async {
    try {
      final userId = (await authService.findSession())['id'];
      // print('---------- Fetching daily tasks ------------');
      // print(date?.toIso8601String() ?? 'no date');
      final data = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .select('*, daily_sub_tasks(*)')
          .eq('date', date.toIso8601String())
          .eq('user_id', userId);
      // .eq('user_id', (await authService.findSession())['id']);

      // for (var d in data) {
      //   print(jsonEncode(d));
      // }

      return data.map((dailyTask) {
        print(jsonEncode(dailyTask));
        return DailyTask.fromDBJson(dailyTask);
      }).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<double> fetchCompletionPercentage(String date) async {
    try {
      final data = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .select('*')
          .eq('date', date);
      // .eq('user_id', (await authService.findSession())['id']);

      if (data.isEmpty) {
        return 0;
      }

      int total = 0;
      int completed = 0;
      for (var d in data) {
        completed += d['completion_percentage'] as int;
        total += 100;
      }
      if (total == 0) {
        return 0;
      }

      return ((completed * 1000) ~/ total) / 10;
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
              .eq('user_id', (await authService.findSession())['id'])
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
              .eq('user_id', (await authService.findSession())['id'])
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

  Future<bool> updateDailyTaskCompletionPercentage(
    int id,
    int completionPercentage,
  ) async {
    try {
      print('Updating daily task completion percentage...');
      final data = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .update({'completion_percentage': completionPercentage})
          .eq('id', id)
          .count(CountOption.exact);

      if (data.count == 0) {
        throw Exception('Error updating daily task completion percentage');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> updateSubTask(int id, bool isDone) async {
    try {
      final data = await supabaseClient
          .from(Entities.DAILY_SUBTASK.dbName)
          .update({'is_done': isDone})
          .eq('id', id)
          .count(CountOption.exact);

      if (data.count == 0) {
        throw Exception('Error updating sub-task');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> updateDailyTask(Map<String, dynamic> dailyTaskData, int id) async {
    try {
      final response = await supabaseClient
          .from(Entities.DAILY_TASK.dbName)
          .update({
            'name': dailyTaskData['name'],
            'type': dailyTaskData['type'],
            'description': dailyTaskData['description'],
          })
          .eq('id', id)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Daily task not updated!');
      }

      return true;
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
