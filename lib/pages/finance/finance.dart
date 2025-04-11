import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Drawer/SeetingPage.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/expenses/ExpnesePgae.dart';
import 'package:flutter_application_1/pages/finance/analytics/analytics.dart';
import 'package:flutter_application_1/pages/finance/bank/bank.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/finance/expense/expense.dart';
import 'package:flutter_application_1/pages/finance/loan/addloan.dart';
import 'package:flutter_application_1/pages/finance/loan/loanpage.dart';

class FinanceUi extends StatelessWidget {
  final Datamanager datamanager;
  const FinanceUi({super.key, required this.datamanager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .0575,
        ),
        color:  isDark ? Colors.black:Color(0xffE1E1E1),
        child: ContainedTabBarView(
          tabs: [
            Tab(text: "Expense"),
            Tab(text: "Income"),
            Tab(text: "Banks"),
            Tab(text: "Loans"),
            Tab(text: "Analytics"),
          ],
          tabBarProperties: TabBarProperties(
            width: MediaQuery.of(context).size.width,
            height: 32,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .035,
            ),
            background: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.black:Color(0xffE1E1E1),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black:Color(0xffE1E1E1),
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: Offset(1, -1),
                  ),
                ],
              ),
            ),
            position: TabBarPosition.top,
            alignment: TabBarAlignment.start,
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16),
            unselectedLabelColor:  !isDark ? Colors.black:Color(0xffE1E1E1),
            unselectedLabelStyle: TextStyle(fontSize: 13),
          ),
          views: [
            Expensespage(datamanager: datamanager),
            Center(child: Text(" Savings Page")),
            BankPage(datamanager: datamanager),
            Loanpage(datamanager: datamanager),
            AnalyticsPage(),
          ],
        ),
      ),
    );
  }
}


/* */