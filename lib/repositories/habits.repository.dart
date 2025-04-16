import 'dart:convert';

import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HabitsRepository {
  Future<List<Habit>> fetchHabits() async {
    try {
      int userId = (await AuthService().findSession())['id'];
      final data = await supabaseClient
          .from(Entities.HABITS.dbName)
          .select()
          .eq('user_id', userId);

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

  Future<List<Habit>> fetchHabitsByDate(DateTime dateTime) async {
    // throw UnimplementedError();
    try {
      int userId = (await AuthService().findSession())['id'];

      final data = await supabaseClient
          .from(Entities.HABITS.dbName)
          .select()
          .eq('user_id', userId)
          .eq('date', getDateOnly(dateTime));

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
      int userId = (await AuthService().findSession())['id'];
      final data = await supabaseClient.from(Entities.HABITS.dbName).select();

      int totalHabits = data.length;

      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .insert({
            ...habit.toJson(),
            'id': totalHabits + 100,
            'user_id': userId,
          })
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

  Future<bool> extendHabitStreak(Habit habit, DateTime dateTime) async {
    try {
      if (habit.id == null) {
        throw Exception('Habit with no id');
      }

      String dateString = getDateOnly(dateTime);

      if (habit.streakDates.contains(dateString)) {
        print('Already extended streak for this date');
        return false;
      }

      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .update({
            'streak': habit.streak + 1,
            'max_streak': habit.maxStreak + 1,
            'streak_dates': [...habit.streakDates, dateString],
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

  Future<bool> removeTerm(Habit habit, DateTime dateTime) async {
    try {
      if (habit.streak == 0) {
        print('Habit streak is already 0');
      }

      String dateString = getDateOnly(dateTime);

      if (!habit.streakDates.contains(dateString)) {
        print('No streak for this date existed');
        return false;
      }

      if (habit.id == null) {
        throw Exception('Habit with no id');
      }
      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .update({
            'streak': habit.streak - 1,
            'max_streak': habit.maxStreak - 1,
            'streak_dates':
                habit.streakDates.where((date) => date != dateString).toList(),
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
