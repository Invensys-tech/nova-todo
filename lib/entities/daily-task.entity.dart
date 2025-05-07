import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/helpers.dart';

// ? DB table name
// daily_tasks
class DailyTask {
  // ? DB property names
  // task_time, end_time, name, type, date, reminder_time, user_id;
  final int? id;
  String name;
  String type;
  String taskTime;
  String endTime;
  String date;
  String description;
  String? reminderTime;
  String? notifyMeText;

  // List<DailySubTask> subTasks;
  List<dynamic> subTasks;
  late DateTime dateDate;
  late DateTime? endDateTime;
  late Duration? duration;
  late int? completionPercentage;

  DailyTask({
    this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.taskTime,
    required this.endTime,
    this.reminderTime,
    required this.subTasks,
    required this.description,
    this.completionPercentage,
    this.notifyMeText,
  }) {
    try {
      duration = DateTime.tryParse(
        taskTime,
      )?.difference(DateTime.tryParse(endTime) ?? DateTime.now());
      dateDate = DateTime.tryParse(taskTime) ?? DateTime.now();
      endDateTime = DateTime.tryParse(endTime);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    // print(json['reminder_time']);
    return DailyTask(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      taskTime: json['task_time'] as String,
      endTime: json['end_time'] as String,
      date: json['date'] as String,
      reminderTime:
          json['reminder_time'] == null
              ? null
              : json['reminder_time'] as String,
      description: json['description'] ?? '',
      subTasks:
          json['daily_sub_tasks'] == Null || json['daily_sub_tasks'] == null
              ? []
              : json['daily_sub_tasks'],
      completionPercentage: json['completion_percentage'],
      notifyMeText: json['notify_me'],
      // : (json['daily_sub_tasks'])
      //     .map((e) => DailySubTask.fromJson(e))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'task_time': taskTime,
      'end_time': endTime,
      'description': description,
      'date': date,
      'reminder_time': reminderTime,
    };
  }


  factory DailyTask.fromUserInputJson(Map<String, dynamic> json) {
    TimeOfDay timeOfDay = timeOfDayFromString(json['taskTime']);
    TimeOfDay? reminderTime;

    if (['2', '5', '10', '15'].contains(json['notifyMe'])) {
      reminderTime = getTimeMinus(
        time: timeOfDay,
        minutes: int.parse(json['notifyMe']),
      );
    }

    return DailyTask.fromJson({
      // ...json,
      'name': json['name'],
      'type': json['type'],
      'task_time': "${json['date']}T${json['taskTime']}",
      'end_time': "${json['date']}T${json['taskEndTime']}",
      'date': json['date'],
      'description': json['description'],
      'daily_sub_tasks': json['daily_sub_tasks'],
      'reminder_time':
          reminderTime == null
              ? "${json['date']}T${json['taskTime']}"
              : "${json['date']}T${formatTimeOfDayToString(reminderTime)}",
    });
    // return {
    //   'name': json['name'],
    //   'type': json['type'],
    //   'task_time': json['taskTime'],
    //   'end_time': json['taskEndTime'],
    //   'date': json['date'],
    //   'notify_me': json['notifyMe'],
    //   'description': json['description'],
    //   'reminder_time': formatTimeOfDayToString(reminderTime),
    //   'sub_tasks': json['sub_tasks'] ?? [],
    // };
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

  factory DailyTask.fromDBJson(Map<String, dynamic> json) {
    return DailyTask.fromJson({
      ...json,
      'date': json['date'].toString().split('T')[0],
      'reminder_time':
          (json['reminder_time'] == null ||
                  json['task_time'] == json['reminder_time'])
              ? null
              : getTimeDifferenceFromTimeString(
                json['reminder_time'],
                json['task_time'],
              ),
      'task_time': getTimeFromDateTimeString(json['task_time']),
      'end_time': getTimeFromDateTimeString(json['end_time']),
    });
  }
}

// ? DB table name
// daily_sub_tasks
class DailySubTask {
  // ? DB property names
  // text, is_done, daily_task_id

  String text;
  bool isDone;
  int? dailyTaskId;

  DailySubTask({required this.text, required this.isDone, this.dailyTaskId});

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
