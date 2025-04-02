class Habit {
  final String name;
  final String type;
  final String repetitionType;
  final Map<String, dynamic> repititions;
  final String date;

  Habit({
    required this.name,
    required this.type,
    required this.repetitionType,
    required this.repititions,
    required this.date,
  });

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    name: json['name'],
    type: json['type'],
    repetitionType: json['repitition_type'],
    repititions: json['repititions'],
    date: json['date'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'repitition_type': repetitionType,
    'repititions': repititions,
    'date': date,
  };
  //   type
  // name
  // repitition_type
  // user_id
  // id
  // is_done
  // repititions
  // date
}
