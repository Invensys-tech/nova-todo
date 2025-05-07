import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habit.item.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HabitsDailyList extends StatefulWidget {
  final String? date;
  final Future<List<Habit>> habits;
  final void Function() refetchHabits;
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;

  HabitsDailyList({
    super.key,
    this.date,
    required this.habits,
    required this.refetchHabits,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<HabitsDailyList> createState() => _HabitsDailyListState();
}

class _HabitsDailyListState extends State<HabitsDailyList> {
  final HiveService _hiveService = HiveService();
  String _dateType = 'Gregorian';

  //bekur's
  DateTime date = DateTime.now();

  //Estif's

  late DateTime _selectedDate = DateTime.now();
  late DateTime _queryDate;
  late Future<List<Habit>> habits = Future.value([]);

  @override
  void initState() {
    super.initState();
    _initAll();
  }

  Future<void> _initAll() async {
    await _hiveService.initHive(boxName: 'dateTime');
    final stored = await _hiveService.getData('dateTime');
    print('Stored date type: $stored');
    _dateType = stored == 'Ethiopian' ? 'Ethiopian' : 'Gregorian';
    if (_dateType == 'Ethiopian') {
      final et = date.convertToEthiopian();
      print("{{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}");
      print(et.day);
      _selectedDate = DateTime(et.year, et.month, et.day);

      final g = ETDateTime(et.year, et.month, et.day).convertToGregorian();
      _queryDate = DateTime(g.year, g.month, g.day);
    } else {
      _selectedDate = date;
      _queryDate = DateTime(date.year, date.month, date.day);
    }
    setState(() {
      habits = HabitsRepository().fetchHabitsByDate(date);
    });
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

  void _onDateSelected(DateTime tappedDate) {
    // tappedDate is what the calendar shows
    DateTime filterDate = tappedDate;
    if (_dateType == 'Ethiopian') {
      // convert tapped (Ethiopian) date back to Gregorian
      final g =
          ETDateTime(
            tappedDate.year,
            tappedDate.month,
            tappedDate.day,
          ).convertToGregorian();
      filterDate = DateTime(g.year, g.month, g.day);
    }

    setState(() {
      _selectedDate = tappedDate;
      _queryDate = filterDate;
    });
    refetchHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LiquidPullToRefresh(
        onRefresh: () async {
          // habits = HabitsRepository().fetchHabitsByDate(date);
          widget.refetchHabits();
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
                  initialDate: widget.selectedDate,
                  // firstDate: noww,
                  firstDate: DateTime(2000, 1, 1),
                  lastDate: DateTime(2030, 12, 31),
                  onDateSelected: widget.onDateSelected,
                  // (date) {
                  //   setDate(date);
                  //   // print(ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(noww));
                  // },
                  leftMargin: 20,
                  showYears: false,
                  monthColor: Colors.blueGrey,
                  dayColor: Colors.teal[200],
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: Theme.of(context).disabledColor,
                  shrink: true,
                  locale: 'en_ISO',
                ),

                SizedBox(height: MediaQuery.of(context).size.height * .02),
                FutureBuilder(
                  future: widget.habits,
                  builder: (context, snapshot) {
                    if (habits == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Text('Error fetching habits!');
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No habits found for this date.');
                    }
                    return Column(
                      spacing: MediaQuery.of(context).size.height * .015,
                      children:
                          snapshot.data!
                              .map((habit) => HabitItem(habit: habit))
                              .toList(),
                    );
                  },
                ),

                // FutureBuilder(
                //   future: habits,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       return Column(
                //         spacing: MediaQuery.of(context).size.width * 0.04,
                //         children:
                //             snapshot.data!
                //                 .map((habit) => HabitItem(habit: habit))
                //                 .toList(),
                //       );
                //     } else {
                //       if (snapshot.hasError) {
                //         return const Text('Error fetching habits!');
                //       }
                //       return Center(child: CircularProgressIndicator());
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
