import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/habit-history.entitiy.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habit.missed.item.dart';
import 'package:flutter_application_1/pages/habit/form.habit.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HabitView extends StatefulWidget {
  final Habit habit;

  const HabitView({super.key, required this.habit});

  @override
  State<HabitView> createState() => _HabitViewState();
}

class _HabitViewState extends State<HabitView> {
  late Future<List<HabitHistory>> habitHistories;

  @override
  void initState() {
    super.initState();
    habitHistories = HabitsRepository().getStreakHistories(widget.habit.id!);
  }

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
                final deleted = await HabitsRepository().deleteById(
                  widget.habit!.id!,
                );
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
          widget.habit.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
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
                  Text(widget.habit.type, style: TextStyle(fontSize: 14)),
                  Text(
                    'Created At: ${getDateOnly(DateTime.parse(widget.habit.date))}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  MaterialPageRoute(
                    builder:
                        (context) => HabitForm(
                          refetchData: () {},
                          habit: widget.habit,
                          isEditing: true,
                        ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    shape: BoxShape.circle,
                  ),
                  child: FaIcon(FontAwesomeIcons.pencil, size: 20),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).primaryColorDark,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(.4),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      // spacing: MediaQuery.of(context).size.height * 0.03,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
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
                                              '${widget.habit.goingOnFor.toString()} Days',
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
                                      '${widget.habit.trueStreak} Days',
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
                                    FutureBuilder(
                                      future: habitHistories,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            '${snapshot.data!.length}',
                                            style: TextStyle(
                                              color: Color(0xFFF4F4F5),
                                              fontSize: 20,
                                            ),
                                          );
                                        } else {
                                          if (snapshot.hasError) {
                                            return Text(
                                              '0',
                                              style: TextStyle(
                                                color: Color(0xFFF4F4F5),
                                                fontSize: 20,
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              '',
                                              style: TextStyle(
                                                color: Color(0xFFF4F4F5),
                                                fontSize: 20,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                    // Text(
                                    //   '${8} Days',
                                    //   style: TextStyle(
                                    //     color: Color(0xFFF4F4F5),
                                    //     fontSize: 20,
                                    //   ),
                                    // ),
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
                        // 'Skipped Days',
                        'Previous Streaks',
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
                  child: FutureBuilder(
                    future: habitHistories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:
                              snapshot.data!
                                  .map(
                                    (habitHistory) => HabitHistoryItem(
                                      habitHistory: habitHistory,
                                    ),
                                  )
                                  .toList(),
                        );
                      } else {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error getting habit histories'),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Expanded(
                //       flex: 2,
                //       child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(8),
                //             side: BorderSide(
                //               color: Theme.of(context).disabledColor,
                //               width: 1,
                //             ),
                //           ),
                //         ),
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder:
                //                   (context) => HabitForm(
                //                     refetchData: () {},
                //                     habit: widget.habit,
                //                     isEditing: true,
                //                   ),
                //             ),
                //           );
                //           print('Editing...');
                //         },
                //         child: Text(
                //           "Edit",
                //         ),
                //       ),
                //     ),
                //     Expanded(flex: 2, child: SizedBox()),
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Color(0xFF27272A),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8),
                //           side: BorderSide(color: Color(0xFFEC003F), width: 2),
                //         ),
                //       ),
                //       onPressed: () {
                //         _showAlertDialog(context);
                //       },
                //       child: Text(
                //         "Delete",
                //         style: TextStyle(color: Color(0xFFEC003F)),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

// class BottomSemiCircleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0, 0);
//     path.arcToPoint(
//       Offset(size.width, 0),
//       radius: Radius.circular(size.width),
//       clockwise: false,
//     );
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
