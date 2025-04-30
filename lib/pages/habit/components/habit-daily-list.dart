import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habit.item.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HabitsDailyList extends StatefulWidget {
  final String? date;
  final Future<List<Habit>>? habits;
  const HabitsDailyList({super.key, this.date, this.habits});

  @override
  State<HabitsDailyList> createState() => _HabitsDailyListState();
}

class _HabitsDailyListState extends State<HabitsDailyList> {
  DateTime date = DateTime.now();
  late Future<List<Habit>> habits;

  @override
  void initState() {
    super.initState();
    habits = HabitsRepository().fetchHabitsByDate(date);
  }

  setDate(DateTime newDate) {
    setState(() {
      date = newDate;
      refetchHabits();
    });
  }

  refetchHabits() {
    habits = HabitsRepository().fetchHabitsByDate(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LiquidPullToRefresh(
        onRefresh: () async {
          habits = HabitsRepository().fetchHabitsByDate(date);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            child: Column(
              children: [
                CalendarTimeline(
                  // initialDate: ETDateTime.now(),
                  key: ValueKey(date),
                  // initialDate: DateTime.now(),
                  initialDate: date,
                  // firstDate: noww,
                  firstDate: DateTime(2020, 11, 20),
                  lastDate: DateTime(2027, 11, 20),
                  onDateSelected: (date) {
                    setDate(date);
                    // print(ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(noww));
                  },
                  leftMargin: 20,
                  showYears: false,
                  monthColor: Colors.blueGrey,
                  dayColor: Colors.teal[200],
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: Theme.of(context).disabledColor,
                  shrink: true,
                  locale: 'en_ISO',
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                FutureBuilder(
                  future: habits,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        spacing: MediaQuery.of(context).size.width * 0.04,
                        children:
                            snapshot.data!
                                .map((habit) => HabitItem(habit: habit))
                                .toList(),
                      );
                    } else {
                      if (snapshot.hasError) {
                        return const Text('Error fetching habits!');
                      }
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
