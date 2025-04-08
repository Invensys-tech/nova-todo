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

  Habit({
    required this.name,
    required this.type,
    required this.repetitionType,
    required this.repetitions,
    required this.date,
    required this.isDone,
    required this.streak,
    required this.maxStreak,
    this.id,
  });

  extendStreak() {
    streak++;
    if (streak > maxStreak) {
      maxStreak = streak;
    }
  }

  removeTerm() {
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
  };

  // type
  // name
  // repetition_type
  // user_id
  // id
  // is_done
  // repetitions
  // date
}
