// ? DB table name
// daily_tasks
class DailyTask {
  // ? DB property names
  // task_time, end_time, name, type, date, reminder_time, user_id;
  String name;
  String? type;
  DateTime? taskTime;
  DateTime? endTime;
  DateTime date;
  DateTime? reminderTime;

  DailyTask({
    required this.name,
    this.type,
    required this.date,
    this.taskTime,
    this.endTime,
    this.reminderTime,
  });

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask(
      name: json['name'],
      type: json['type'],
      taskTime: json['task_time'],
      endTime: json['end_time'],
      date: json['date'],
      reminderTime: json['reminder_time'],
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
