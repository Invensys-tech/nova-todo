// ? DB table name
// daily_tasks
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class DailyTask {
  // ? DB property names
  // task_time, end_time, name, type, date, reminder_time, user_id;
  String name;
  String type;
  String taskTime;
  String endTime;
  String date;
  String description;
  String reminderTime;
  List<DailySubTask> subTasks;
  late DateTime dateDate;
  late DateTime endDateTime;
  late Duration duration;

  DailyTask({
    required this.name,
    required this.type,
    required this.date,
    required this.taskTime,
    required this.endTime,
    required this.reminderTime,
    required this.subTasks,
    required this.description,
  }) {
    duration = DateTime.tryParse(
      taskTime,
    )!.difference(DateTime.tryParse(endTime)!);
    dateDate = DateTime.tryParse(taskTime)!;
    endDateTime = DateTime.tryParse(endTime)!;
  }

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask(
      name: json['name'],
      type: json['type'],
      taskTime: json['task_time'] as String,
      endTime: json['end_time'] as String,
      date: json['date'] as String,
      reminderTime: json['reminder_time'] as String,
      description: json['description'] ?? '',
      subTasks:
          json['daily_sub_tasks'] == Null || json['daily_sub_tasks'] == null
              ? []
              : (json['daily_sub_tasks'] as List<dynamic>)
                  .map((e) => DailySubTask.fromJson(e))
                  .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'task_time': taskTime,
      'end_time': endTime,
      'date': date,
      'reminder_time': reminderTime,
    };
  }

  static Map<String, dynamic> fromUserInputToJson(Map<String, dynamic> json) {
    TimeOfDay timeOfDay = timeOfDayFromString(json['taskTime']);
    TimeOfDay reminderTime = getTimeMinus(
      time: timeOfDay,
      minutes: int.parse(json['notifyMe']),
    );

    return {
      'name': json['name'],
      'type': json['type'],
      'task_time': json['taskTime'],
      'end_time': json['taskEndTime'],
      'date': json['date'],
      'notify_me': json['notifyMe'],
      'description': json['description'],
      'reminder_time': formatTimeOfDayToString(reminderTime),
    };
  }

  bool isInDate(DateTime date) {
    Duration timeDifference = dateDate.difference(date);
    if (timeDifference.isNegative ||
        timeDifference.inSeconds > (60 * 60 * 24)) {
      return false;
    } else {
      return true;
    }
  }
}

// ? DB table name
// daily_sub_tasks
class DailySubTask {
  // ? DB property names
  // text, is_done, daily_task_id

  String text;
  bool isDone;
  int dailyTaskId;

  DailySubTask({
    required this.text,
    required this.isDone,
    required this.dailyTaskId,
  });

  factory DailySubTask.fromJson(Map<String, dynamic> json) {
    return DailySubTask(
      text: json['text'],
      isDone: json['is_done'],
      dailyTaskId: json['daily_task_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'is_done': isDone, 'daily_task_id': dailyTaskId};
  }
}
