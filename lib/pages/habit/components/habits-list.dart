import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habit.item.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HabitsList extends StatefulWidget {
  final String? date;
  final Future<List<Habit>> habits;

  const HabitsList({super.key, required this.date, required this.habits});

  @override
  State<HabitsList> createState() => _HabitsListState();
}

class _HabitsListState extends State<HabitsList> {
  late Future<List<Habit>> habits;

  @override
  void initState() {
    super.initState();
    habits = HabitsRepository().fetchHabits();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: () async {
        habits = HabitsRepository().fetchHabits();
      },
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: FutureBuilder(
          future: habits,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return SingleChildScrollView(
              //   physics: AlwaysScrollableScrollPhysics(),
              //   child: Column(
              //     spacing: MediaQuery.of(context).size.width * 0.04,
              //     children:
              //         snapshot.data!
              //             .map((habit) => HabitItem(habit: habit))
              //             .toList(),
              //   ),
              // );
              return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return HabitItem(
                    habit: snapshot.data![index],
                    hasActions: false,
                  );
                },
              );
            } else {
              if (snapshot.hasError) {
                return const Text('Error fetching habits!');
              }
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
