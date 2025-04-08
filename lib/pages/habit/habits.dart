import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habits-list.dart';
import 'package:flutter_application_1/pages/habit/form.habit.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  DateTime now = DateTime.now();

  late Future<List<Habit>> habits;

  @override
  void initState() {
    super.initState();
    habits = HabitsRepository().fetchHabits();
  }

  void newHabit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                HabitForm(date: getDateOnly(now), refetchData: refetchData),
      ),
    );
  }

  void refetchData() {
    habits = HabitsRepository().fetchHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: newHabit,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Habits"),
        // centerTitle: true,
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.green),
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [Tab(text: "All"), Tab(text: "Daily")],
                labelColor: Colors.green,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                  // color: Colors.green,
                  // borderRadius: BorderRadius.circular(10),
                  border: Border(
                    bottom: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            body: TabBarView(
              children: [
                Container(child: HabitsList(date: null, habits: habits)),
                Container(child: HabitsList(date: 'new date', habits: habits)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
