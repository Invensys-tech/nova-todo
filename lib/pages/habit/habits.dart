import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/habit/components/habit-daily-list.dart';
import 'package:flutter_application_1/pages/habit/components/habits-list.dart';
import 'package:flutter_application_1/pages/habit/form.habit.dart';
import 'package:flutter_application_1/providers/user.provider.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../drawer/drawerpage.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  DateTime now = DateTime.now();

  late Future<List<Habit>> habits;

  @override
  void initState() {
    super.initState();
    habits = HabitsRepository().fetchHabits();
  }

  void newHabit() async {


    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      screen: HabitForm(date: getDateOnly(now), refetchData: refetchData),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
      settings: const RouteSettings(),
    );
  }

  void refetchData() {
    habits = HabitsRepository().fetchHabits();
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      drawer: Drawer(child: Drawerpage(), backgroundColor: Colors.transparent),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: newHabit,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Text(translate("Habits")),
            SizedBox(width: MediaQuery.of(context).size.width*.015,),
            Container(
              height: MediaQuery.of(context).size.height*.03,
                width: MediaQuery.of(context).size.width*.06,
                child: Image.asset('assets/Gif/Habit.gif'))

          ],
        ),
         centerTitle: false,
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: () {

              },
              icon:Icon(Icons.menu,size: 22, color: Color(0xff009966),)
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.02),

        child: Column(
          children: [
            // DefaultTabController(
            //   length: 2,
            //   child: Scaffold(
            //     appBar: AppBar(
            //       automaticallyImplyLeading: false,
            //       bottom: TabBar(
            //         tabs: [Tab(text: "Daily"), Tab(text: "General")],
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
            //         Container(child: HabitsDailyList()),
            //         Container(child: HabitsList(date: null, habits: habits)),
            //       ],
            //     ),
            //   ),
            // ),

            Expanded(
              child: ContainedTabBarView(
                tabs: [
                  Tab(text: translate("Daily Habit")),
                  Tab(text: translate("All Habits")),
                ],
                tabBarProperties: TabBarProperties(
                  width: MediaQuery.of(context).size.width,
                  height: 32,
                  isScrollable: false,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .035,
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
              
                    ),
                  ),
                  position: TabBarPosition.top,
                  alignment: TabBarAlignment.start,
                  indicatorColor: Color(0xff009966),
                  labelStyle: TextStyle(fontSize: 16, color:Color(0xff009966)),
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Theme.of(context).primaryColorLight,
                  unselectedLabelStyle: TextStyle(fontSize: 13),
                ),
                views: [
                  Container(child: HabitsDailyList()),
                  Container(child: HabitsList(date: null, habits: habits)),
                ],
              ),
            ),
          ],
        ),


      ),
    );
  }
}
