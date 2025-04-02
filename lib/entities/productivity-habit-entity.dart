import 'package:flutter_application_1/entities/habit-list.dart';

class ProductivityHabit {
  int id;
  String title;
  int productivity_id;
  List<HabitList>? habitList;

  ProductivityHabit({
    required this.id,
    required this.title,
    required this.productivity_id,
    this.habitList,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['productivity_id'] = productivity_id;
    return data;
  }

  factory ProductivityHabit.fromJson(Map<String, dynamic> json) {
    return ProductivityHabit(
      id: json['id'] as int,
      title: json['title'] as String,
      productivity_id: json['productivity_id'] as int,
      habitList:
          (json['productivity_habit_lists'] as List<dynamic>?)
              ?.map((e) => HabitList.fromJson(e))
              .toList(),
    );
  }
}
