class Habit {
  final String name;
  final String type;
  final String repetitionType;
  final List<String> repetitions;
  final String date;
  final bool isDone;

  Habit({
    required this.name,
    required this.type,
    required this.repetitionType,
    required this.repetitions,
    required this.date,
    required this.isDone,
  });

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    name: json['name'],
    type: json['type'],
    repetitionType: json['repetition_type'],
    repetitions: json['repetitions'] ?? [],
    date: json['date'],
    isDone: json['is_done'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'repetition_type': repetitionType,
    'repetitions': repetitions,
    'date': date,
    'is_done': isDone,
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
