import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskRepository {
  Future<Task> createTask(Task task, int subGoalId) async {
    try {
      final response = await supabaseClient
          .from(Entities.SUBGOAL_TASK.dbName)
          .insert({...task.toJson(), "subGoalId": subGoalId})
          .count(CountOption.exact);

      // Todo: check if there was an error while inserting

      if (response.count == 0) {
        throw Exception('Error creating task!');
      }

      final data = await supabaseClient
          .from(Entities.SUBGOAL_TASK.dbName)
          .select('*');

      Task savedTask = Task.fromJson(data[data.length - 1]);

      return savedTask;
    } catch (e) {
      print(e);
      throw Exception("Error creating task!");
    }
  }

  Future<bool> updateTask(Task task, bool status) async {
    try {
      final response = await supabaseClient
          .from(Entities.SUBGOAL_TASK.dbName)
          .update({'status': status})
          .eq('id', task.id!)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Task not found!');
      }

      return true;
    } catch (e) {
      throw Exception('Error updating task!');
    }
  }
}
