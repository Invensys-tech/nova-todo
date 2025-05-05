import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/finance/analytics/analytics.view.dart';
import 'package:flutter_application_1/pages/finance/common/Expenses.dart';
import 'package:flutter_application_1/pages/finance/common/balance.dart';
import 'package:flutter_application_1/pages/finance/common/bank.dart';
import 'package:flutter_application_1/repositories/expense.repository.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:slider_bar_chart/slider_bar_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnalyticsPage extends StatefulWidget {
  final Datamanager datamanager;
  const AnalyticsPage({super.key, required this.datamanager});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  double _totalBankExpense = 0.0;
  double _totalBankIncome = 0.0;
  late Future<List<Bank>> _banksFuture;

  @override
  void initState() {
    super.initState();
    _banksFuture = Datamanager().getBanks();
  }

  Future<void> _fetchAndComputeBankStats() async {
    // final expenses = await widget.datamanager.fetchExpense();
    final expenses = await Supabase.instance.client
        .from('expense')
        .select('*')
        .eq('userid', userId);

    final incomes = await Supabase.instance.client
        .from('incomes')
        .select('*')
        .eq('user_id', userId);

    final parsedIncomes =
        (incomes as List)
            .map((e) => Income.fromJson(e as Map<String, dynamic>))
            .toList();
    final parsedExpenses =
        (expenses as List)
            .map((e) => Expense.fromJson(e as Map<String, dynamic>))
            .toList();

    setState(() {
      _totalBankExpense = widget.datamanager.totalBankExpense(parsedExpenses);
      _totalBankIncome = widget.datamanager.totalBankIncome(parsedIncomes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add this to ensure proper layout
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics:
              AlwaysScrollableScrollPhysics(), // Add this to enable scrolling even with little content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Move this up from the nested Column
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // Balance container
              FutureBuilder(
                future: _banksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No bank data found.");
                  }
                  List<Bank> banks = snapshot.data!;
                  double totalBalance = banks.fold(
                    0.0,
                    (sum, bank) => sum + bank.balance,
                  );
                  return BankBalance(
                    total: totalBalance,
                    expense: _totalBankExpense,
                    income: _totalBankIncome,
                  );
                },
              ),

              // Income and Expense containers
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              // Add more content to ensure scrolling
              _buildAccountSection(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              _ExpensesCatagorypage(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              // _GraphDesign(), // Add one more to ensure content overflows
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              // Add one more to ensure content overflows
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate("Account"),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              translate("See All"),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .005),
        FutureBuilder(
          future: widget.datamanager.getBanks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var banks = snapshot.data as List<Bank>;
              return ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: banks.length > 3 ? 3 : banks.length,

                itemBuilder: (context, index) {
                  final bank = banks[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BankWidget(
                        id: banks[index].id,
                        accountname: banks[index].accountHolder,
                        accoutnumber: banks[index].accountNumber,
                        balance: banks[index].balance,
                        datamanager: widget.datamanager,
                        bankName: banks[index].accountBank,
                        accountBank: bank.accountBank,
                        branch: bank.branch,
                        balace: bank.balance,
                      ),
                    ],
                  );
                },
              );
            } else {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text(
                  "There was an error fetching data ${snapshot.error}",
                );
              } else {
                return const CircularProgressIndicator();
              }
            }
          },
        ),
        // BankWidget(
        //   accountname: "Jhon",
        //   balance: 787970,
        //   accoutnumber: 4646464,
        //   id: 1,
        // ),
        // BankWidget(
        //   accountname: "Jhon",
        //   balance: 787970,
        //   accoutnumber: 4646464,
        //   id: 1,
        // ),
        // BankWidget(
        //   accountname: "Jhon",
        //   balance: 787970,
        //   accoutnumber: 4646464,
        //   id: 1,
        // ),
      ],
    );
  }

  _ExpensesCatagorypage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate("Expenses Catagory"),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  context,
                  screen: AnalyticsView(datamanager: widget.datamanager),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  settings: const RouteSettings(),
                );
                print("touched");
              },
              child: Container(
                padding: EdgeInsets.all(8), // Give it tappable space
                child: Text(
                  translate("See All"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff009966),
                  ),
                ),
              ),
            ),
          ],
        ),

        Column(
          children: [
            FutureBuilder<Map<String, Map<String, dynamic>>>(
              future: ExpenseRepository().getExpenseCategoryTotals(null, null),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.white),
                  );
                }
                final categoryData = snapshot.data!;
                return Column(
                  children:
                      categoryData.entries.take(3).map((entry) {
                        return ExpensesWidget(
                          category: entry.key,
                          expenseCount: entry.value['count'] ?? 0,
                          amount: entry.value['totalAmount'] ?? 0.0,
                        );
                      }).toList(),
                );
              },
            ),
          ],
        ),

        // ExpensesWidget(expenseCount: 5, category: "Food", amount: 5000),
        // ExpensesWidget(expenseCount: 5, category: "Food", amount: 5000),
        // ExpensesWidget(expenseCount: 5, category: "Food", amount: 5000),
      ],
    );
  }

  _GraphDesign() {
    // return Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           "Most Expenses and profit",
    //           style: TextStyle(
    //             fontWeight: FontWeight.w500,
    //             color: Colors.white70,
    //           ),
    //         ),
    //         Text(
    //           "See All",
    //           style: TextStyle(
    //             fontWeight: FontWeight.w500,
    //             color: Colors.white70,
    //           ),
    //         ),
    //       ],
    //     ),
    //     // Container(
    //     //   height: MediaQuery.of(context).size.height * .35,
    //     //   width: MediaQuery.of(context).size.width,
    //     //   child: chartToRun(),
    //     // ),
    //   ],
    // );
  }

  Widget chartToRun() {
    return SliderBarChartWidget(
      decoration: SbcDecoration(
        height: 300.0,
        showScrollbar: true,
        singleBarPosition: SingleBarPosition.bottom, // Default value
        titleDecoration: SbcTitleDecoration(
          xHeightSpace: 40.0,
          xWidthSpace: 35.0,
          showYTitles: true,
          yTitleTextFormatter: null,
          fixedYTitles: false,
          yTitlePosition: YTitlePosition.both,
        ),
        tooltipDecoration: SbcTooltipDecoration(
          backgroundColor: Colors.red,
          triggerMode: TooltipTriggerMode.tap,
          waitDuration: Duration.zero,
          padding: EdgeInsets.all(15.0),
          yTextFormatter: null,
          y2TextFormatter: null,
          border: null,
          borderRadius: 14,
        ),
        barDecoration: SbcBarDecoration(
          width: 15.0,
          showAsProgress: true,
          yColor: Colors.red,
          y2Color: Colors.green,
        ),
      ),
      data: SbcData(
        xValues: List.generate(10, (index) => index),
        yValues: List.generate(10, (index) => Random().nextDouble() * 256),
      ),
    );
  }
}
