import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitItem extends StatefulWidget {
  final Habit habit;
  const HabitItem({super.key, required this.habit});

  @override
  State<HabitItem> createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  extendStreak() {
    setState(() {
      HabitsRepository().extendHabitStreak(widget.habit).then((value) {
        if (value) {
          widget.habit.extendStreak();
        }
      });
    });
  }

  removeTerm() {
    setState(() {
      HabitsRepository().removeTerm(widget.habit).then((value) {
        if (value) {
          widget.habit.removeTerm();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Todo:
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        // dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context) => extendStreak(),
            backgroundColor: Color(0xFF1D9402),
            foregroundColor: Colors.white,
            icon: Icons.sentiment_satisfied,
            label: 'Done',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => removeTerm(),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.sentiment_dissatisfied,
            label: 'Not Done',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade900, // Background color
          borderRadius: BorderRadius.circular(
            16.0,
          ), // Rounded corners with a radius of 16
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: MediaQuery.of(context).size.width * 0.04,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Icons.book), Text(widget.habit.name)],
            ),
            Row(
              spacing: MediaQuery.of(context).size.width * 0.01,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.local_fire_department, color: Colors.orange),
                Text(widget.habit.streak.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
