// import 'package:calendar_timeline/calendar_timeline.dart';
// import 'package:ethiopian_datetime/ethiopian_datetime.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/entities/habit-list.dart';
// import 'package:flutter_application_1/entities/productivity-entity.dart';
// import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
// import 'package:flutter_application_1/pages/homepage/edit.productivity-habit.dart';
// import 'package:flutter_application_1/pages/homepage/form.productivity-habit.dart';
// import 'package:flutter_application_1/repositories/productivity-habit.repository.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class DailyprogressLists extends StatefulWidget {
//   final Future<Productivity> productivityFuture;
//   const DailyprogressLists({super.key, required this.productivityFuture});

//   @override
//   State<DailyprogressLists> createState() => _DailyprogressListsState();
// }

// class _DailyprogressListsState extends State<DailyprogressLists> {
//   ETDateTime noww = ETDateTime.now();
//   @override
//   late int productivity_id;
//   final DateTime _today = DateTime.now();
//   DateTime _selectedDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget buildContainer(ProductivityHabit p) {
//     try {
//       print("Desprate Attempt");
//       print(p.created_at);
//       return Slidable(
//         key: ValueKey(p.id),
//         startActionPane: ActionPane(
//           motion: const ScrollMotion(),
//           children: [
//             SlidableAction(
//               onPressed: (_) {
//                 ProductivityHabitRepository().deleteProductivityHabit(p.id);
//               },
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               icon: Icons.delete,
//               label: 'Delete',
//             ),
//           ],
//         ),
//         endActionPane: ActionPane(
//           motion: const ScrollMotion(),
//           children: [
//             SlidableAction(
//               onPressed: (_) async {
//                 final changed = await Navigator.push<bool>(
//                   context,
//                   MaterialPageRoute(
//                     builder:
//                         (_) => EditProductivityHabitForm(
//                           habit: p,
//                           productivityId: p.productivity_id,
//                         ),
//                   ),
//                 );
//                 if (changed == true)
//                   setState(() {
//                     /* refresh your list */
//                   });
//               },
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//               icon: Icons.edit,
//               label: 'Edit',
//             ),
//           ],
//         ),
//         child: Container(
//           margin: EdgeInsets.symmetric(
//             vertical: MediaQuery.of(context).size.height * .015,
//             horizontal: MediaQuery.of(context).size.width * .025,
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: MediaQuery.of(context).size.height * .015,
//             horizontal: MediaQuery.of(context).size.width * .045,
//           ),
//           height: MediaQuery.of(context).size.height * .25,
//           width: MediaQuery.of(context).size.width * .925,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Color(0xff626262).withOpacity(.5),
//             border: Border.all(width: 1, color: Colors.white.withOpacity(.3)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 p.title,
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * .01),
//               Column(
//                 children: [
//                   ...?p.habitList?.map((e) => smallListBuilder(e)).toList() ??
//                       [],
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     } catch (e) {
//       return Text(
//         "Error loading note: $e",
//         style: const TextStyle(color: Colors.red),
//       );
//     }
//   }

//   Widget smallListBuilder(HabitList habit) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * .025,
//         vertical: MediaQuery.of(context).size.height * .005,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.circle,
//                 size: 14,
//                 color: Colors.white.withOpacity(.85),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width * .01),
//               Text(
//                 habit.title,
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),

//           Text(
//             habit.time,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: Colors.green,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget build(BuildContext context) {
//     final Color selectedColor = const Color(0xFF8B0836);
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         foregroundColor: Colors.white,
//         backgroundColor: const Color(0xFF2b2d30),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder:
//                   (context) =>
//                       ProductivityHabitForm(productivity_id: productivity_id),
//             ),
//           );
//           // fetchProductivity(); // Refresh after returning
//         },
//         child: const Icon(Icons.add, color: Colors.white, size: 30),
//       ),
//       body: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             CalendarTimeline(
//               initialDate: ETDateTime.now(),
//               firstDate: noww,
//               lastDate: DateTime(2027, 11, 20),
//               onDateSelected: (date) {
//                 print(ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(noww));
//               },

