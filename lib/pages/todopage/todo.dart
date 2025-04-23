import 'dart:convert';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/todopage/add.todo.dart';
import 'package:flutter_application_1/pages/todopage/components/daily-journal-quill.dart';
import 'package:flutter_application_1/pages/todopage/components/todo.item.dart';
import 'package:flutter_application_1/components/customized/progressbar.dart';
import 'package:flutter_application_1/repositories/daily-journal.repository.dart';
import 'package:flutter_application_1/repositories/daily-task.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../drawer/drawerpage.dart';

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

    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      screen: DailyJournalQuill(date: getDateOnly(now), content: content),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino, settings: const RouteSettings(),
    );
  }

  String todosFilter = 'All';

  changeFilter(String newTodosFilter) {
    setState(() {
      todosFilter = newTodosFilter;
    });
  }

  filterTodos(List<DailyTask> todos, String filterValue) {
    if (filterValue == 'All') return todos;
    return todos.where((todo) {
      if (filterValue == 'Completed') return todo.completionPercentage == 100;
      return todo.completionPercentage < 100;
    }).toList();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // ETDateTime noww = ETDateTime.now();
    DateTime noww = DateTime.now();
    // now.subtract(Duration(days: 1));

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Icon(Icons.menu, size: 27, )),
      title: Text("DailyToDo List"),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff009966),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: newTodo,
        child: Icon(Icons.add),
      ),

      drawer: Drawer(child: Drawerpage(),  backgroundColor: Colors.transparent),
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
                    activeBackgroundDayColor: Theme.of(context).disabledColor,
                    shrink: true,
                    locale: 'en_ISO',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),

                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .035,
                    ),
                    child: FutureBuilder(
                      future: completionPercentage,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 0,
                                ),
                                child: LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width * .94,
                                  animation: true,
                                  lineHeight: MediaQuery.of(context).size.height * .01,
                                  animationDuration: 2500,
                                  percent: .8,

                                  backgroundColor: Theme.of(context).primaryColorDark,
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: Color(0xff0d805e),
                                ),
                              ),
                              Text('   ${snapshot.data!.toString()} Of the work is done'),
                            ],
                          );
                        } else {
                          return LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * .9,
                            animation: true,
                            lineHeight:
                            MediaQuery.of(context).size.height * .025,
                            animationDuration: 2500,
                            backgroundColor: Theme.of(context).primaryColorDark,
                            percent: .5,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Color(0xff0d805e),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .035,
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
                                    MediaQuery.of(context).size.width * .035,
                                    vertical:
                                    MediaQuery.of(context).size.height *
                                        .015,
                                  ),
                                  width:
                                  MediaQuery.of(context).size.width * .93,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).disabledColor,
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                  child: Column(
                                    children: [
                                      snapshot.data?['content'] != null
                                          ? Text('Update Daily Journal',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),)
                                          : Text('Add Daily Journal',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
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
                            return GestureDetector(
                              onTap:
                                  () => openDailyJournalQuill(
                                snapshot.data?['content'],
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.width * .05,
                                  vertical:
                                  MediaQuery.of(context).size.height * .015,
                                ),
                                width: MediaQuery.of(context).size.width * .93,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).disabledColor,
                                  borderRadius: BorderRadius.circular(15),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color:
                                  //         Colors
                                  //             .black, // Shadow color with opacity
                                  //     spreadRadius:
                                  //         2, // How much the shadow spreads
                                  //     blurRadius: 10, // Softens the shadow
                                  //     offset: Offset(
                                  //       -4,
                                  //       0,
                                  //     ), // Moves shadow right & down
                                  //   ),
                                  // ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(child: Text('Add Daily Journal',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),)),
                                    SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          .0125,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.do_not_disturb_on_total_silence,
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Container(
                    child: Column(
                      children:
                          // filterTodos(snapshot.data ?? [], 'Completed')
                          snapshot.data!
                              .map(
                                (e) => (TodoItem(
                                  dailyTask: e,
                                  setParentState: refetchData,
                                )),
                              )
                              .toList(),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .035),

                  // DefaultTabController(
                  //   length: 3,
                  //   child: Scaffold(
                  //     appBar: AppBar(
                  //       bottom: TabBar(
                  //         tabs: [
                  //           Tab(text: "All"),
                  //           Tab(text: "Waiting"),
                  //           Tab(text: "Completed"),
                  //         ],
                  //         labelColor: Colors.green,
                  //         unselectedLabelColor: Colors.white,
                  //         indicator: BoxDecoration(
                  //           // color: Colors.green,
                  //           // borderRadius: BorderRadius.circular(10),
                  //           border: Border(
                  //             bottom: BorderSide(color: Colors.green, width: 2),
                  //           ),
                  //         ),
                  //         indicatorSize: TabBarIndicatorSize.tab,
                  //       ),
                  //     ),
                  //     body: TabBarView(
                  //       children: [
                  // Container(
                  //   child: Column(
                  //     spacing: MediaQuery.of(context).size.height * 0,
                  //     children:
                  //         filterTodos(snapshot.data ?? [], 'All')
                  //             .map(
                  //               (e) => (TodoItem(
                  //                 dailyTask: e,
                  //                 setParentState: refetchData,
                  //               )),
                  //             )
                  //             .toList(),
                  //   ),
                  // ),
                  // Container(
                  //   child: Column(
                  //     spacing: MediaQuery.of(context).size.height * 0,
                  //     children:
                  //         filterTodos(snapshot.data ?? [], 'Waiting')
                  //             .map(
                  //               (e) => (TodoItem(
                  //                 dailyTask: e,
                  //                 setParentState: refetchData,
                  //               )),
                  //             )
                  //             .toList(),
                  //   ),
                  // ),
                  //       ],
                  //     ),
                  //   ),
                  // child: Column(
                  //   spacing: MediaQuery.of(context).size.height * 0,
                  //   children:
                  //       filterTodos(snapshot.data ?? [], 'Completed')
                  //           .map(
                  //             (e) => (TodoItem(
                  //               dailyTask: e,
                  //               setParentState: refetchData,
                  //             )),
                  //           )
                  //           .toList(),
                  // ),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),

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
