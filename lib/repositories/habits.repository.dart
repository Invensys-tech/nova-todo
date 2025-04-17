import 'dart:convert';

import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HabitsRepository {
  Future<List<Habit>> fetchHabits() async {
    try {
      // int userId = (await AuthService().findSession())['id'];
      final data = await supabaseClient.from(Entities.HABITS.dbName).select();
      // .eq('user_id', userId);

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

      String dateString = getDateOnly(dateTime);

      final allHabitsData = await supabaseClient
          .from(Entities.HABITS.dbName)
          .select()
          // .eq('user_id', userId);
          .eq('user_id', userId);

      final allHabits = allHabitsData.map<Habit>((habit) {
        return Habit.fromJson(habit);
      });

      final habits =
          allHabits.where((habit) {
            // For habits created on this day
            if (getDateOnly(DateTime.parse(habit.date)) == dateString) {
              return true;
            }

            // For daily habits
            if (habit.type == 'Daily') {
              return true;
            }

            // For weakly habits
            if (habit.type == 'Weekly') {
              return habit.repetitions.contains(getDayFromDateTime(dateTime));
            }

            // for monthly habits that hasn't reached their frequency
            if (habit.type == 'Monthly') {
              if (habit.frequency != 0 &&
                  habit.frequency > habit.streakDates.length) {
                // print(jsonEncode(habit.toJson()));
                return true;
              }

              // print(dateString);

              if (habit.streakDates.contains(dateString)) return true;
            }

            // for monthly habits that has reached their frequency
            // but the user wants to modify them on the date the user performed the habit

            return false;
          }).toList();

      // final today = DateTime.now();
      // final todayDateString = getDateOnly(today);
      // final yesterday = today.subtract(Duration(days: 1));
      // final yesterdayDateString = getDateOnly(yesterday);

      // Todo: add frequency and min streak
      // for (var habit in habits) {
      //   // For daily habits
      //   if (habit.repetitionType == 'Daily') {
      //     if (habit.date == todayDateString) {
      //       continue;
      //     }
      //     if (habit.streakDates.contains(yesterdayDateString)) {
      //       continue;
      //     }

      //     await supabaseClient
      //         .from(Entities.HABITS.dbName)
      //         .update({'streak': 0})
      //         .eq('id', habit.id ?? 0);
      //   }

      //   // For weekly habits
      //   if (habit.repetitionType == 'Weekly') {
      //     // Todo: make sure about the return value of getDayFromDateTime
      //     if (getDayFromDateTime(today) == 'Monday' &&
      //         !habit.streakDates.contains(todayDateString)) {
      //       // resetting the streak dates on every monday
      //       await supabaseClient.from(Entities.HABITS.dbName).update({
      //         'streak_dates': [],
      //       });

      //       continue;
      //     }

      //     // Todo: fix the repetitions list for weekly habits with the return value of getDayFromDateTime for each day
      //     if (!habit.repetitions.contains(getDayFromDateTime(yesterday))) {
      //       continue;
      //     }
      //     if (habit.streakDates.contains(yesterdayDateString)) {
      //       continue;
      //     }

      //     await supabaseClient
      //         .from(Entities.HABITS.dbName)
      //         .update({'streak': 0})
      //         .eq('id', habit.id ?? 0);
      //   }

      //   // For monthly habits
      //   // if (habit.repetitionType == 'Monthly') {
      //   // ! first check for the streak and selected frequency match

      //   // ! reset the frequency and update the streak if the month hits a new day
      //   // if () {

      //   // }
      //   // }
      // }

      // final data = await supabaseClient
      //     .from(Entities.HABITS.dbName)
      //     .select()
      //     .eq('user_id', userId)
      //     .eq('date', getDateOnly(dateTime));

      // List<Habit> habits =
      //     data.map<Habit>((habit) {
      //       return Habit.fromJson(habit);
      //     }).toList();

      // final habits = allHabits;

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
            // 'user_id': userId,
            'user_id': userId,
          })
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating habit');
      }

      return true;
    } catch (e) {
      print('error creating habit');
      // print(e);
      rethrow;
    }
  }

  Future<bool> extendHabitStreak(Habit habit, DateTime dateTime) async {
    try {
      if (habit.id == null) {
        throw Exception('Habit with no id');
      }

      // final habitData =
      //     await supabaseClient
      //         .from(Entities.HABITS.dbName)
      //         .select()
      //         .eq('id', habit.id!)
      //         .maybeSingle();

      // if (habitData == null) {
      //   throw Exception('Habit not found');
      // }

      if (habit.type == 'Daily') {
        // if (habit.streakDates.contains(getDateOnly(dateTime))) {
        //   print('Already extended streak for this date');
        //   return false;
        // }
        // habit.miniStreak += 1;
        final habitDates = habit.streakDates.where(
          (streakDate) => streakDate == getDateOnly(dateTime),
        );
        if (habitDates.length == habit.frequency) {
          print('Already extended streak for this date');
          return false;
        }
        habit.streak += 1;
        habit.streakDates.add(getDateOnly(dateTime));
        if (habit.miniStreak == habit.frequency) {
          habit.miniStreak = 0;
        }
      } else if (habit.type == 'Weekly') {
        if (!habit.repetitions.contains(getDayFromDateTime(dateTime))) {
          print('Cannot extend on ${getDayFromDateTime(dateTime)}');
          return false;
        } else {
          if (habit.streakDates.contains(getDateOnly(dateTime))) {
            print('Already extended streak for this date');
            return false;
          }
          habit.streakDates.add(getDateOnly(dateTime));
          habit.streak += 1;
          // if (habit.streakDates.length == habit.repetitions.length) {
          //   habit.miniStreak = 0;
          // } else {
          //   habit.miniStreak += 1;
          // }
        }
      } else if (habit.type == 'Monthly') {
        print(jsonEncode(habit.toJson()));
        if (habit.streakDates.contains(getDateOnly(dateTime))) {
          print('Already extended streak for this date');
          return false;
        }
        habit.streakDates.add(getDateOnly(dateTime));
        habit.streak += 1;
        // habit.miniStreak += 1;
        // if (habit.miniStreak == habit.frequency) {
        //   habit.miniStreak = 0;
        // }
      }

      print(jsonEncode(habit.toJson()));

      String dateString = getDateOnly(dateTime);

      if (habit.streakDates.contains(dateString)) {
        print('Already extended streak for this date');
        return false;
      }

      // final response = await supabaseClient
      //     .from(Entities.HABITS.dbName)
      //     .update({
      //       'streak': habit.streak + 1,
      //       'max_streak': habit.maxStreak + 1,
      //       'streak_dates': [...habit.streakDates, dateString],
      //     })
      //     .eq('id', habit.id!)
      //     .count(CountOption.exact);

      // if (response.count == 0) {
      //   throw Exception('Error extending habit streak');
      // }

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
