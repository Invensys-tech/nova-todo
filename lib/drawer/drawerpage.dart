import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/CommunityChallenges.dart';
import 'package:flutter_application_1/drawer/Profile/Profile.dart';
import 'package:flutter_application_1/drawer/Seeting%20Page/SeetingPage.dart';
import 'package:flutter_application_1/drawer/productivity/productivity.home.dart';
import 'package:flutter_application_1/pages/goal/goal.dart';
import 'package:flutter_application_1/pages/notifications/notifications.dart';
import 'package:flutter_application_1/pages/pricing/pricing.dart';
import 'package:flutter_application_1/pages/quotes/quotes.dart';
import 'package:flutter_application_1/services/analytics.service.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../datamanager.dart';

class Drawerpage extends StatefulWidget {
  const Drawerpage({super.key});

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  final userInfo = AuthService().findSession();
  late Future<double> completionPercentage;

  @override
  void initState() {
    super.initState();
    completionPercentage = AnalyticsService.getSuccessRate(DateTime.now());
  }

  var dataManager = Datamanager();

  routeToHabits() {
    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      screen: GoalPage(datamanager: dataManager),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
      settings: const RouteSettings(),
    );
  }

  routeToPricing() {
    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      screen: PricingScreen(canNavigateBack: true),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
      settings: const RouteSettings(),
    );
  }

  routeToQuotes() {
    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      screen: QuotesPage(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
      settings: const RouteSettings(),
    );
  }

  routeToNotifications() {
    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      screen: NotificationsPage(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
      settings: const RouteSettings(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .055,
      ),
      width: MediaQuery.of(context).size.width * .65,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * .175,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .03),
          Container(
            width: MediaQuery.of(context).size.width * .65,
            height: MediaQuery.of(context).size.height * .05,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/Images/VitaNew.png",
                  width: MediaQuery.of(context).size.width * .09,
                  height: MediaQuery.of(context).size.height * .045,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .005),
                Text(
                  "Vita",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff113F6C),
                  ),
                ),

                Text(
                  " Board",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff51BD82),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025),
          Divider(),

          SizedBox(height: MediaQuery.of(context).size.height * .025),
          GestureDetector(
            onTap: routeToHabits,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.refresh,
                  color: Color(0xff00D492),
                  size: 19,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .035),
                Text(
                  translate("Vision Board"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025),
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: ProductivityHome(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                settings: const RouteSettings(name: "/productivity-home"),
              );
            },
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.bolt,
                  color: Color(0xff00D492),
                  size: 19,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .035),
                Text(
                  translate("Productivity"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025),
          GestureDetector(
            onTap: routeToQuotes,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.quora,
                  color: Color(0xff00D492),
                  size: 19,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .035),
                Text(
                  translate("Quotes"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025),
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: CommunityChallenges(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                settings: const RouteSettings(),
              );
            },
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.userSecret,
                  color: Color(0xff00D492),
                  size: 19,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .035),
                Text(
                  "Community Challenges",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025),
          GestureDetector(
            onTap: routeToNotifications,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.tags,
                  color: Color(0xff00D492),
                  size: 19,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .035),
                Text(
                  translate("Notifications"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025),
          GestureDetector(
            onTap: routeToPricing,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.tags,
                  color: Color(0xff00D492),
                  size: 19,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .035),
                Text(
                  translate("Pricing"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .025),
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: Seetingpage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                settings: const RouteSettings(),
              );
            },
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.cog,
                  color: Color(0xff00D492),
                  size: 19,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .035),
                Text(
                  translate("Setting"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * .04),

          /* Row(
            children: [
              FaIcon(
                FontAwesomeIcons.streetView,
                color: Color(0xff00D492),size: 19
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .035),
              Text(
                "Profile ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ), */
          SizedBox(height: MediaQuery.of(context).size.height * .09),
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: Profile(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                settings: const RouteSettings(),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .025,
                vertical: MediaQuery.of(context).size.height * .01,
              ),
              height: MediaQuery.of(context).size.height * .11,
              width: MediaQuery.of(context).size.width * .65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.userCircle, size: 35),
                  SizedBox(width: MediaQuery.of(context).size.width * .035),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: userInfo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data?['name'] ?? '',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          } else {
                            if (snapshot.hasError) {
                              return Text(
                                'Hello',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            } else {
                              return Text(
                                '',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      FutureBuilder(future: completionPercentage, builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LinearPercentIndicator(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .335,
                                  animation: true,
                                  padding: EdgeInsets.all(0),
                                  lineHeight: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .0065,
                                  animationDuration: 2500,
                                  percent: snapshot.data!,
                                  linearStrokeCap: LinearStrokeCap.round,
                                  progressColor: Color(0xff009966),
                                ),

                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .0015,
                                ),
                                Text(
                                  "${snapshot.data! * 100}% Completed ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ]);
                        } else {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LinearPercentIndicator(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .335,
                                  animation: true,
                                  padding: EdgeInsets.all(0),
                                  lineHeight: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .0065,
                                  animationDuration: 2500,
                                  percent: 0,
                                  linearStrokeCap: LinearStrokeCap.round,
                                  progressColor: Color(0xff009966),
                                ),

                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .0015,
                                ),
                                Text(
                                  "0% Completed",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ]);
                        }
                      })
                    ],
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width * .055),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 20,
                    color: Color(0xff009966),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * .015),
          Center(
            child: Text(
              "V1.VitaBoardVer 2023.34-03 ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
