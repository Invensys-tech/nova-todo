import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/common/addgoal.dart';
import 'package:flutter_application_1/pages/goal/common/goalwidget.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F2F2F),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGoal(),
            ), // Navigate to NewScreen
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white, // White icon color
          size: 30, // Adjust size if needed
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoalWidget(),
              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
              GoalWidget(),
              GoalWidget(),
              GoalWidget(),
              GoalWidget(),
              GoalWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
