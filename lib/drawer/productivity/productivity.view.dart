import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/productivity/dailyprogress.dart';
import 'package:flutter_application_1/drawer/productivity/generalprogress.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductivityViewPgae extends StatefulWidget {
  final int id;
  const ProductivityViewPgae({super.key, required this.id});

  @override
  State<ProductivityViewPgae> createState() => _ProductivityViewPgaeState();
}

class _ProductivityViewPgaeState extends State<ProductivityViewPgae> {
  late Future<Productivity> _productivityFuture;
  @override
  void initState() {
    super.initState();
    _productivityFuture = ProductivityRepository().fetchView(widget.id!);
    print(_productivityFuture);
  }

  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    print("Current Route: $currentRoute");
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(translate("Productivity View")),
            SizedBox(width: MediaQuery.of(context).size.width*.015,),
            // Container(
            //     height: MediaQuery.of(context).size.height*.03,
            //     width: MediaQuery.of(context).size.width*.06,
            //     child: Image.asset('assets/Gif/Quotes.gif'))

          ],
        ),

        // centerTitle: true,
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:  FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.green),
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .875,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .0175,
            ),
            child: ContainedTabBarView(
              tabs: [
                Tab(text: translate("Daily Progress")),
                Tab(text: translate("General Progress")),
              ],
              tabBarProperties: TabBarProperties(
                width: MediaQuery.of(context).size.width,
                height: 32,
                isScrollable: false,
                labelPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .035,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),

                  ),
                ),
                position: TabBarPosition.top,
                alignment: TabBarAlignment.start,
                labelColor: Color(0xff11853F),
                indicatorColor: Color(0xff11853F),
                labelStyle: TextStyle(fontSize: 16),
                unselectedLabelColor: Colors.grey[400],
                unselectedLabelStyle: TextStyle(fontSize: 13),
              ),
              views: [
                DailyprogressLists(productivityFuture: _productivityFuture),
                Generalprogress(productivityFuture: _productivityFuture),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
