import 'dart:math';

import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/customized/billboard.dart';
import 'package:flutter_application_1/pages/homepage/daily-report.dart';
import 'package:flutter_application_1/pages/homepage/dashboard-components/dashboard.expense.item.dart';
import 'package:flutter_application_1/pages/pricing/pricing.dart';
import 'package:flutter_application_1/services/analytics.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:time_interval_picker/time_interval_picker.dart';

import '../../drawer/drawerpage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final bankAnalytics = AnalyticsService.getBankAnalytics();
  final expenseAnalytics = AnalyticsService.getExpense();
  final incomeAnalytics = AnalyticsService.getIncome();
  final goalAnalytics = AnalyticsService.getGoalAnalytics();

  List<dynamic> expenses = [
    {
      'title': 'Electric Bill',
      'date': 'Yesterday',
      'amount': '2300',
      'icon': Icons.thunderstorm,
    },
    {
      'title': 'Groceries',
      'date': '2025-04-13',
      'amount': '2000',
      'icon': Icons.shopping_cart,
    },
    {
      'title': 'Rent',
      'date': '2025-04-07',
      'amount': '23000',
      'icon': Icons.house_outlined,
    },
  ];

  List<dynamic> habits = [
    {
      'title': 'Books and Music',
      'frequency': 'Everyday',
      'streak': '4',
      'icon': Icons.book,
    },
    {
      'title': 'Sports and Gym',
      'frequency': 'Once A Week',
      'streak': '4',
      'icon': Icons.line_weight,
    },
  ];

  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


 bool showJoin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      drawer: Drawer(child: Drawerpage(), backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(

          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .035),

            showJoin?  Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035,vertical: MediaQuery.of(context).size.height*.01),
              height: MediaQuery.of(context).size.height*.075,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                colors: [
                Color(0xff009966),
                Color(0xff00D492),
                Color(0xff009966),
                ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              ),
              ),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.rocket,size: 36,),
                  SizedBox(width: MediaQuery.of(context).size.width*.05,),
                  Container(
                    width: MediaQuery.of(context).size.width*.375,
                      child: Row(
                        children: [
                          Text(  "2 ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                          Text(  translate("Days Left From trial"),style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                        ],
                      )),
                  SizedBox(width: MediaQuery.of(context).size.width*.05,),
                  GestureDetector(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        screen: PricingScreen(),
                        withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        settings: const RouteSettings(),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*.25,
                      height: MediaQuery.of(context).size.height*.055,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white
                      ),
                      child: Center(
                        child: Text(translate("Join Now!"), style: TextStyle(color: Colors.green),),
                      ),
                    ),
                  ),


                  SizedBox(width: MediaQuery.of(context).size.width*.05,),

                  GestureDetector(
                      onTap: (){
                        setState(() {
                          showJoin = false;
                        });
                      },
                      child: Text("X",style: TextStyle(fontSize: 25),))
                ],
              ),
            ) : Container(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [

                  Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Icon(
                            Icons.menu_outlined,
                            size: 28,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * .015),
                        GestureDetector(
                          onTap: (){
                            PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                              context,
                              screen: DailyReport(),
                              withNavBar: false,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              settings: const RouteSettings(),
                            );
                          },
                          child: Text(
                            "Jan 23, 2025",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(width: MediaQuery.of(context).size.width * .3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                             translate( "Good Morning"),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "Abebe",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     print('scheduled notification');
                  //
                  //     // NotificationService()
                  //     //     .sendQuoteNotification();
                  //
                  //     NotificationService()
                  //         .scheduleNotification(
                  //         id: -23,
                  //         title: 'Quote',
                  //         body: 'Lorem ipsum dolor amet...',
                  //         time: DateTime.now().add(Duration(seconds: 1))
                  //     );
                  //   },
                  //   child: Text('Quote Notification'),
                  // ),

                  // SizedBox(height: MediaQuery.of(context).size.height*.03),
                  Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .95,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .025,
                      vertical: MediaQuery.of(context).size.height * .02,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.grey.withOpacity(.2)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: MediaQuery.of(context).size.height * .12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).disabledColor,
                          ),
                          child: Stack(
                            children: [
                              FutureBuilder(
                                future: bankAnalytics,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                            .035,
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                            .01,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    .01,
                                              ),
                                              Text(
                                                translate('Total Balance'),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    .005,
                                              ),
                                              Text(
                                                "\$ ${snapshot.data!.total}",
                                                style: TextStyle(
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    .0075,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                spacing: 4,
                                                children: [
                                                  Text(
                                                    '${snapshot.data!.balance} : ${translate("Banks")}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    color: Color(0xFF009966),
                                                    size: 13,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    .0075,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                spacing: 4,
                                                children: [
                                                  Text(
                                                    '${snapshot.data!.receivableLoan} : ${translate("Recivable Loan")}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    color: Color(0xFF009966),
                                                    size: 13,
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    .0075,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                spacing: 4,
                                                children: [
                                                  Text(
                                                    '${snapshot.data!.payableLoan} : ${translate("Payable Loan")}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    color: Color(0xFF8B0836),
                                                    size: 13,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error getting analytics'),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }
                                },
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * .03,
                                left: MediaQuery.of(context).size.width * .4,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .3,
                                  height: MediaQuery.of(context).size.height * .1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff009966).withOpacity(.1),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * .05,
                                left: MediaQuery.of(context).size.width * .5,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .35,
                                  height: MediaQuery.of(context).size.height * .15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFAFAFA).withOpacity(.1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .015),
                      ],
                    ),
                  ),

                  // Financial Overview Section
                  SizedBox(height: MediaQuery.of(context).size.height * .035),
                  Column(
                    spacing: MediaQuery.of(context).size.height * .008,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate('Financial Overview'),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            translate('This Month'),
                            style: TextStyle(
                              color: Color(0xFF009966),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: expenseAnalytics,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(.5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Text(translate('Expenses OverView')),
                                          Row(
                                            children: [
                                              Text(
                                                '+',
                                                style: TextStyle(fontSize: 24),
                                              ),
                                              Text(
                                                '\$ ${snapshot.data!.total}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      spacing: 8,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          spacing: 4,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              spacing: 4,
                                              children: [
                                                Text(
                                                  '${snapshot.data!.must} : ${translate("Must")}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: Color(0xFF009966),
                                                  size: 8,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              spacing: 4,
                                              children: [
                                                Text(
                                                  '${snapshot.data!.maybe} : ${translate("Maybe")}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.orange,
                                                  size: 8,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              spacing: 4,
                                              children: [
                                                Text(
                                                  '${snapshot.data!.unwanted} : ${translate("Unwanted")}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.red,
                                                  size: 8,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error getting expense analytics'),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }
                        },
                      ),

                      FutureBuilder(
                        future: incomeAnalytics,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(.5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Text(translate('Income OverView')),
                                          Row(
                                            children: [
                                              Text(
                                                '+',
                                                style: TextStyle(fontSize: 24),
                                              ),
                                              Text(
                                                '\$ ${snapshot.data!['total']}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      spacing: 8,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          spacing: 4,
                                          children: [
                                            ...snapshot.data!['categorized'].map((
                                              MapEntry incomeType,
                                            ) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                spacing: 4,
                                                children: [
                                                  Text(
                                                    '${incomeType.key} : ${incomeType.value}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    color: Color(0xFF009966),
                                                    size: 8,
                                                  ),
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error getting income analytics'),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }
                        },
                      ),
                    ],
                  ),

                  // Financial Overview Section.
                  SizedBox(height: MediaQuery.of(context).size.height * .05),

                  //Recent Expenses Section
                  Column(
                    spacing: MediaQuery.of(context).size.height * .008,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate('VisionBoardSummery'),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            translate('See All'),
                            style: TextStyle(
                              color: Color(0xFF009966),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FutureBuilder(
                          future: goalAnalytics,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                spacing: MediaQuery.of(context).size.width * .035,
                                children: [
                                  ...snapshot.data!.map((goalAnalysis) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width * .3,
                                      height:
                                          MediaQuery.of(context).size.height * .2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey.withOpacity(.5),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                            .015,
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                            .012,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            goalAnalysis.title,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            goalAnalysis.date,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                .015,
                                          ),
                                          Center(
                                            child: Container(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  .2,
                                              height:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.height *
                                                  .1,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColorDark,
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      .015,
                                                ),
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    .175,
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    .075,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).primaryColorDark,
                                                ),
                                                child: DashedCircularProgressBar.aspectRatio(
                                                  aspectRatio: 1, // width ÷ height
                                                  valueNotifier: _valueNotifier,
                                                  progress: goalAnalysis.percent,
                                                  startAngle: 360,
                                                  sweepAngle: -360,
                                                  foregroundColor: Color(
                                                    0xff0FF009966,
                                                  ),
                                                  backgroundColor:
                                                      Theme.of(
                                                        context,
                                                      ).primaryColorDark,
                                                  foregroundStrokeWidth: 15,
                                                  backgroundStrokeWidth: 15,
                                                  animation: true,
                                                  seekSize: 6,
                                                  seekColor: const Color(
                                                    0xffeeeeee,
                                                  ),
                                                  child: Center(
                                                    child: ValueListenableBuilder(
                                                      valueListenable:
                                                          _valueNotifier,
                                                      builder:
                                                          (
                                                            _,
                                                            double value,
                                                            __,
                                                          ) => Column(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                '${goalAnalysis.percent}%',
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              );
                            } else {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error getting goal analytics'),
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            }
                          },
                        ),
                      ),
                      // Container(
                      //   child: Column(
                      //     spacing: MediaQuery.of(context).size.height * .01,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children:
                      //         expenses
                      //             .map(
                      //               (expense) =>
                      //                   DashboardExpenseItem(expense: expense),
                      //             )
                      //             .toList(),
                      //   ),
                      // ),
                    ],
                  ),
                  // Recent Expenses Section

                  //   Todays Habits Section

                  // SizedBox(height: MediaQuery.of(context).size.height*.035,),
                  // Column(
                  //   spacing: MediaQuery.of(context).size.height * .008,
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "Today's Habits",
                  //           style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 16),
                  //         ),
                  //         Text(
                  //           'See All',
                  //           style: TextStyle(color: Color(0xFF009966), fontSize: 12),
                  //         ),
                  //       ],
                  //     ),
                  //     Container(
                  //       child: Column(
                  //         spacing: MediaQuery.of(context).size.height * .008,
                  //         children:
                  //             habits
                  //                 .map((habit) => DashboardHabitItem(habit: habit))
                  //                 .toList(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // // Todays Habits Section
                  //
                  // // Board below todays habits and above the chart
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 10),
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: MediaQuery.of(context).size.width * .03,
                  //     vertical: MediaQuery.of(context).size.height * .025,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //     border: Border.all(
                  //       color: Color(0xFF27272A).withOpacity(.35),
                  //       width: 2.5,
                  //     ),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             'Weekly Completion',
                  //             style: TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w300,
                  //             ),
                  //           ),
                  //           Text(
                  //             'Apr 12 - Apr 19',
                  //             style: TextStyle(
                  //               fontSize: 10,
                  //               fontWeight: FontWeight.w300,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           Text(
                  //             '12',
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //           Icon(
                  //             Icons.local_fire_department,
                  //             color: Color(0xFFE36810),
                  //             size: 16,
                  //           ),
                  //         ],
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         spacing: 4,
                  //         children: [
                  //           Row(
                  //             spacing: 4,
                  //             children: [
                  //               Icon(Icons.circle, color: Color(0xFF009966), size: 8),
                  //               Text(
                  //                 'This Week',
                  //                 style: TextStyle(
                  //                   fontSize: 10,
                  //                   fontWeight: FontWeight.w300,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             spacing: 4,
                  //             children: [
                  //               Icon(Icons.circle, color: Color(0xFF3F3F47), size: 8),
                  //               Text(
                  //                 'Last Week',
                  //                 style: TextStyle(
                  //                   fontSize: 10,
                  //                   fontWeight: FontWeight.w300,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // // Board below todays habits and above the chart
                  //
                  // // Top community challenges
                  // Column(
                  //   spacing: MediaQuery.of(context).size.height * .008,
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "Top Community Challenges",
                  //           style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 16),
                  //         ),
                  //         Text(
                  //           'See All',
                  //           style: TextStyle(color: Color(0xFF009966), fontSize: 12),
                  //         ),
                  //       ],
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.symmetric(
                  //         horizontal: 20.0,
                  //         vertical: 4.0,
                  //       ),
                  //       margin: EdgeInsets.only(bottom: 10.0),
                  //       decoration: BoxDecoration(
                  //         color: Color(0xFF27272A).withValues(alpha: .5),
                  //         borderRadius: BorderRadius.circular(10.0),
                  //       ),
                  //       // Container(
                  //       //       padding: EdgeInsets.symmetric(
                  //       //         horizontal: 12.0,
                  //       //         vertical: 4.0,
                  //       //       ),
                  //       //       margin: EdgeInsets.only(bottom: 10.0),
                  //       //       decoration: BoxDecoration(
                  //       //         color: Color(0xFF27272A).withValues(alpha: .5),
                  //       //         borderRadius: BorderRadius.circular(40.0),
                  //       //       ),
                  //       //       alignment: Alignment.center,
                  //       //       child: Text(
                  //       //         quote.category,
                  //       //         style: TextStyle(color: Colors.white, fontSize: 12),
                  //       //       ),
                  //       //     ),
                  //       child: Column(
                  //         spacing: MediaQuery.of(context).size.height * .008,
                  //         children: [
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Text('60 Days Active Body Transformation'),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(
                  //                   horizontal: 12.0,
                  //                   vertical: 4.0,
                  //                 ),
                  //                 margin: EdgeInsets.only(bottom: 10.0),
                  //                 decoration: BoxDecoration(
                  //                   color: Color(0xFF00D492).withValues(alpha: .5),
                  //                   borderRadius: BorderRadius.circular(40.0),
                  //                 ),
                  //                 alignment: Alignment.center,
                  //                 child: Text(
                  //                   'Active',
                  //                   style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontSize: 12,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(
                  //                   horizontal: 12.0,
                  //                   vertical: 4.0,
                  //                 ),
                  //                 margin: EdgeInsets.only(bottom: 10.0),
                  //                 decoration: BoxDecoration(
                  //                   color: Color(0xFF27272A).withValues(alpha: .5),
                  //                   borderRadius: BorderRadius.circular(40.0),
                  //                 ),
                  //                 alignment: Alignment.center,
                  //                 child: Text(
                  //                   'Fitness',
                  //                   style: TextStyle(
                  //                     // color: Color(0xFF27272A),
                  //                     fontSize: 12,
                  //                   ),
                  //                 ),
                  //               ),
                  //               Row(
                  //                 spacing: MediaQuery.of(context).size.width * 0.02,
                  //                 children: [Icon(Icons.people, size: 16), Text('4')],
                  //               ),
                  //               Row(
                  //                 spacing: MediaQuery.of(context).size.width * 0.02,
                  //                 children: [
                  //                   Icon(Icons.calendar_today, size: 16),
                  //                   Text('April 12'),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //           Row(),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),z
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardHabitItem extends StatelessWidget {
  final dynamic habit;
  const DashboardHabitItem({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .001),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .02,
              vertical: MediaQuery.of(context).size.height * .015,
            ),
            width: MediaQuery.of(context).size.width * .93,
            decoration: BoxDecoration(
              // color: Color(0xff0d805e).withOpacity(.35),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xFF27272A).withOpacity(.35),
                width: 2.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: MediaQuery.of(context).size.width * .02,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF27272A),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        habit['icon'],
                        color: Color(0xFF9F9FA9),
                        size: 20,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit['title'],
                          style: TextStyle(
                            color: Color(0xFFE4E4E7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          habit['frequency'],
                          style: TextStyle(
                            color: Color(0xFFE4E4E7),
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .0125),

                SizedBox(height: MediaQuery.of(context).size.height * .015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   "Status : ",
                        //   style: GoogleFonts.lato(
                        //     fontSize: 13,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Text("\$ ${habit['streak']}"),
                        Icon(
                          Icons.local_fire_department,
                          color: Color(0xFFE36810),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
