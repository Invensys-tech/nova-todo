class HabitHistory {
  final int id;
  final int habitId;
  final List<String> streakDates;
  final String type;
  final int? frequency;
  final String startedAt;
  final List<String>? repetitions;

  HabitHistory({
    required this.id,
    required this.habitId,
    required this.streakDates,
    required this.type,
    required this.startedAt,
    this.repetitions,
    this.frequency,
  });

  factory HabitHistory.fromJson(Map<String, dynamic> jsonValue) => HabitHistory(
    id: jsonValue['id'],
    habitId: jsonValue['habit_id'],
    streakDates: jsonValue['streak_dates'],
    type: jsonValue['type'],
    startedAt: jsonValue['started_at'],
    repetitions: jsonValue['repetitions'],
    frequency: jsonValue['frequency'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habit_id': habitId,
      'streak_dates': streakDates,
      'type': type,
      'started_at': startedAt,
      'repetitions': repetitions,
      'frequency': frequency,
    };
  }

  int get streak {
    return streakDates.length;
  }
}
