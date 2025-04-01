import 'dart:convert';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/todopage/add.todo.dart';
import 'package:flutter_application_1/pages/todopage/components/todo.item.dart';
import 'package:flutter_application_1/repositories/daily-task.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Future<List<DailyTask>> todos;
  DateTime now = getStartOfDay(DateTime.now());

  @override
  void initState() {
    super.initState();
    todos = DailyTaskRepository().fetchAll(null);
  }

  void refetchData() {
    setState(() {
      print(now.toIso8601String());
      todos = DailyTaskRepository().fetchAll(now);
    });
  }

  addTodo(DailyTask dailyTask) {
    refetchData();
  }

  setDate(DateTime date) {
    setState(() {
      now = getStartOfDay(date);
      refetchData();
    });
  }

  void newTodo() async {
    // final newGoals = await Navigator.push(
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoPage(refetchData: refetchData),
      ), // Navigate to NewScreen
    );
    // if (newGoals != null) {
    //   setState(() {
    //     _goalFuture = Future.value(newGoals);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // ETDateTime noww = ETDateTime.now();
    DateTime noww = DateTime.now();
    now.subtract(Duration(days: 1));

    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.menu, size: 27, color: Colors.white)),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
        ),
        onPressed: newTodo,
        child: Icon(Icons.add), // The icon inside the button
      ),
      body: FutureBuilder(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .015),
                  CalendarTimeline(
                    // initialDate: ETDateTime.now(),
                    initialDate: DateTime.now(),
                    firstDate: noww,
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
                    activeBackgroundDayColor: Colors.grey,
                    shrink: true,
                    locale: 'en_ISO',
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 15,
                    ),
                    child: new LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * .9,
                      animation: true,
                      lineHeight: MediaQuery.of(context).size.height * .01,
                      animationDuration: 2500,
                      percent: 0.8,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Color(0xff0d805e),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .065,
                    ),
                    child: Text(
                      "80.0% of the work is done ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .05,
                            vertical: MediaQuery.of(context).size.height * .015,
                          ),
                          width: MediaQuery.of(context).size.width * .93,
                          decoration: BoxDecoration(
                            color: Color(0xff0d805e).withOpacity(.35),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black, // Shadow color with opacity
                                spreadRadius: 2, // How much the shadow spreads
                                blurRadius: 10, // Softens the shadow
                                offset: Offset(
                                  -4,
                                  0,
                                ), // Moves shadow right & down
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Add Daily Journal ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .015,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.do_not_disturb_on_total_silence,
                                    color: Colors.white.withOpacity(.8),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        .015,
                                  ),
                                  Text(
                                    "Things you face Today",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .005,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.do_not_disturb_on_total_silence,
                                    color: Colors.white.withOpacity(.8),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        .015,
                                  ),
                                  Text(
                                    "Ypur thinking and assumptions ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .005,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.do_not_disturb_on_total_silence,
                                    color: Colors.white.withOpacity(.8),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        .015,
                                  ),
                                  Text(
                                    "How was the day what needs to improve",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .005,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.do_not_disturb_on_total_silence,
                                    color: Colors.white.withOpacity(.8),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        .015,
                                  ),
                                  Text(
                                    "What did you learn today",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                      ],
                    ),
                  ),

                  ...snapshot.data!.map(
                    (e) => (TodoItem(
                      name: e.name,
                      description: e.description,
                      isDone: false,
                      date: formatTimeSpan(e.dateDate, e.endDateTime),
                    )),
                  ),
                ],
              ),
            );
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
