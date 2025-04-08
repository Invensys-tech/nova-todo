import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/habit-list.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity-habit.dart';

class DailyprogressLists extends StatefulWidget {
  final Future<Productivity> productivityFuture;
  const DailyprogressLists({super.key, required this.productivityFuture});

  @override
  State<DailyprogressLists> createState() => _DailyprogressListsState();
}

class _DailyprogressListsState extends State<DailyprogressLists> {
  ETDateTime noww = ETDateTime.now();
  @override
  late int productivity_id;
  Widget buildContainer(ProductivityHabit p) {
    try {
      print(p);
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .015,
          horizontal: MediaQuery.of(context).size.width * .025,
        ),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .015,
          horizontal: MediaQuery.of(context).size.width * .045,
        ),
        height: MediaQuery.of(context).size.height * .25,
        width: MediaQuery.of(context).size.width * .925,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff626262).withOpacity(.5),
          border: Border.all(width: 1, color: Colors.white.withOpacity(.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              p.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            Column(
              children: [
                ...?p.habitList?.map((e) => smallListBuilder(e)).toList() ?? [],
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return Text(
        "Error loading note: $e",
        style: const TextStyle(color: Colors.red),
      );
    }
  }

  Widget smallListBuilder(HabitList habit) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .025,
        vertical: MediaQuery.of(context).size.height * .005,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                size: 14,
                color: Colors.white.withOpacity(.85),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .01),
              Text(
                habit.title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),

          Text(
            habit.time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      ProductivityHabitForm(productivity_id: productivity_id),
            ),
          );
          // fetchProductivity(); // Refresh after returning
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            CalendarTimeline(
              initialDate: ETDateTime.now(),
              firstDate: noww,
              lastDate: DateTime(2027, 11, 20),
              onDateSelected: (date) {
                print(ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(noww));
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
            SizedBox(height: MediaQuery.of(context).size.height * .0125),
            FutureBuilder(
              future: widget.productivityFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data?.productivityHabits;
                  productivity_id = snapshot.data!.id;
                  print("Data: $data");
                  return Column(
                    children:
                        data?.map((e) => buildContainer(e)).toList() ?? [],
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
          ],
        ),
      ),
    );
  }
}
