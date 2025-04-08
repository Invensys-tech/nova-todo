import 'dart:convert';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/todopage/add.todo.dart';
import 'package:flutter_application_1/pages/todopage/components/daily-journal-quill.dart';
import 'package:flutter_application_1/pages/todopage/components/todo.item.dart';
import 'package:flutter_application_1/repositories/daily-journal.repository.dart';
import 'package:flutter_application_1/repositories/daily-task.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Future<List<DailyTask>> todos;
  late Future<Map<String, dynamic>> dailyJournal;
  late Future<double> completionPercentage;
  DateTime now = getStartOfDay(DateTime.now());

  @override
  void initState() {
    super.initState();
    todos = DailyTaskRepository().fetchAll(now);
    dailyJournal = DailyJournalRepository().fetchByDate(
      getDateOnly(DateTime.now()),
    );
    completionPercentage = DailyTaskRepository().fetchCompletionPercentage(
      getDateOnly(DateTime.now()),
    );
  }

  void refetchData() {
    setState(() {
      todos = DailyTaskRepository().fetchAll(now);
      dailyJournal = DailyJournalRepository().fetchByDate(
        getDateOnly(DateTime.now()),
      );
      completionPercentage = DailyTaskRepository().fetchCompletionPercentage(
        getDateOnly(DateTime.now()),
      );
      print(now.toIso8601String());
    });
  }

  addTodo(DailyTask dailyTask) {
    refetchData();
  }

  setDate(DateTime date) {
    print("in set date");
    setState(() {
      now = getStartOfDay(date);
    });
    refetchData();
  }

  void newTodo() async {
    // final newGoals = await Navigator.push(
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoPage(refetchData: refetchData),
      ),
    );
  }

  openDailyJournalQuill(dynamic content) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                DailyJournalQuill(date: getDateOnly(now), content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ETDateTime noww = ETDateTime.now();
    DateTime noww = DateTime.now();
    // now.subtract(Duration(days: 1));

    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.menu, size: 27, color: Colors.white)),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: newTodo,
        child: Icon(Icons.add),
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
                    key: ValueKey(now),
                    // initialDate: DateTime.now(),
                    initialDate: now,
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
                    activeBackgroundDayColor: Colors.grey,
                    shrink: true,
                    locale: 'en_ISO',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),

                  FutureBuilder(
                    future: completionPercentage,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 15,
                              ),
                              child: new LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width * .9,
                                animation: true,
                                lineHeight:
                                    MediaQuery.of(context).size.height * .01,
                                animationDuration: 2500,
                                percent: snapshot.data! / 100,
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Color(0xff0d805e),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .065,
                              ),
                              child: Text(
                                "${snapshot.data!}% of the work is done ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error getting completion percentage!'),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05,
                    ),
                    child: FutureBuilder(
                      future: dailyJournal,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // FutureBuilder(
                          //         future: dailyJournal,
                          //         builder: (context, snapshot) {
                          //           if (snapshot.hasData) {
                          //             return Center(
                          //               child: Text(
                          //                 "Update Daily Journal ",
                          //                 style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w800,
                          //                 ),
                          //               ),
                          //             );
                          //           } else {
                          //             if (snapshot.hasError) {
                          //               return Center(
                          //                 child: Text('Add Daily Journal'),
                          //               );
                          //             } else {
                          //               return Center(
                          //                 child: CircularProgressIndicator(),
                          //               );
                          //             }
                          //           }
                          //         },
                          //       ),
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:
                                    () => openDailyJournalQuill(
                                      // jsonDecode(
                                      //   jsonDecode(
                                      //     jsonEncode(snapshot.data?['content']),
                                      //   ),
                                      // ),
                                      snapshot.data?['content'],
                                    ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * .05,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                        .015,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * .93,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0d805e).withOpacity(.35),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors
                                                .black, // Shadow color with opacity
                                        spreadRadius:
                                            2, // How much the shadow spreads
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
                                      snapshot.data?['content'] != null
                                          ? Text('Update Daily Journal')
                                          : Text('Add Daily Journal'),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            .015,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .do_not_disturb_on_total_silence,
                                            color: Colors.white.withOpacity(.8),
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .015,
                                          ),
                                          Text(
                                            "Things you face Today",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white.withOpacity(
                                                .8,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            .005,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .do_not_disturb_on_total_silence,
                                            color: Colors.white.withOpacity(.8),
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .015,
                                          ),
                                          Text(
                                            "Ypur thinking and assumptions ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white.withOpacity(
                                                .8,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            .005,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .do_not_disturb_on_total_silence,
                                            color: Colors.white.withOpacity(.8),
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .015,
                                          ),
                                          Text(
                                            "How was the day what needs to improve",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white.withOpacity(
                                                .8,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            .005,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .do_not_disturb_on_total_silence,
                                            color: Colors.white.withOpacity(.8),
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .015,
                                          ),
                                          Text(
                                            "What did you learn today",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white.withOpacity(
                                                .8,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .02,
                              ),
                            ],
                          );
                        } else {
                          if (snapshot.hasError) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .05,
                                vertical:
                                    MediaQuery.of(context).size.height * .015,
                              ),
                              width: MediaQuery.of(context).size.width * .93,
                              decoration: BoxDecoration(
                                color: Color(0xff0d805e).withOpacity(.35),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors
                                            .black, // Shadow color with opacity
                                    spreadRadius:
                                        2, // How much the shadow spreads
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
                                  Text('Add Daily Journal'),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        .015,
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
                                        MediaQuery.of(context).size.height *
                                        .005,
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
                                        MediaQuery.of(context).size.height *
                                        .005,
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
                                        MediaQuery.of(context).size.height *
                                        .005,
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
                            );
                            // return Center(child: Text('Add Daily Journal'));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .035),
                  Column(
                    spacing: MediaQuery.of(context).size.height * 0,
                    children:
                        snapshot.data!
                            .map(
                              (e) => (TodoItem(
                                dailyTask: e,
                                setParentState: refetchData,
                              )),
                            )
                            .toList(),
                  ),
                  // ...snapshot.data!.map(
                  //   (e) => (TodoItem(
                  //     name: e.name,
                  //     description: e.description,
                  //     isDone: false,
                  //     date: formatTimeSpan(
                  //       e.dateDate,
                  //       e.endDateTime ?? e.dateDate,
                  //     ),
                  //   )),
                  // ),
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
