import 'dart:convert';

import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HabitsRepository {
  Future<List<Habit>> fetchHabits() async {
    try {
      final data = await supabaseClient.from(Entities.HABITS.dbName).select();

      List<Habit> habits =
          data.map<Habit>((habit) {
            return Habit.fromJson(habit);
          }).toList();

      return habits;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> createHabit(Habit habit) async {
    try {
      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .insert(habit.toJson())
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

  Future<bool> extendHabitStreak(Habit habit) async {
    try {
      if (habit.id == null) {
        throw Exception('Habit with no id');
      }
      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .update({
            'streak': habit.streak + 1,
            'max_streak': habit.maxStreak + 1,
          })
          .eq('id', habit.id!)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error extending habit streak');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> removeTerm(Habit habit) async {
    try {
      if (habit.streak == 0) {
        throw Exception('Habit streak is already 0');
      }
      if (habit.id == null) {
        throw Exception('Habit with no id');
      }
      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .update({
            'streak': habit.streak - 1,
            'max_streak': habit.maxStreak - 1,
          })
          .eq('id', habit.id!)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error removing habit day');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
