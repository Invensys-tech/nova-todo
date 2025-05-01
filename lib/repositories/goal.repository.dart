import 'dart:convert';

import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

class GoalRepository {
  AuthService authService = AuthService();
  dynamic session;

  Future<List<Goal>> fetchAll() async {
    print(
      "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]",
    );
    print(userId);
    try {
      final data = await supabaseClient
          .from(Entities.GOAL.dbName)
          .select("*")
          .eq('userId', userId);

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
              .eq('userId', (await authService.findSession())['id'])
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
    print("My Id");
    print(id);
    try {
      final data =
          await supabaseClient
              .from(Entities.GOAL.dbName)
              .select('*, sub_goal(* ,sub_goal_task(*)), goal_journal(*)')
              .eq('id', id)
              // .eq(
              //   'userId',
              //   25,
              //   // (await authService.findSession())['id']
              // )
              .maybeSingle();

      if (data == null) {
        throw Exception("No goal found with id $id for user 25");
      }

      return Goal.fromJson(data);
    } catch (e, stacktrace) {
      print("Error goal angel");
      print(e); // shows the error
      print(stacktrace); // optional, helps with debugging
      throw Exception("Error getting the goal! Original error: $e");
    }
  }

  void createGoal({required Goal goal}) async {
    try {
      final response = await Supabase.instance.client
          .from(Entities.GOAL.dbName)
          .insert({
            ...goal.toJson(),
            'userId': (await authService.findSession())['id'],
          })
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
          .eq('userId', (await authService.findSession())['id'])
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
