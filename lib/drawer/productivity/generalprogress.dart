import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/productivity/categorydetail.dart';
import 'package:flutter_application_1/drawer/productivity/generalprogressstreakview.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Generalprogress extends StatefulWidget {
  final Future<Productivity> productivityFuture;

  const Generalprogress({super.key, required this.productivityFuture});

  @override
  State<Generalprogress> createState() => _GeneralprogressState();
}

class _GeneralprogressState extends State<Generalprogress> {
  @override
  // Widget categoryBuilder(ProductivityHabit p) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * .935,
  //     height: MediaQuery.of(context).size.height * .075,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: MediaQuery.of(context).size.width * .015,
  //       vertical: MediaQuery.of(context).size.height * .0075,
  //     ),
  //     padding: EdgeInsets.symmetric(
  //       horizontal: MediaQuery.of(context).size.width * .025,
  //       vertical: MediaQuery.of(context).size.height * .015,
  //     ),
  //     decoration: BoxDecoration(
  //       color: Color(0xff393838),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           p.title,
  //           style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
  //         ),
  //         Text(
  //           "${p.habitList?.length ?? 0} Sub tasks ",
  //           style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget categoryBuilder({
    required String title,
    required int subtaskCount,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .935,
        height: MediaQuery.of(context).size.height * .075,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .015,
          vertical: MediaQuery.of(context).size.height * .0075,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .025,
          vertical: MediaQuery.of(context).size.height * .015,
        ),
        decoration: BoxDecoration(
          gradient:
              Theme.of(context).brightness == Brightness.dark
                  ? LinearGradient(
                    colors: [Color(0xff18181B), Color(0xff27272A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : LinearGradient(
                    colors: [Color(0xffD4D4D8), Color(0xffF4F4F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            Text(
              "$subtaskCount Sub-tasks",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .0075),
          // GestureDetector(
          //   onTap: () {
          //     PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
          //       context,
          //       screen: Generalprogressstreakview(),
          //       withNavBar: false,
          //       pageTransitionAnimation: PageTransitionAnimation.cupertino,
          //       settings: const RouteSettings(),
          //     );
          //   },
          //   // child: Container(
          //   //   width: MediaQuery.of(context).size.width * .935,
          //   //   height: MediaQuery.of(context).size.height * .085,
          //   //   margin: EdgeInsets.symmetric(
          //   //     horizontal: MediaQuery.of(context).size.width * .015,
          //   //     vertical: MediaQuery.of(context).size.height * .0075,
          //   //   ),
          //   //   padding: EdgeInsets.symmetric(
          //   //     horizontal: MediaQuery.of(context).size.width * .025,
          //   //     vertical: MediaQuery.of(context).size.height * .015,
          //   //   ),
          //   //   decoration: BoxDecoration(
          //   //     borderRadius: BorderRadius.circular(10),
          //   //   ),
          //   //   child: Row(
          //   //     crossAxisAlignment: CrossAxisAlignment.start,
          //   //     mainAxisAlignment: MainAxisAlignment.start,
          //   //     children: [
          //   //       Column(
          //   //         crossAxisAlignment: CrossAxisAlignment.start,
          //   //         children: [
          //   //           Text(
          //   //             "12/03/2025 - 21/03/2025",
          //   //             style: TextStyle(
          //   //               fontSize: 14,
          //   //               fontWeight: FontWeight.w300,
          //   //             ),
          //   //           ),
          //   //           SizedBox(
          //   //             height: MediaQuery.of(context).size.height * .005,
          //   //           ),
          //   //           Text(
          //   //             "6 Days Per Week",
          //   //             style: TextStyle(
          //   //               fontSize: 14,
          //   //               fontWeight: FontWeight.w300,
          //   //             ),
          //   //           ),
          //   //         ],
          //   //       ),
          //   //       SizedBox(width: MediaQuery.of(context).size.width * .225),
          //   //       Icon(
          //   //         Icons.local_fire_department_rounded,
          //   //         size: 35,
          //   //         color: Colors.orange,
          //   //       ),
          //   //       SizedBox(width: MediaQuery.of(context).size.width * .013),
          //   //       Padding(
          //   //         padding: EdgeInsets.only(
          //   //           top: MediaQuery.of(context).size.height * .0095,
          //   //         ),
          //   //         child: Text(
          //   //           "2 Weeks",
          //   //           style: TextStyle(
          //   //             fontSize: 15,
          //   //             fontWeight: FontWeight.w400,
          //   //           ),
          //   //         ),
          //   //       ),
          //   //     ],
          //   //   ),
          //   // ),
          // ),
          SizedBox(height: MediaQuery.of(context).size.height * .0225),
          FutureBuilder(
            future: widget.productivityFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final habits = snapshot.data?.productivityHabits ?? [];

              final my_date =
                  habits
                      .map((e) => DateTime.parse(e.created_at).toLocal())
                      .toList();

              // 1) Group by title
              final Map<String, List<ProductivityHabit>> grouped = {};
              for (var h in habits) {
                grouped.putIfAbsent(h.title, () => []).add(h);
              }

              // 2) Build a list of widgets
              final widgets =
                  grouped.entries.map((entry) {
                    final title = entry.key;
                    final group = entry.value;

                    // Count total subtasks across this group
                    final totalSubtasks = group.fold<int>(
                      0,
                      (sum, habit) => sum + (habit.habitList?.length ?? 0),
                    );

                    // inside your FutureBuilder’s map:
                    void _handleTap() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => CategoryDetail(
                                title: title,
                                habits: group,
                                date: my_date,
                              ),
                        ),
                      );
                    }

                    // onTap: navigate, passing the entire `group`
                    // void _handleTap() {
                    //   // Navigator.push(
                    //   //   context,
                    //   //   MaterialPageRoute(
                    //   //     builder:
                    //   //         (_) =>
                    //   //             YourDetailScreen(title: title, habits: group),
                    //   //   ),
                    //   // );
                    // }

                    return categoryBuilder(
                      title: title,
                      subtaskCount: totalSubtasks,
                      onTap: _handleTap,
                      context: context,
                    );
                  }).toList();

              return SingleChildScrollView(child: Column(children: widgets));
            },
          ),

          // FutureBuilder(
          //   future: widget.productivityFuture,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       var data = snapshot.data?.productivityHabits;
          //       return Column(
          //         children: data?.map((e) => categoryBuilder(e)).toList() ?? [],
          //       );
          //     } else {
          //       if (snapshot.hasError) {
          //         print(snapshot.error);
          //         return Text('Error: ${snapshot.error}');
          //       } else {
          //         return const Center(child: CircularProgressIndicator());
          //       }
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
