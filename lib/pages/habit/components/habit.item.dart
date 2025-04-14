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
      HabitsRepository().extendHabitStreak(widget.habit, DateTime.now()).then((
        value,
      ) {
        if (value) {
          widget.habit.extendStreak(DateTime.now());
        }
      });
    });
  }

  removeTerm() {
    setState(() {
      HabitsRepository().removeTerm(widget.habit, DateTime.now()).then((value) {
        if (value) {
          widget.habit.removeTerm(DateTime.now());
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
          // SlidableAction(
          //   onPressed: (context) => extendStreak(),
          //   backgroundColor: Color(0xFF1D9402),
          //   foregroundColor: Colors.white,
          //   icon: Icons.sentiment_satisfied,
          //   label: 'Done',
          // ),
          Container(
            color: Color(0xFFEC003F),
            child: Center(
              child: ElevatedButton(
                onPressed: () => removeTerm(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF555B59),
                ),
                child: Text(
                  '😔 I didn\'t',
                  style: TextStyle(color: Color(0xFFF4F4F5)),
                ),
              ),
            ),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // SlidableAction(
          //   onPressed: (context) => removeTerm(),
          //   backgroundColor: Color(0xFFFE4A49),
          //   foregroundColor: Colors.white,
          //   icon: Icons.sentiment_dissatisfied,
          //   label: 'Not Done',
          // ),
          Container(
            color: Color(0xFF009966),
            child: Center(
              child: ElevatedButton(
                onPressed: () => extendStreak(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF555B59),
                ),
                child: Text(
                  '🙂 I did it!',
                  style: TextStyle(color: Color(0xFFF4F4F5)),
                ),
              ),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          print('halluuuu');
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .05,
          ),
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  spacing: MediaQuery.of(context).size.width * 0.01,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon(Icons.book),
                    Text(
                      widget.habit.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Motivation here',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.habit.frequencyPhrase,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: MediaQuery.of(context).size.width * 0.01,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon(Icons.local_fire_department, color: Colors.orange),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF27272A),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: Color(0xFF009966),
                        size: 20,
                      ),
                    ),
                    Text(widget.habit.streak.toString()),
                    Icon(Icons.keyboard_arrow_right, color: Color(0xFF009966)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