//               leftMargin: 20,
//               showYears: false,
//               monthColor: Colors.blueGrey,
//               dayColor: Colors.teal[200],
//               activeDayColor: Colors.white,
//               activeBackgroundDayColor: Colors.grey,
//               shrink: true,
//               locale: 'en_ISO',
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * .0125),
//             FutureBuilder(
//               future: widget.productivityFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   var data = snapshot.data?.productivityHabits;
//                   productivity_id = snapshot.data!.id;
//                   print("Data: $data");
//                   return Column(
//                     children:
//                         data?.map((e) => buildContainer(e)).toList() ?? [],
//                   );
//                 } else {
//                   if (snapshot.hasError) {
//                     print(snapshot.error);
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:calendar_timeline/calendar_timeline.dart';
// import 'package:ethiopian_datetime/ethiopian_datetime.dart';
// import 'package:flutter_application_1/services/hive.service.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_application_1/entities/habit-list.dart';
// import 'package:flutter_application_1/entities/productivity-entity.dart';
// import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
// import 'package:flutter_application_1/pages/homepage/form.productivity-habit.dart';
// import 'package:flutter_application_1/pages/homepage/edit.productivity-habit.dart';
// import 'package:flutter_application_1/repositories/productivity-habit.repository.dart';
// import 'package:flutter_application_1/repositories/habit-list.repositoty.dart';

// class DailyprogressLists extends StatefulWidget {
//   final Future<Productivity> productivityFuture;

//   const DailyprogressLists({Key? key, required this.productivityFuture})
//     : super(key: key);

//   @override
//   State<DailyprogressLists> createState() => _DailyprogressListsState();
// }

// class _DailyprogressListsState extends State<DailyprogressLists> {
//   final ETDateTime noww = ETDateTime.now();
//   final HiveService _hiveService = HiveService();
//   String _dateType = 'Gregorian';

//   late int productivity_id;

//   DateTime _selectedDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         foregroundColor: Colors.white,
//         backgroundColor: const Color(0xFF2b2d30),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder:
//                   (context) =>
//                       ProductivityHabitForm(productivity_id: productivity_id),
//             ),
//           );
//           setState(() {});
//         },
//         child: const Icon(Icons.add, size: 30),
//       ),
//       body: Column(
//         children: [
//           CalendarTimeline(
//             initialDate: _selectedDate,
//             firstDate: noww,
//             lastDate: DateTime(2027, 11, 20),
//             onDateSelected: (date) {
//               setState(() {
//                 _selectedDate = DateTime(date.year, date.month, date.day);
//               });
//             },
//             leftMargin: 20,
//             showYears: false,
//             monthColor: Colors.blueGrey,
//             dayColor: Colors.teal[200],
//             activeDayColor: Colors.white,
//             activeBackgroundDayColor: Colors.grey,
//             shrink: true,
//             locale: 'en_ISO',
//           ),

//           const SizedBox(height: 8),

//           Expanded(
//             child: FutureBuilder<Productivity>(
//               future: widget.productivityFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 final response = snapshot.data!;
//                 productivity_id = response.id;
//                 final allHabits = response.productivityHabits ?? [];

//                 final filtered =
//                     allHabits.where((p) {
//                       final dt = DateTime.parse(p.created_at).toLocal();
//                       return dt.year == _selectedDate.year &&
//                           dt.month == _selectedDate.month &&
//                           dt.day == _selectedDate.day;
//                     }).toList();

//                 if (filtered.isEmpty) {
//                   return Center(
//                     child: Text(
//                       "No habits logged on "
//                       "${_selectedDate.toLocal().toString().split(' ')[0]}",
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   itemCount: filtered.length,
//                   itemBuilder: (context, i) {
//                     return buildContainer(filtered[i]);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildContainer(ProductivityHabit p) {
//     return Slidable(
//       key: ValueKey(p.id),
//       startActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         children: [
//           SlidableAction(
//             onPressed: (_) {
//               ProductivityHabitRepository().deleteProductivityHabit(p.id);
//               setState(() {});
//             },
//             backgroundColor: Colors.red,
//             foregroundColor: Colors.white,
//             icon: Icons.delete,
//             label: 'Delete',
//           ),
//         ],
//       ),
//       endActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         children: [
//           SlidableAction(
//             onPressed: (_) async {
//               final changed = await Navigator.push<bool>(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (_) => EditProductivityHabitForm(
//                         habit: p,
//                         productivityId: p.productivity_id,
//                       ),
//                 ),
//               );
//               if (changed == true) setState(() {});
//             },
//             backgroundColor: Colors.blue,
//             foregroundColor: Colors.white,
//             icon: Icons.edit,
//             label: 'Edit',
//           ),
//         ],
//       ),
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           vertical: MediaQuery.of(context).size.height * .015,
//           horizontal: MediaQuery.of(context).size.width * .025,
//         ),
//         padding: EdgeInsets.symmetric(
//           vertical: MediaQuery.of(context).size.height * .015,
//           horizontal: MediaQuery.of(context).size.width * .045,
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: const Color(0xff626262).withOpacity(.5),
//           border: Border.all(width: 1, color: Colors.white.withOpacity(.3)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               p.title,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),
//             ...?p.habitList?.map((e) => smallListBuilder(e)).toList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget smallListBuilder(HabitList habit) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * .025,
//         vertical: MediaQuery.of(context).size.height * .005,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.circle,
//                 size: 14,
//                 color: Colors.white.withOpacity(.85),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width * .01),
//               Text(
//                 habit.title,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             habit.time,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: Colors.green,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/habit-list.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/homepage/edit.productivity-habit.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity-habit.dart';
import 'package:flutter_application_1/pages/homepage/edit.productivity-habit.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_application_1/repositories/productivity-habit.repository.dart';
import 'package:flutter_application_1/repositories/productivity-habit.repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DailyprogressLists extends StatefulWidget {
  final Future<Productivity> productivityFuture;

  const DailyprogressLists({Key? key, required this.productivityFuture})
    : super(key: key);

  @override
  State<DailyprogressLists> createState() => _DailyprogressListsState();
}

