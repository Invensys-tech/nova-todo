import 'package:flutter_application_1/entities/productivity-habit-entity.dart';

class Productivity {
  int id;
  String title;
  String description;
  DateTime time;
  List<ProductivityHabit>? productivityHabits;

  Productivity({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.productivityHabits,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['time'] = time.toIso8601String();

    return data;
  }

  factory Productivity.fromJson(Map<String, dynamic> json) {
    return Productivity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      time: DateTime.parse(json['time'] as String),
      productivityHabits:
          json['productivity_habits'] != null
              ? (json['productivity_habits'] as List<dynamic>)
                  .map((e) => ProductivityHabit.fromJson(e))
                  .toList()
              : null,
    );
  }
}
