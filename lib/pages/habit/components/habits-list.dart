import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/habit/components/habit.item.dart';

class HabitsList extends StatefulWidget {
  final String? date;
  final Future<List<dynamic>> habits;
  const HabitsList({super.key, required this.date, required this.habits});

  @override
  State<HabitsList> createState() => _HabitsListState();
}

class _HabitsListState extends State<HabitsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: FutureBuilder(
        future: widget.habits,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                spacing: MediaQuery.of(context).size.width * 0.04,
                children:
                    snapshot.data!
                        .map((habit) => HabitItem(name: habit['name']))
                        .toList(),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return const Text('Error fetching habits!');
            }
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
