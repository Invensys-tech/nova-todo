import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HabitsRepository {
  Future<List<dynamic>> fetchHabits() async {
    try {
      final data = await supabaseClient.from(Entities.HABITS.dbName).select();

      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> createHabit(Map<String, dynamic> habitData) async {
    try {
      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .insert(habitData)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating habit');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
