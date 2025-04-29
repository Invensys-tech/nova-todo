import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/expenses/ExpnesePgae.dart';
import 'package:flutter_application_1/pages/finance/analytics/analytics.dart';
import 'package:flutter_application_1/pages/finance/bank/bank.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/finance/expense/expense.dart';
import 'package:flutter_application_1/pages/finance/income/income.view.dart';
import 'package:flutter_application_1/pages/finance/loan/addloan.dart';
import 'package:flutter_application_1/pages/finance/loan/loanpage.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../drawer/Seeting Page/SeetingPage.dart';
import '../../main.dart';

class FinanceUi extends StatelessWidget {
  final Datamanager datamanager;
  const FinanceUi({super.key, required this.datamanager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .0),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .0575,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ContainedTabBarView(
            tabs: [
              Tab(text: translate("Expense")),
              Tab(text: translate("Income")),
              Tab(text: translate("Banks")),
              Tab(text: translate("Loans")),
              Tab(text: translate("Analytics")),
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
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),

                ),
              ),
              position: TabBarPosition.top,
              alignment: TabBarAlignment.start,
              indicatorColor: Colors.transparent,
              labelStyle: TextStyle(fontSize: 16),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(fontSize: 13),
            ),
            views: [
              Expensespage(datamanager: datamanager),
              IncomeView(datamanager: datamanager),
              // Center(child: Text(" Savings Page")),
              BankPage(datamanager: datamanager),
              Loanpage(datamanager: datamanager),
              AnalyticsPage(datamanager: datamanager),
            ],
          ),
        ),
      ),
    );
  }
}


/* */