import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

class GoalRepository {
  Future<List<Goal>> fetchAll() async {
    try {
      final data = await supabaseClient.from(Entities.GOAL.dbName).select();
      return data.map((goal) => Goal.fromJson(goal)).toList();
    } catch (e) {
      throw Exception("Error getting goals!");
    }
  }

  Future<Goal> fetchById(String id) async {
    try {
      final data =
          await supabaseClient
              .from(Entities.GOAL.dbName)
              .select()
              .eq('id', id)
              .maybeSingle();

      if (data == null) {
        throw Error();
      }

      return Goal.fromJson(data);
    } catch (e) {
      throw Exception("Error getting the goal!");
    }
  }

  Future<Goal> fetchView(int id) async {
    try {
      final data =
          await supabaseClient
              .from(Entities.GOAL.dbName)
              .select('*, sub_goals(*)')
              .eq('id', id)
              .maybeSingle();

      if (data == null) {
        throw Error();
      }

      return Goal.fromJson(data);
    } catch (e) {
      throw Exception("Error getting the goal!");
    }
  }

  void createGoal({required Goal goal}) async {
    try {
      final response = await Supabase.instance.client
          .from(Entities.GOAL.dbName)
          .insert(goal.toJson())
          .count(CountOption.exact);

      // Todo: check if there was an error while inserting

      if (response.count == 0) {
        throw Exception('Error creating goal!');
      }
    } catch (e) {
      throw Exception("Error creating goal!");
    }
  }

  Future<bool> deleteById(String id) async {
    try {
      final response = await supabaseClient
          .from(Entities.GOAL.dbName)
          .delete()
          .eq('id', id)
          .count(CountOption.exact);

      // Todo: check if there was an error while deleting

      if (response.count == 0) {
        throw Exception('Goal not found!');
      }

      return true;
    } catch (e) {
      throw Exception("Error removing goal!");
    }
  }
}
