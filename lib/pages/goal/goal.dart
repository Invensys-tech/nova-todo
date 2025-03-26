import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/goal/common/addgoal.dart';
import 'package:flutter_application_1/pages/goal/common/goalwidget.dart';

class GoalPage extends StatefulWidget {
  final Datamanager datamanager;

  const GoalPage({super.key, required this.datamanager});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  late Future<List<Goal>> _goalFuture;
  @override
  void initState() {
    super.initState();
    _goalFuture = Datamanager().getGoals();
  }

  void _refreshLoans() {
    setState(() {
      _goalFuture = Datamanager().getGoals();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F2F2F),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
        ),
        onPressed: () async {
          final newGoals = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGoal(),
            ), // Navigate to NewScreen
          );
          if (newGoals != null) {
            setState(() {
              _goalFuture = Future.value(newGoals);
            });
          }
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
              FutureBuilder(
                future: _goalFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var goals = snapshot.data as List<Goal>;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        return (Column(
                          children: [
                            GoalWidget(
                              description: goals[index].description,
                              title: goals[index].name,
                            ),
                          ],
                        ));
                      },
                    );
                  } else {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(
                        "There was an error fetching data ${snapshot.error}",
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
