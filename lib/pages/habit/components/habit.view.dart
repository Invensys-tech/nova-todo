import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habit.missed.item.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class HabitView extends StatelessWidget {
  final Habit habit;
  const HabitView({super.key, required this.habit});

  Widget _buildCircle(double radius, Color color) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  _showAlertDialog(BuildContext pageContext) {
    showDialog(
      context: pageContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text("Would you like to delete this task?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Color(0xFFEC003F))),
              onPressed: () async {
                  final deleted = await HabitsRepository().deleteById(habit!.id!);
                  if (deleted) {
                    Navigator.of(context).pop();
                    Navigator.of(pageContext).pop();
                  }
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          habit.name,
          style: TextStyle(
            color: Color(0xFFD4D4D8),
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              // onPressed: navigateBack,
              onPressed: () {},
              icon: const Icon(Icons.keyboard_arrow_left, color: Colors.green),
            ),
          ],
        ),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        actions: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: MediaQuery.of(context).size.height * 0.01,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: MediaQuery.of(context).size.height * 0.005,
                children: [
                  Text(
                    habit.type,
                    style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 14),
                  ),
                  Text(
                    'Created At: ${getDateOnly(DateTime.parse(habit.date))}',
                    style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 12),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF27272A),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.book_online_outlined,
                  color: Color(0xFF009966),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            child: (Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFF27272A),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      spacing: MediaQuery.of(context).size.height * 0.03,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF006045),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Positioned(
                                    bottom: -50,
                                    right: -10,
                                    child: _buildCircle(
                                      100.0,
                                      const Color(
                                        0xFFFAFAFA,
                                      ).withValues(alpha: .1),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -10,
                                    right: 30,
                                    child: _buildCircle(
                                      75.0,
                                      const Color(
                                        0xFF009966,
                                      ).withValues(alpha: .2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Going On For',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Row(
                                          children: [
                                            Text(
                                              '${habit.goingOnFor.toString()} Days',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 32.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: MediaQuery.of(context).size.height * 0.02,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFF3F3F47),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Accomplished',
                                      style: TextStyle(
                                        color: Color(0xFF009966),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${habit.streakDates.length} Days',
                                      style: TextStyle(
                                        color: Color(0xFFF4F4F5),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFF3F3F47),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Failed',
                                      style: TextStyle(
                                        color: Color(0xFFEC003F),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${habit.goingOnFor - (habit.streakDates.length)} Days',
                                      style: TextStyle(
                                        color: Color(0xFFF4F4F5),
                                        fontSize: 20,
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
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Skipped Days',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF009966),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        habit.missedDates
                            .map(
                              (missedDate) =>
                                  HabitMissedDateItem(dateString: missedDate),
                            )
                            .toList(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF27272A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xFFEC003F), width: 2),
                        ),
                      ),
                      onPressed: () {
                        print('delete...');
                        _showAlertDialog(context);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Color(0xFFEC003F)),
                      ),
                    ),
                  ]
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class BottomSemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.arcToPoint(
      Offset(size.width, 0),
      radius: Radius.circular(size.width),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
