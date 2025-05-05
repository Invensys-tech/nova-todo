import 'dart:convert';

import 'package:flutter_application_1/entities/habit-history.entitiy.dart';
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

      String dateString = getDateOnly(dateTime);

      final allHabitsData = await supabaseClient
          .from(Entities.HABITS.dbName)
          .select()
          .eq('user_id', userId);
      // .eq('user_id', 25);

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
              // print(getDateOnly(dateTime));
              // print(habit.repetitions);
              // print(getDayFromDateTime(dateTime));
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
            'user_id': userId,
            // 'user_id': 25,
          })
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating habit');
      }

      final createdHabit = await supabaseClient
          .from(Entities.HABITS.dbName)
          .select('id')
          .order('created_at', ascending: false)
          .limit(1);

      if (createdHabit.isEmpty) {
        throw Exception('Habit not created');
      }

      final habitHistoryResponse = await supabaseClient
          .from(Entities.HABITHISTORY.dbName)
          .insert({
            'habit_id': createdHabit[0]['id'],
            'frequency': habit.frequency,
            'repetitions': habit.repetitions ?? [],
            'started_at': getDateOnly(DateTime.now()),
            'dates': [],
            'type': habit.type,
            'is_active': true,
          })
          .count(CountOption.exact);

      if (habitHistoryResponse.count == 0) {
        await supabaseClient
            .from(Entities.HABITS.dbName)
            .delete()
            .eq('id', createdHabit[0]['id']);
      }

      return true;
    } catch (e) {
      print('error creating habit');
      print(e);
      rethrow;
    }
  }

  Future<bool> extendHabitStreak(Habit existingHabit, DateTime dateTime) async {
    try {
      final habit = existingHabit.copy();

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
        if (habitDates.length >= habit.frequency) {
          print('Already extended streak for this date');
          return false;
        }
        habit.extendStreak(dateTime);
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
          habit.extendStreak(dateTime);
          // if (habit.streakDates.length == habit.repetitions.length) {
          //   habit.miniStreak = 0;
          // } else {
          //   habit.miniStreak += 1;
          // }
        }
      } else if (habit.type == 'Monthly') {
        if (habit.streakDates.contains(getDateOnly(dateTime))) {
          print('Already extended streak for this date');
          return false;
        }
        habit.extendStreak(dateTime);
        // habit.miniStreak += 1;
        // if (habit.miniStreak == habit.frequency) {
        //   habit.miniStreak = 0;
        // }
      }

      // String dateString = getDateOnly(dateTime);

      // if (habit.streakDates.contains(dateString)) {
      //   print('Already extended streak for this date');
      //   return false;
      // }

      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .update({
            'streak': habit.streak,
            'max_streak': habit.maxStreak,
            'streak_dates': habit.streakDates,
          })
          .eq('id', habit.id!)
          .count(CountOption.exact);

      final habitHistory =
          await supabaseClient
              .from(Entities.HABITHISTORY.dbName)
              .select('id, dates')
              .eq('habit_id', habit.id!)
              .order('created_at')
              .maybeSingle();

      if (habitHistory == null) {
        await supabaseClient.from(Entities.HABITHISTORY.dbName).insert({
          'habit_id': habit.id,
          'started_at': getDateOnly(dateTime),
          'dates': [getDateOnly(dateTime)],
          'type': habit.type,
        });
      } else {
        await supabaseClient
            .from(Entities.HABITHISTORY.dbName)
            .update({
              'dates': [...habitHistory['dates'], getDateOnly(dateTime)],
            })
            .eq('id', habitHistory['id']);

        final newHabitHistory =
            await supabaseClient
                .from(Entities.HABITHISTORY.dbName)
                .select('id, dates')
                .eq('habit_id', habit.id!)
                .order('created_at')
                .maybeSingle();
      }

      print(existingHabit.streakDates);

      if (response.count == 0) {
        throw Exception('Error extending habit streak');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> removeTerm(Habit existingHabit, DateTime dateTime) async {
    try {
      final habit = existingHabit.copy();

      if (habit.streak == 0) {
        print('Habit streak is already 0');
        // return false;
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

      final habitHistory =
          await supabaseClient
              .from(Entities.HABITHISTORY.dbName)
              .select('id, dates')
              .eq('habit_id', habit.id!)
              .order('created_at')
              .maybeSingle();

      if (habitHistory != null) {
        bool isFound = false;
        final newStreakDates =
            habitHistory['dates'].where((streakDate) {
              if (isFound) {
                return true;
              }
              isFound = (streakDate == dateString);
              return false;
            }).toList();
        await supabaseClient
            .from(Entities.HABITHISTORY.dbName)
            .update({'dates': newStreakDates})
            .eq('id', habitHistory['id']);

        final newHabitHistory =
            await supabaseClient
                .from(Entities.HABITHISTORY.dbName)
                .select('id, dates')
                .eq('habit_id', habit.id!)
                .order('created_at')
                .maybeSingle();
      }

      if (response.count == 0) {
        throw Exception('Error removing habit day');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> updateById(Habit habit, int id) async {
    try {
      final oldHabit =
          await supabaseClient
              .from(Entities.HABITS.dbName)
              .select('frequency, repetitions, type')
              .eq('id', id)
              .maybeSingle();

      if (oldHabit == null) {
        throw Exception('Habit not found');
      }

      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .update(habit.toJson())
          .eq('id', id)
          .count(CountOption.exact);

      if (habit.type != oldHabit['type'] ||
          habit.frequency != oldHabit['frequency'] ||
          habit.repetitions.any(
            (habitRepetition) => (oldHabit['repetitions'] as List<String>)
                .contains(habitRepetition),
          )) {
        final existingHabitHistoryUpdate = await supabaseClient
            .from(Entities.HABITHISTORY.dbName)
            .update({'is_active': false})
            .eq('habit_id', id);

        final habitHistoryResponse = await supabaseClient
            .from(Entities.HABITHISTORY.dbName)
            .insert({
              'habit_id': id,
              'frequency': habit.frequency,
              'repetitions': habit.repetitions ?? [],
              'started_at': getDateOnly(DateTime.now()),
              'dates': [],
              'type': habit.type,
              'is_active': true,
            })
            .count(CountOption.exact);
      }

      if (response.count == 0) {
        throw Exception('Habit not updated!');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> breakStreak(Habit habit, int id) async {
    try {
      final oldHabit =
          await supabaseClient
              .from(Entities.HABITS.dbName)
              .select('frequency, repetitions, type, streak_dates')
              .eq('id', id)
              .maybeSingle();

      if (oldHabit == null) {
        throw Exception('Habit not found');
      }

      if (oldHabit['streak_dates'].isEmpty) {
        print("empty habit");
        return false;
      }

      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .update({'streak_dates': [], 'streak': 0, 'mini_streak': 0})
          .eq('id', id)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Habit not discontinued!');
      }

      final existingHabitHistoryUpdate = await supabaseClient
          .from(Entities.HABITHISTORY.dbName)
          .update({'is_active': false})
          .eq('habit_id', id);

      final habitHistoryResponse = await supabaseClient
          .from(Entities.HABITHISTORY.dbName)
          .insert({
            'habit_id': id,
            'frequency': habit.frequency,
            'repetitions': habit.repetitions ?? [],
            'started_at': getDateOnly(DateTime.now()),
            'dates': [],
            'type': habit.type,
            'is_active': true,
          })
          .count(CountOption.exact);

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> deleteById(int id) async {
    try {
      final response = await supabaseClient
          .from(Entities.HABITS.dbName)
          .delete()
          .eq('id', id)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Habit not found!');
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Streak and history related queries

  Future<List<HabitHistory>> getStreakHistories(int habitId) async {
    try {
      print(habitId);
      final response = await supabaseClient
          .from(Entities.HABITHISTORY.dbName)
          .select()
          .eq('habit_id', habitId)
          .neq('is_active', true);

      print(response);

      List<HabitHistory> habitHistories =
          response
              .map((habitHistory) => HabitHistory.fromJson(habitHistory))
              .toList();

      return habitHistories;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
