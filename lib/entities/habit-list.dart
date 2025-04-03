class HabitList {
  int id;
  String title;
  String time;
  int productivity_habit_id;

  HabitList({
    required this.id,
    required this.title,
    required this.time,
    required this.productivity_habit_id,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    data['productivity_habit_id'] = productivity_habit_id;
    return data;
  }

  factory HabitList.fromJson(Map<String, dynamic> json) {
    return HabitList(
      id: json['id'] as int,
      title: json['title'] as String,
      time: json['time'] as String,
      productivity_habit_id: json['productivity_habit_id'] as int,
    );
  }
}
