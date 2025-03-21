import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance/Expenses/ExpnesePgae.dart';
import 'package:flutter_application_1/pages/finance/analytics/analytics.dart';
import 'package:flutter_application_1/pages/finance/bank/bank.dart';
import 'package:flutter_application_1/pages/finance/loan/loanpage.dart';

class FinanceUi extends StatelessWidget {
  const FinanceUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.0),
        child: Container(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.0575),
          color: Colors.black,
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
                labelPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035),
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
                indicatorColor: Colors.transparent,
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 16),
                unselectedLabelColor: Colors.grey[400],
                unselectedLabelStyle:TextStyle(fontSize: 13)
            ),
            views: [
              Expensespage(),
              Center(child: Text(" Savings Page")),
              BankPage(),
              Loanpage(),
              AnalyticsPage(),
            ],
          ),
        ),
      ),
    );
  }
}


/* */