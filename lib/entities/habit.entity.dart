import 'package:flutter_application_1/utils/helpers.dart';

class Habit {
  final String name;
  final String type;
  final String repetitionType;
  final List<String> repetitions;
  final String date;
  final bool isDone;
  final int? id;
  int streak;
  int miniStreak;
  int maxStreak;
  final int frequency;
  List<String> streakDates = [];

  Habit({
    required this.name,
    required this.type,
    required this.repetitionType,
    required this.repetitions,
    required this.date,
    required this.isDone,
    required this.streak,
    this.miniStreak = 0,
    required this.maxStreak,
    this.frequency = 0,
    this.streakDates = const [],
    this.id,
  });

  extendStreak(DateTime dateTime) {
    if (streakDates.contains(getDateOnly(dateTime))) {
      return;
    }
    streakDates.add(getDateOnly(dateTime));
    streak++;
    if (streak > maxStreak) {
      maxStreak = streak;
    }
  }

  removeTerm(DateTime dateTime) {
    if (!streakDates.contains(getDateOnly(dateTime))) {
      return;
    }
    streakDates.remove(getDateOnly(dateTime));
    if (streak == 0) {
      return;
    }
    streak--;
    if (streak == maxStreak) {
      maxStreak--;
    }
  }

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    repetitionType: json['repetition_type'],
    frequency: json['frequency'] ?? 0,
    repetitions:
        (json['repetitions'] as List?)?.whereType<String>().toList() ?? [],
    date: json['date'],
    isDone: json['is_done'],
    streak: json['streak'] ?? 0,
    miniStreak: json['mini_streak'] ?? 0,
    maxStreak: json['max_streak'] ?? 0,
    streakDates:
        json['streak_dates'] != null
            ? List<String>.from(json['streak_dates'])
            : [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'repetition_type': repetitionType,
    'repetitions': repetitions,
    'date': date,
    'is_done': isDone,
    'streak': streak,
    'mini_streak': miniStreak,
    'max_streak': maxStreak,
    'streak_dates': streakDates,
    'frequency': frequency,
  };

  String get frequencyPhrase {
    String phrase = 'No frequency';

    if (type == 'Weekly') {
      final daysCount = repetitions.length;
      if (daysCount == 7) return 'Everyday';

      final suffix = ' a week';
      String weeklyFrequency = '';
      switch (daysCount) {
        case 1:
          weeklyFrequency = 'Once';
          break;
        case 2:
          weeklyFrequency = 'Twice';
          break;
        case 3:
          weeklyFrequency = 'Three Times';
          break;
        case 4:
          weeklyFrequency = 'Four Times';
          break;
        case 5:
          weeklyFrequency = 'Five Times';
          break;
        case 6:
          weeklyFrequency = 'Six Times';
          break;
        default:
          weeklyFrequency = 'None';
          break;
      }

      phrase = '$weeklyFrequency$suffix';
    } else if (type == 'Daily' || type == 'Monthly') {
      final weeksCount = repetitions.length;
      if (weeksCount == 4) return 'Every Week';

      final suffix = ' a ${type == 'Daily' ? 'day' : 'month'}';
      phrase = '$frequency$suffix';
    }

    return phrase;
  }

  int get goingOnFor {
    return DateTime.now().difference(DateTime.parse(date)).inDays + 1;
  }

  List<String> get missedDates {
    List<String> missedDates =
        getDatesBetween(DateTime.parse(date), DateTime.now())
            .map((existingDate) => getDateOnly(existingDate))
            .where(
              (existingDate) =>
                  ![
                    ...streakDates,
                    getDateOnly(DateTime.now()),
                  ].contains(existingDate),
            )
            .toList();

    if (!streakDates.contains(date) &&
        getDateOnly(DateTime.parse(date)) != getDateOnly(DateTime.now())) {
      missedDates = [date, ...missedDates];
    }

    return missedDates;
  }

  bool get isDoneToday {
    switch (type) {
      case 'Daily':
        final todayFrequency =
            streakDates
                .where(
                  (streakDate) => streakDate == getDateOnly(DateTime.now()),
                )
                .length;

        return todayFrequency >= frequency ? true : false;
        break;
      case 'Weekly':
        return streakDates.contains(getDateOnly(DateTime.now()));
        break;
      case 'Monthly':
        return streakDates.contains(getDateOnly(DateTime.now()));
        break;

      default:
        return false;
    }
  }

  bool get isNotStartedToday {
    return streakDates.any(
      (streakDate) => streakDate == getDateOnly(DateTime.now()),
    );
  }

  // type
  // name
  // repetition_type
  // user_id
  // id
  // is_done
  // repetitions
  // date
}