class _DailyprogressListsState extends State<DailyprogressLists> {
  final HiveService _hiveService = HiveService();
  String _dateType = 'Gregorian';

  late DateTime _selectedDate;
  late DateTime _queryDate;

  late int productivity_id;

  late int streak;

  @override
  void initState() {
    super.initState();
    _initDateMode();
  }

  Future<void> _initDateMode() async {
    // 1) init Hive and read saved dateType
    await _hiveService.initHive(boxName: 'dateTime');
    final stored = await _hiveService.getData('dateType');
    _dateType = (stored == 'Ethiopian') ? 'Ethiopian' : 'Gregorian';

    // 2) seed initial selectedDate & queryDate
    final now = DateTime.now();
    if (_dateType == 'Ethiopian') {
      final et = now.convertToEthiopian();
      _selectedDate = DateTime(et.year, et.month, et.day);
      // convert back to Gregorian midnight for filtering
      final g = ETDateTime(et.year, et.month, et.day).convertToGregorian();
      _queryDate = DateTime(g.year, g.month, g.day);
    } else {
      _selectedDate = now;
      _queryDate = DateTime(now.year, now.month, now.day);
    }

    setState(() {});
  }

  void _onDateSelected(DateTime tapped) {
    DateTime filterDate = tapped;
    if (_dateType == 'Ethiopian') {
      // tapped is in Ethiopian calendar
      final g =
          ETDateTime(
            tapped.year,
            tapped.month,
            tapped.day,
          ).convertToGregorian();
      filterDate = DateTime(g.year, g.month, g.day);
    }

    setState(() {
      _selectedDate = tapped;
      _queryDate = filterDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff009966),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ProductivityHabitForm(
                    productivity_id: productivity_id,
                    streak_count: streak,
                  ),
            ),
          );
          setState(() {}); // refresh after new habit
        },
        child: const Icon(Icons.add, size: 30),
      ),
      body: Column(
        children: [
          CalendarTimeline(
            initialDate: _selectedDate,
            firstDate: DateTime(2000, 1, 1),
            lastDate: DateTime(2027, 11, 20),
            onDateSelected: _onDateSelected,
            leftMargin: 20,
            showYears: false,
            monthColor: Colors.blueGrey,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.grey,
            shrink: true,
            locale: _dateType == 'Ethiopian' ? 'am' : 'en',
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<Productivity>(
              future: widget.productivityFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final data = snapshot.data!;
                productivity_id = data.id;
                streak = data.streak_count!;
                final allHabits = data.productivityHabits ?? [];

                // filter by queryDate (Gregorian midnight)
                final filtered =
                    allHabits.where((p) {
                      final dt = DateTime.parse(p.created_at).toLocal();
                      return dt.year == _queryDate.year &&
                          dt.month == _queryDate.month &&
                          dt.day == _queryDate.day;
                    }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      "No habits logged on "
                      "${_queryDate.toLocal().toString().split(' ')[0]}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .0015,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (ctx, i) => _buildHabitTile(filtered[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitTile(ProductivityHabit p) {
    return Slidable(
      key: ValueKey(p.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              ProductivityHabitRepository().deleteProductivityHabit(p.id);
              setState(() {});
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              final changed = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => EditProductivityHabitForm(
                        habit: p,
                        productivityId: p.productivity_id,
                      ),
                ),
              );
              if (changed == true) setState(() {});
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .0075,
          horizontal: MediaQuery.of(context).size.width * .025,
        ),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .015,
          horizontal: MediaQuery.of(context).size.width * .045,
        ),
        width: MediaQuery.of(context).size.width * .925,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              p.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...?p.habitList?.map((e) => _smallListBuilder(e)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _smallListBuilder(HabitList habit) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .0,
        vertical: MediaQuery.of(context).size.height * .005,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 14,
                color: Colors.white.withOpacity(.85),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .01),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Text(
                  habit.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .025),
          Container(
            width: MediaQuery.of(context).size.width * .315,
            child: Text(
              habit.time,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
