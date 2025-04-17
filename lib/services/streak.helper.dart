// import 'package:flutter_application_1/utils/supabase.clients.dart';

// DateTime calculateExpectedDate(DateTime lastDate, String frequency) {
//   switch (frequency.toLowerCase()) {
//     case 'daily':
//       return lastDate.add(Duration(days: 1));
//     case 'weekly':
//       return lastDate.add(Duration(days: 7));
//     case 'monthly':
//       // Simple monthly increment (be careful with months having different days)
//       return DateTime(lastDate.year, lastDate.month + 1, lastDate.day);
//     default:
//       throw Exception("Frequency not supported");
//   }
// }

// DateTime stripTime(DateTime date) {
//   // Strips the time part, keeping only the date (year, month, day)
//   return DateTime(date.year, date.month, date.day);
// }

// Future<void> updateOrCreateStreak({
//   required int productivityHabitId,
//   required DateTime habitDate,
//   required String frequency,
//   required int habitEntryId,
// }) async {
//   print(
//     "Updating streak for Habit $productivityHabitId at $habitDate with frequency $frequency",
//   );
//   // Retrieve the current streak record.
//   final currentStreakResponse =
//       await supabaseClient
//           .from('streaks')
//           .select('*')
//           .eq('productivity_habit_id', productivityHabitId)
//           .order('end_date', ascending: false)
//           .limit(1)
//           .maybeSingle();

//   print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;');
//   print(currentStreakResponse?['id']);

//   if (currentStreakResponse != null) {
//     DateTime currentEndDate = DateTime.parse(currentStreakResponse['end_date']);
//     DateTime expectedDate = calculateExpectedDate(currentEndDate, frequency);

//     // Strip the time part of both current end date and expected date
//     DateTime strippedCurrentEndDate = stripTime(currentEndDate);
//     DateTime strippedExpectedDate = stripTime(expectedDate);
//     DateTime strippedHabitDate = stripTime(habitDate);

//     print(
//       "Current streak end date: $strippedCurrentEndDate, Expected next date: $strippedExpectedDate",
//     );

//     print(
//       "${strippedHabitDate} ${strippedExpectedDate} ${strippedHabitDate.isAfter(strippedExpectedDate)}",
//     );

//     // Modified condition: Check if habitDate is NOT after the expectedDate
//     if (!strippedHabitDate.isAfter(strippedExpectedDate)) {
//       // Continue the streak:
//       List<dynamic> habitIds =
//           currentStreakResponse['habit_ids'] as List<dynamic>;
//       habitIds.add(habitEntryId);
//       print("Continuing streak. New habitIds list: $habitIds");

//       final updatedStreak = {
//         'end_date': habitDate.toIso8601String(),
//         'habit_ids': habitIds,
//       };

//       final updateResponse = await supabaseClient
//           .from('streaks')
//           .update(updatedStreak)
//           .eq('id', currentStreakResponse['id']);
//       print("Streak continued and updated: $updateResponse");
//       return;
//     } else {
//       print(
//         "Habit date $habitDate is after the expected date $expectedDate. Streak not continued.",
//       );
//     }
//   } else {
//     print("No current streak exists for habit $productivityHabitId.");
//   }

//   // Create a new streak if no current streak or if the condition fails.
//   final newStreak = {
//     'productivity_habit_id': productivityHabitId,
//     'start_date': habitDate.toIso8601String(),
//     'end_date': habitDate.toIso8601String(),
//     'habit_ids': [habitEntryId],
//   };

//   final insertResponse = await supabaseClient.from('streaks').insert(newStreak);
//   print("New streak started: $insertResponse");
// }

// void simulateContinuingDailyStreak(int productivityHabitId) async {
//   // Yesterday's habit (within the streak)
//   DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
//   print("Yesterday's Habit Date: $yesterday");
//   await updateOrCreateStreak(
//     productivityHabitId: productivityHabitId,
//     habitDate: yesterday,
//     frequency: "daily",
//     habitEntryId: 100, // Just use dummy IDs if needed
//   );

//   // Today's habit (should continue the streak)
//   DateTime today = DateTime.now();
//   print("Today's Habit Date: $today");
//   await updateOrCreateStreak(
//     productivityHabitId: productivityHabitId,
//     habitDate: today,
//     frequency: "daily",
//     habitEntryId: 101,
//   );
// }

// void simulateBrokenDailyStreak(int productivityHabitId) async {
//   // 3 days ago (breaking the streak)
//   DateTime threeDaysAgo = DateTime.now().subtract(Duration(days: 3));
//   print("Three days ago Habit Date: $threeDaysAgo");
//   await updateOrCreateStreak(
//     productivityHabitId: productivityHabitId,
//     habitDate: threeDaysAgo,
//     frequency: "daily",
//     habitEntryId: 102,
//   );

//   // Today — missing two days in between!
//   DateTime today = DateTime.now();
//   print("Today's Habit Date: $today (missing two days in between)");
//   await updateOrCreateStreak(
//     productivityHabitId: productivityHabitId,
//     habitDate: today,
//     frequency: "daily",
//     habitEntryId: 103,
//   );
// }

// services/streak.helper.dart

