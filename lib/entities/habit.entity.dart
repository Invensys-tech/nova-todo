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
  int maxStreak;
  List<String> streakDates = [];

  Habit({
    required this.name,
    required this.type,
    required this.repetitionType,
    required this.repetitions,
    required this.date,
    required this.isDone,
    required this.streak,
    required this.maxStreak,
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
    repetitions:
        (json['repetitions'] as List?)?.whereType<String>().toList() ?? [],
    date: json['date'],
    isDone: json['is_done'],
    streak: json['streak'] ?? 0,
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
    'max_streak': maxStreak,
    'streak_dates': streakDates,
  };

  String get frequencyPhrase {
    String phrase = 'No frequency';

    if (type == 'Daily') {
      final daysCount = repetitions.length;
      if (daysCount == 7) return 'Everyday';

      final suffix = ' a week';
      String frequency = '';
      switch (daysCount) {
        case 1:
          frequency = 'Once';
          break;
        case 2:
          frequency = 'Twice';
          break;
        case 3:
          frequency = 'Three Times';
          break;
        case 4:
          frequency = 'Four Times';
          break;
        case 5:
          frequency = 'Five Times';
          break;
        case 6:
          frequency = 'Six Times';
          break;
        default:
          frequency = 'None';
          break;
      }

      phrase = '$frequency$suffix';
    } else if (type == 'Weekly') {
      final weeksCount = repetitions.length;
      if (weeksCount == 4) return 'Every Week';

      final suffix = ' a month';
      String frequency = '';
      switch (weeksCount) {
        case 1:
          frequency = 'Once';
          break;
        case 2:
          frequency = 'Twice';
          break;
        case 3:
          frequency = 'Three Times';
          break;
        default:
          frequency = 'None';
          break;
      }
      phrase = '$frequency$suffix';
    }

    return phrase;
  }

  int get goingOnFor {
    return DateTime.now().difference(DateTime.parse(date)).inDays + 1;
  }

  List<String> get missedDates {
    final List<String> missedDates =
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

    return missedDates;
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
