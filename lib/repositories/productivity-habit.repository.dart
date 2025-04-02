import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class ProductivityHabitRepository {
  Future<List<ProductivityHabit>> getProductivityHabits() async {
    try {
      final data = await supabaseClient
          .from(Entities.PRODUCTIVITY_HABIT.dbName)
          .select('*');
      return data
          .map(
            (productivityHabit) =>
                ProductivityHabit.fromJson(productivityHabit),
          )
          .toList();
    } catch (e) {
      throw Exception("Error getting productivity habits!");
    }
  }

  // Future<>

  Future<ProductivityHabit> createProductivityHabit(
    Map<String, dynamic> productivityHabit,
  ) async {
    try {
      final response =
          await supabaseClient.from(Entities.PRODUCTIVITY_HABIT.dbName).insert({
            'title': productivityHabit['title'],
            // 'description': productivityHabit['description'],
            // 'time': productivityHabit['time'],
            'productivity_id': productivityHabit['productivity_id'],
          }).select();

      final data = await supabaseClient
          .from(Entities.PRODUCTIVITY_HABIT.dbName)
          .select('*');

      final lastItem = data[data.length - 1];

      return ProductivityHabit.fromJson(lastItem);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
