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
