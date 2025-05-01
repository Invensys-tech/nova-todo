import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';

enum InitPage { AUTH, PAYMENT, HOME }

String generateRandomString(int length) {
  const characters = '0123456789';
  Random random = Random();

  return List.generate(
    length,
    (index) => characters[random.nextInt(characters.length)],
  ).join();
}

enum UuidVersion { V1, V4, V5 }

String generateUniqueId(UuidVersion? uuidVersion) {
  var uuid = Uuid();

  switch (uuidVersion) {
    case UuidVersion.V1:
      return uuid.v1();
    case UuidVersion.V4:
      return uuid.v4();
    case UuidVersion.V5:
      return uuid.v1();
    default:
      return uuid.v1() + uuid.v4();
  }
}

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

DateTime getEndOfDay(DateTime dateTime) =>
    DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);

String getDateOnly(DateTime dateTime) =>
    '${dateTime.year}-${dateTime.month < 10 ? "0${dateTime.month}" : "${dateTime.month}"}-${dateTime.day < 10 ? "0${dateTime.day}" : "${dateTime.day}"}';

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

String getTimeFromDateTime(DateTime dateTime) {
  String hour =
      dateTime.hour < 10
          ? "0${dateTime.hour}"
          : dateTime.hour > 12
          ? "${dateTime.hour - 12}"
          : "${dateTime.hour}";
  String minute =
      dateTime.minute < 10 ? "0${dateTime.minute}" : "${dateTime.minute}";
  String amPm = dateTime.hour > 12 ? "PM" : "AM";
  return "$hour:$minute $amPm";
}

String getTimeFromDateTimeString(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return getTimeFromDateTime(dateTime);
}

String getTimeDifferenceFromTimeString(
  String timeString,
  String compareString,
) {
  DateTime time = DateTime.parse(timeString);
  DateTime compare = DateTime.parse(compareString);
  Duration difference = time.difference(compare);
  if (difference.inSeconds > 0) {
    return 'After ${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
  } else if (difference.inSeconds < 0) {
    return 'Before ${difference.inHours.abs()}h ${difference.inMinutes.remainder(60).abs()}m';
  }
  return '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
}

String getDayFromDateTime(DateTime dateTime) =>
    DateFormat('EEEE').format(dateTime);

String getMonthFromDateTime(DateTime dateTime) =>
    DateFormat('MMM').format(dateTime);

List<DateTime> getDatesBetween(DateTime start, DateTime end) {
  List<DateTime> dates = [];

  for (int i = 0; i <= end.difference(start).inDays; i++) {
    dates.add(start.add(Duration(days: i)));
  }

  return dates;
}

String getHourFromTimeOfDay(TimeOfDay timeofday) {
  final hour = timeofday.hour;

  return hour < 10 ? '0$hour' : hour.toString();
}

String getMinuteFromTimeOfDay(TimeOfDay timeofday) {
  final hour = timeofday.hour;

  return hour < 10 ? '0$hour' : hour.toString();
}

String formatPhoneNumberToShowable(String phoneNumber) {
  if (phoneNumber.length < 10) {
    throw Exception('Wrong phone number format');
  }

  return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7, 9)}-${phoneNumber.substring(9)}';
}

String trimString(String value, {int length = 10}) {
  print(length);
  if (value.length <= length) {
    return value;
  }

  return value.substring(0, length);
}
