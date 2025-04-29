import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/habit-history.entitiy.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class HabitHistoryItem extends StatelessWidget {
  // final String dateString;
  final HabitHistory habitHistory;

  const HabitHistoryItem({super.key, required this.habitHistory});

  // const HabitMissedDateItem({super.key, required this.dateString});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.02,
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      decoration: BoxDecoration(
        // color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xFF27272A).withOpacity(.35),
          width: 2.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // getDayFromDateTime(DateTime.parse(dateString)),
                habitHistory.startedAt,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                habitHistory.streak.toString()
                // '${getMonthFromDateTime(DateTime.parse(dateString))} ${DateTime.parse(dateString).day}',
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF27272A),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              color: Color(0xFFEC003F),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
