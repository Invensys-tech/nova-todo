import 'package:flutter/material.dart';

String formatDate(String date) {
  // print("---------------------- DATE -----------------------");
  // print(date);
  List<String> parts = date.split('-'); // Split DD-MM-YYYY
  return '${parts[2]}-${parts[1]}-${parts[0]}'; // Convert to YYYY-MM-DD
}

String formatTimeView(DateTime dateTime) {
  String hour = dateTime.hour < 10 ? "0${dateTime.hour}" : "${dateTime.hour}";
  String minute =
      dateTime.minute < 10 ? "0${dateTime.minute}" : "${dateTime.minute}";

  return "$hour:$minute";
}

String formatTimeSpan(DateTime startDateTime, DateTime endDateTime) {
  return "${formatTimeView(startDateTime)} - ${formatTimeView(endDateTime)}";
}

String formatTimeOfDayToString(TimeOfDay time) {
  // yyyy-MM-ddTHH:mm:ss.mmmuuuZ
  String hour = time.hour < 10 ? "0${time.hour}" : "${time.hour}";
  String minute = time.minute < 10 ? "0${time.minute}" : "${time.minute}";
  String convertedString = '$hour:$minute:00';

  return convertedString;
}

String formatDoubleDigitTime(int hours, int minutes) {
  String hour =
      hours < 10
          ? "0$hours"
          : hours > 12
          ? "${hours - 12}"
          : "$hours";
  String minute = minutes < 10 ? "0$minutes" : "$minutes";
  return "$hour:$minute ${hours > 12 ? "PM" : "AM"}";
}

DateTime getStartOfDay(DateTime dateTime) =>
    DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);

TimeOfDay timeOfDayFromString(String timeOfDayString) {
  List<String> units = timeOfDayString.split(':');
  int hour = int.parse(units[0]);
  int minute = int.parse(units[1]);

  return TimeOfDay(hour: hour, minute: minute);
}

TimeOfDay getTotalTime({required TimeOfDay time, int? hours, int? minutes}) {
  int addableHour = hours ?? 0;
  int addableMinute = minutes ?? 0;
  if ((addableHour + time.hour) < 24) {
    addableHour += time.hour;
  }
  if ((addableMinute + time.minute) < 60) {
    addableMinute += time.minute;
  }
  TimeOfDay newTime = TimeOfDay(hour: addableHour, minute: addableMinute);

  return newTime;
}

TimeOfDay getTimeMinus({required TimeOfDay time, int? hours, int? minutes}) {
  int newHour = hours ?? 0;
  int newMinute = minutes ?? 0;
  if ((time.hour - newHour) > 0) {
    newHour = time.hour - newHour;
  } else {
    newHour = 0;
  }
  if ((time.minute - newMinute) > 0) {
    newMinute = time.minute - newMinute;
  } else {
    if ((newHour - 1) >= 0) {
      newHour -= 1;
      newMinute = 60 - (newMinute - time.minute);
    } else {
      newMinute = 0;
    }
  }

  return TimeOfDay(hour: newHour, minute: newMinute);
}
