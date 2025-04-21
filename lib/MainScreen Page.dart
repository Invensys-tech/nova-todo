import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/homepage/home.dart';
import 'package:flutter_application_1/pages/notespage/notes.dart';
import 'package:flutter_application_1/pages/todopage/todo.dart';
import 'package:flutter_application_1/pages/finance/finance.dart';
import 'package:flutter_application_1/pages/goal/goal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'drawer/Seeting Page/SeetingPage.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({super.key});

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  var dataManager = Datamanager();

  PersistentTabController _persistentTabController = PersistentTabController(
    initialIndex: 0,
  );

  List<Widget> _buildScreens() {
    return [
      HomePage(datamanager: dataManager),
      FinanceUi(datamanager: dataManager),
      GoalPage(datamanager: dataManager),
      TodoPage(),
      NotesPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: translate("Home"),
        iconSize: 24,
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        activeColorPrimary: const Color(0xff2E783A),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.piggyBank),
        title: translate("Finance"),
        iconSize: 24,
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        activeColorPrimary: const Color(0xff0E7831),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.locationArrow),
        title: translate("Vision Board"),
        iconSize: 24,
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        activeColorPrimary: const Color(0xff0E7831),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.assignment_add),
        title: translate("ToDos"),
        iconSize: 24,
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        activeColorPrimary: const Color(0xff0E7831),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.edit),
        title:  translate("Notes"),
        iconSize: 23,
        contentPadding: 0,
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        activeColorPrimary: const Color(0xff0E7831),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: PersistentTabView(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: MediaQuery.of(context).size.height * .007,
          ),
          context,
          controller: _persistentTabController,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineToSafeArea: true,
          margin: EdgeInsets.all(0),
          backgroundColor: Theme.of(context).primaryColorDark, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardAppears:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10)
            ),
            colorBehindNavBar: Colors.transparent,
          ),
          animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              duration: Duration(milliseconds: 200),
              screenTransitionAnimationType:
                  ScreenTransitionAnimationType.fadeIn,
            ),
          ),
          navBarStyle:
              NavBarStyle
                  .style6, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}
