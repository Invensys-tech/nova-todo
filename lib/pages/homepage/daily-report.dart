import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/analytics.service.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({super.key});

  @override
  State<DailyReport> createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  final incomeAnalytics = AnalyticsService.getIncome();
  final expenseAnalytics = AnalyticsService.getExpense();
  final habits = AnalyticsService.getHabitAnalytics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 25,
            color: Color(0xff006045),
          ),
        ),
        title: const Text(
          "Daily Report",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: MediaQuery.of(context).size.height * .03,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Color(0xFF18181B), Color(0xFF27272A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      translate('Success Rate'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    LinearProgressIndicator(
                      value: .4,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                      backgroundColor: Color(0xFF3F3F47),
                      color: Color(0xFF009966),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '40 % of the work done',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              FutureBuilder(
                future: expenseAnalytics,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      width: MediaQuery.of(context).size.width * .95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Color(0xFF18181B), Color(0xFF27272A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translate('Expenses'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '\$ ${snapshot.data!.total}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            spacing: 5,
                            children: [
                              Expanded(
                                flex: snapshot.data!.must.toInt(),
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF009966),
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ), // Rounded corners
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: snapshot.data!.maybe.toInt(),
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ), // Rounded corners
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: snapshot.data!.unwanted.toInt(),
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEC003F),
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ), // Rounded corners
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // LinearProgressIndicator(
                          //   value: .4,
                          //   minHeight: 8,
                          //   borderRadius: BorderRadius.circular(4),
                          //   backgroundColor: Color(0xFF3F3F47),
                          //   color: Color(0xFF009966),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 8,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF27272A),
                                        Color(0xFF18181B),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Column(
                                    spacing: 2,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Must',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF009966),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.must}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF27272A),
                                        Color(0xFF18181B),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Column(
                                    spacing: 2,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Maybe',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFD4D4D8),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.maybe}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF27272A),
                                        Color(0xFF18181B),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Column(
                                    spacing: 2,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Unwanted',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFEC003F),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.unwanted}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error getting expense'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                },
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Color(0xFF18181B), Color(0xFF27272A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate('Income'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    FutureBuilder(
                      future: incomeAnalytics,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            '\$ ${snapshot.data!['total']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return Center(child: Text('Error getting income'));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Color(0xFF18181B), Color(0xFF27272A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: FutureBuilder(
                  future: habits,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        spacing: 10,
                        children: [
                          Column(
                            spacing: 10,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translate('Habit Summary'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data!.where((habit) => habit.isDoneToday).length}/${snapshot.data!.length}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ...snapshot.data!.map(
                            (habit) => Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 16,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF27272A),
                                  ),
                                  child:
                                      habit.isDoneToday
                                          ? Icon(
                                            Icons.check,
                                            color: Color(0xFF00D492),
                                          )
                                          : Icon(
                                            Icons.close,
                                            color: Color(0xFFEC003F),
                                          ),
                                ),

                                Text(habit.name),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error getting habits'));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Color(0xFF18181B), Color(0xFF27272A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translate('Productivity Summary'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          translate('7/10'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF8B0836),
                          ),
                          child: Text('☹️', style: TextStyle(fontSize: 24)),
                        ),
                        Expanded(
                          child: Text(
                            'You need to make improvements. You Got It',
                            softWrap: true,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                width: MediaQuery.of(context).size.width * .95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Share',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF637E).withAlpha(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Color(0xFFFF637E),
                                width: 2,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Icon(Icons.camera, color: Color(0xFFFF637E)),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withAlpha(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.white, width: 2),
                            ),
                          ),
                          onPressed: () {},
                          child: Icon(Icons.music_note, color: Colors.white),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF00D492).withAlpha(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Color(0xFF00D492),
                                width: 2,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Icon(Icons.share, color: Color(0xFF00D492)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