// lib/services/streak.helper.dart

import 'package:flutter_application_1/utils/supabase.clients.dart';

/// Only keep the Y/M/D portion for comparisons.
DateTime stripTime(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

/// Given a lastDate and a frequency string, compute the next expected date.
DateTime calculateExpectedDate(DateTime lastDate, String frequency) {
  switch (frequency.toLowerCase()) {
    case 'daily':
      return lastDate.add(Duration(days: 1));
    case 'weekly':
      return lastDate.add(Duration(days: 7));
    case 'monthly':
      return DateTime(lastDate.year, lastDate.month + 1, lastDate.day);
    default:
      throw Exception("Frequency not supported: $frequency");
  }
}

/// Main upsert logic for streak rows *and* productivity.streak_count.
Future<void> updateOrCreateStreak({
  required int productivityHabitId,
  required DateTime habitDate,
  required String frequency,
  required int habitEntryId,
}) async {
  print('--- updateOrCreateStreak for habit $productivityHabitId');

  // 1️⃣ Find the parent productivity record
  final habitRow =
      await supabaseClient
          .from('productivity_habit')
          .select('productivity_id')
          .eq('id', productivityHabitId)
          .maybeSingle();
  if (habitRow == null) {
    print('❌ No productivity_habit row for $productivityHabitId');
    return;
  }
  final int prodId = habitRow['productivity_id'];

  // 2️⃣ Read and log current streak_count
  final prodRow =
      await supabaseClient
          .from('productivity')
          .select('streak_count')
          .eq('id', prodId)
          .maybeSingle();
  int currentCount = prodRow?['streak_count'] as int? ?? 0;
  print('Current productivity($prodId).streak_count = $currentCount');

  // 3️⃣ Pull the latest streak row, if any
  final currentStreak =
      await supabaseClient
          .from('streaks')
          .select('*')
          .eq('productivity_habit_id', productivityHabitId)
          .order('end_date', ascending: false)
          .limit(1)
          .maybeSingle();

  bool continued = false;

  if (currentStreak != null) {
    // parse and strip time
    DateTime lastEnd = stripTime(DateTime.parse(currentStreak['end_date']));
    DateTime expected = stripTime(calculateExpectedDate(lastEnd, frequency));
    DateTime todayStripped = stripTime(habitDate);

    print('Last end: $lastEnd  Expected: $expected  Today: $todayStripped');

    // ✅ If today is on or after expectedDate → continue
    if (!todayStripped.isBefore(expected)) {
      // append to habit_ids
      List<int> ids = List<int>.from(currentStreak['habit_ids']);
      ids.add(habitEntryId);

      await supabaseClient
          .from('streaks')
          .update({'end_date': habitDate.toIso8601String(), 'habit_ids': ids})
          .eq('id', currentStreak['id']);
      print('✅ Continued streak with entry $habitEntryId');

      // bump productivity.streak_count
      await supabaseClient
          .from('productivity')
          .update({'streak_count': currentCount + 1})
          .eq('id', prodId);
      print('→ streak_count → ${currentCount + 1}');

      continued = true;
    } else {
      print('⛔ Missed expected date; will start new streak');
    }
  } else {
    print('ℹ️ No existing streak row; will start new streak');
  }

  // 4️⃣ If we didn’t continue, start a fresh streak row & reset count
  if (!continued) {
    await supabaseClient.from('streaks').insert({
      'productivity_habit_id': productivityHabitId,
      'start_date': habitDate.toIso8601String(),
      'end_date': habitDate.toIso8601String(),
      'habit_ids': [habitEntryId],
    });
    print('🆕 New streak row');

    await supabaseClient
        .from('productivity')
        .update({'streak_count': 1})
        .eq('id', prodId);
    print('→ streak_count reset to 1');
  }
}

/// ——————————————————————————————
/// ⚙️ Test helpers: manually drive your daily-streak scenarios
/// ——————————————————————————————

/// Simulate a two-day in-a-row entry (should continue)
Future<void> simulateContinuingDailyStreak(int habitId) async {
  DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
  print('--- Simulating yesterday ($yesterday)');
  await updateOrCreateStreak(
    productivityHabitId: habitId,
    habitDate: yesterday,
    frequency: 'daily',
    habitEntryId: 100,
  );

  DateTime today = DateTime.now();
  print('--- Simulating today ($today)');
  await updateOrCreateStreak(
    productivityHabitId: habitId,
    habitDate: today,
    frequency: 'daily',
    habitEntryId: 101,
  );
}

/// Simulate a gap of 2+ days (should break)
Future<void> simulateBrokenDailyStreak(int habitId) async {
  DateTime threeDaysAgo = DateTime.now().subtract(Duration(days: 3));
  print('--- Simulating 3 days ago ($threeDaysAgo)');
  await updateOrCreateStreak(
    productivityHabitId: habitId,
    habitDate: threeDaysAgo,
    frequency: 'daily',
    habitEntryId: 200,
  );

  DateTime today = DateTime.now();
  print('--- Simulating today ($today)');
  await updateOrCreateStreak(
    productivityHabitId: habitId,
    habitDate: today,
    frequency: 'daily',
    habitEntryId: 201,
  );
}
