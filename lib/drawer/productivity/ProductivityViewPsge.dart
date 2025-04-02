import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/productivity/Dailyprogress.dart';
import 'package:flutter_application_1/drawer/productivity/General%20Progress.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Icon(Icons.arrow_back_sharp, color: Colors.green, size: 25),
        shape: Border(
          bottom: BorderSide(
            color: Colors.white, // Border color
            width: 1, // Border width
          ),
        ),
        title: Text(
          "Title",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        actions: [Row(children: [
          ],
        )],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .89,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .03575,
            ),
            color: Colors.black,
            child: ContainedTabBarView(
              tabs: [
                Tab(text: "Daily Progress"),
                Tab(text: "General Progress"),
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
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: Offset(1, -1),
                      ),
                    ],
                  ),
                ),
                position: TabBarPosition.top,
                alignment: TabBarAlignment.start,
                indicatorColor: Color(0xff11853F),
                labelColor: Colors.white,
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
