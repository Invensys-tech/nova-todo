import 'package:flutter_application_1/entities/habit-list.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class HabitListRepository {
  Future<List<HabitList>> getProductivityHabits() async {
    try {
      final data = await supabaseClient
          .from(Entities.HABIT_LIST.dbName)
          .select('*');
      return data
          .map((productivityHabit) => HabitList.fromJson(productivityHabit))
          .toList();
    } catch (e) {
      throw Exception("Error getting productivity habits!");
    }
  }

  Future<HabitList> createHabitList(
    Map<String, dynamic> productivityHabit,
  ) async {
    try {
      final response =
          await supabaseClient.from(Entities.HABIT_LIST.dbName).insert({
            'title': productivityHabit['title'],
            'time': productivityHabit['time'],
            'productivity_habit_id': productivityHabit['productivity_habit_id'],
          }).select();

      final data = await supabaseClient
          .from(Entities.HABIT_LIST.dbName)
          .select('*');

      final lastItem = data[data.length - 1];

      return HabitList.fromJson(lastItem);
    } catch (e) {
      print("Error creating productivity habit the smaller!");
      print(e);
      rethrow;
    }
  }
}
