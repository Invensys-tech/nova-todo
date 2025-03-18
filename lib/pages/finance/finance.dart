import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance/analytics/analytics.dart';
import 'package:flutter_application_1/pages/finance/bank/bank.dart';
import 'package:flutter_application_1/pages/finance/loan/loanpage.dart';

class FinanceUi extends StatelessWidget {
  const FinanceUi({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          // title: const Text("Finance"),
          leadingWidth: 0,
          centerTitle: false,
          backgroundColor: Colors.black,
          bottom: TabBar(
            isScrollable: true,
            padding: EdgeInsets.all(0),
            indicatorColor: Colors.pink, // Green underline for active tab
            labelColor: Colors.green, // Active tab text color
            unselectedLabelColor: Colors.white, // Inactive tab text color
            tabs: [
              Tab(text: "Analytics"),
              Tab(text: "Expense"),
              Tab(text: "Income"),
              Tab(text: "Banks"),
              Tab(text: "Loans"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(body: AnalyticsPage(), backgroundColor: Color(0xff2F2F2F)),
            Center(child: Text(" Transactions Page")),
            Center(child: Text(" Savings Page")),
            Scaffold(body: BankPage(), backgroundColor: Color(0xff2F2F2F)),
            Scaffold(body: Loanpage(), backgroundColor: Color(0xff2F2F2F)),
          ],
        ),
      ),
    );
  }
}


/* */