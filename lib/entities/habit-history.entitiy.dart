class HabitHistory {
  final int id;
  final int habitId;
  final List<String> dates;
  final String type;
  final int? frequency;
  final String startedAt;
  final List<String>? repetitions;

  HabitHistory({
    required this.id,
    required this.habitId,
    required this.dates,
    required this.type,
    required this.startedAt,
    this.repetitions,
    this.frequency,
  });

  factory HabitHistory.fromJson(Map<String, dynamic> jsonValue) => HabitHistory(
    id: jsonValue['id'],
    habitId: jsonValue['habit_id'],
    dates: jsonValue['dates'] != null
        ? (jsonValue['dates'] as List<dynamic>).map((e) => e.toString()).toList()
        : [],
    type: jsonValue['type'],
    startedAt: jsonValue['started_at'],
    repetitions: jsonValue['repetitions'] != null
        ? (jsonValue['repetitions'] as List<dynamic>).map((e) => e.toString()).toList()
        : [],
    frequency: jsonValue['frequency'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habit_id': habitId,
      'streak_dates': dates,
      'type': type,
      'started_at': startedAt,
      'repetitions': repetitions,
      'frequency': frequency,
    };
  }

  int get streak {
    return dates.length;
  }
}
