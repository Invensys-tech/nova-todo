// import 'package:flutter_application_1/entities/productivity-habit-entity.dart';

// class Productivity {
//   int id;
//   String title;
//   String description;
//   String time;
//   int streakCount;
//   List<ProductivityHabit>? productivityHabits;

//   Productivity({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.time,
//     this.productivityHabits,
//     this.streakCount = 0,
//   });

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['description'] = description;
//     data['time'] = time;
//     data['streak_count'] = streakCount;
//     return data;
//   }

//   factory Productivity.fromJson(Map<String, dynamic> json) {
//     return Productivity(
//       id: json['id'] as int,
//       title: json['title'] as String,
//       description: json['description'] as String,
//       time: (json['time'] as String),
//       streakCount: (json['streak_count'] as int?) ?? 0,
//       productivityHabits:
//           json['productivity_habits'] != null
//               ? (json['productivity_habits'] as List<dynamic>)
//                   .map((e) => ProductivityHabit.fromJson(e))
//                   .toList()
//               : null,
//     );
//   }
// }

import 'package:flutter_application_1/entities/productivity-habit-entity.dart';

class Productivity {
  int id;
  String title;
  String description;
  String time;
  String? term; // Add term
  int? frequency; // Add frequency
  List<ProductivityHabit>? productivityHabits;
  int? streak_count;

  Productivity({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.term,
    this.frequency,
    this.productivityHabits,
    this.streak_count,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['time'] = time;
    data['frequency'] = frequency;
    data['streak_count'] = streak_count;
    return data;
  }

  // ... (rest of your class)

  factory Productivity.fromJson(Map<String, dynamic> json) {
    return Productivity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      time: (json['time'] as String),
      frequency: json['frequency'] as int?, // Add frequency from JSON
      streak_count: json['streak_count'] as int?,
      productivityHabits:
          json['productivity_habits'] != null
              ? (json['productivity_habits'] as List<dynamic>)
                  .map((e) => ProductivityHabit.fromJson(e))
                  .toList()
              : null,
    );
  }
}
