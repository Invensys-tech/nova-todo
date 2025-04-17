import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/common/Expenses.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/repositories/expense.repository.dart';
import 'package:intl/intl.dart';

class AnalyticsView extends StatefulWidget {
  final Datamanager datamanager;

  const AnalyticsView({super.key, required this.datamanager});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  int _expandedIndex = 0;
  late Future<List<Expense>> _expensesFuture;

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Widget Importance(String type, double amount) {
    Color color;
    switch (type) {
      case 'Must':
        color = Colors.green;
        break;
      case 'Maybe':
        color = Colors.orange;
        break;
      case 'Unwanted':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.035,
            vertical: MediaQuery.of(context).size.height * 0.0125,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Icon(Icons.circle_rounded, size: 17, color: color),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  "$type",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                "\$ ${amount.toStringAsFixed(2)} ETB",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Future<Map<String, int>> getExpenseCategoryBreakdown() async {
    try {
      final expenses = await ExpenseRepository().fetchAll();
      // Group and count expenses by category
      final Map<String, int> categoryCounts = {};
      for (var expense in expenses) {
        final cat = expense.category ?? "Unknown";
        if (categoryCounts.containsKey(cat)) {
          categoryCounts[cat] = categoryCounts[cat]! + 1;
        } else {
          categoryCounts[cat] = 1;
        }
      }
      return categoryCounts;
    } catch (e) {
      throw Exception('Failed to fetch expense categories: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Set default dates:
    final today = DateTime.now();
    final threeMonthsAgo = DateTime(today.year, today.month - 3, today.day);
    _endDateController.text = formatDate(today);
    _startDateController.text = formatDate(threeMonthsAgo);
    _refreshExpenses();
  }

  void _refreshExpenses() {
    // Parse the dates from the controllers:
    final startDate = DateTime.tryParse(_startDateController.text);
    final endDate = DateTime.tryParse(_endDateController.text);

    if (startDate != null && endDate != null) {
      _expensesFuture = widget.datamanager.getExpense(dateTime: startDate);
    } else {
      _expensesFuture = widget.datamanager.getExpense();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: FaIcon(FontAwesomeIcons.chevronLeft,color: Color(0xff006045),)
        ),
        title: const Text(
          "Analytics",
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.035,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05, vertical: MediaQuery.of(context).size.height*.01),
               width: MediaQuery.of(context).size.width*.93,
               height: MediaQuery.of(context).size.height*.1,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("From"),
                          SizedBox(height: MediaQuery.of(context).size.height*.0025,),
                          Container(
                            height: MediaQuery.of(context).size.height*.045,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark
                            ),
                            child: DateSelector(
                              hintText: "Start Date",
                              controller: _startDateController,
                              icon: Icons.calendar_today,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.015),
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.0075,),
                      width: MediaQuery.of(context).size.width*.25,
                      child:   DottedLine(
                        dashLength: 5,
                        dashColor: Color(0xff009966),
                        dashGapLength: 3,
                        lineThickness: 5,
                        dashRadius: 16,
                      ),
                    ),
                    Expanded(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("To"),
                          SizedBox(height: MediaQuery.of(context).size.height*.0025,),
                          Container(
                            height: MediaQuery.of(context).size.height*.045,
                            child: DateSelector(
                              hintText: "Start Date",
                              controller: _startDateController,
                              icon: Icons.calendar_today,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              ExpansionPanelList(
                materialGapSize: MediaQuery.of(context).size.width * 0.01,
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    panelIndex == _expandedIndex
                        ? _expandedIndex = -1
                        : _expandedIndex = panelIndex;
                  });
                },
                children: [
                  // ------------------------------
                  // Panel 0: Importance of Expense (Totals & Breakdown)
                  // ------------------------------
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return MyExpansionPanelHeader(
                        title: "Importance of Expense",
                      );
                    },
                    canTapOnHeader: true,
                    backgroundColor: Theme.of(context).primaryColorDark,
                    body: FutureBuilder<Map<String, dynamic>>(
                      future: ExpenseRepository().getExpenseTypeTotals(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text(
                            "Error: ${snapshot.error}",
                            style: const TextStyle(color: Colors.white),
                          );
                        }
                        final totalsData = snapshot.data!;
                        final totalExpense = totalsData["total"] as double;
                        final Map<String, double> typeTotals =
                            Map<String, double>.from(totalsData["type"]);
                        return Column(
                          children: [
                            // Grand Total Header Row
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.035,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.0125,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                  const Icon(
                                    Icons.circle_rounded,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      "Total Expense",
                                      style:TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$ ${totalExpense.toStringAsFixed(2)} ETB",
                                    style:TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Importance rows for each type:
                            Importance("Must", typeTotals["Must"] ?? 0.0),
                            Importance("Maybe", typeTotals["Maybe"] ?? 0.0),
                            Importance(
                              "Unwanted",
                              typeTotals["Unwanted"] ?? 0.0,
                            ),
                          ],
                        );
                      },
                    ),
                    isExpanded: _expandedIndex == 0,
                  ),
                  // ------------------------------
                  // Panel 1: Category of Expense
                  // ------------------------------
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return MyExpansionPanelHeader(
                        title: "Category of Expense",
                      );
                    },
                    canTapOnHeader: true,
                    body: FutureBuilder<Map<String, Map<String, dynamic>>>(
                      future: ExpenseRepository().getExpenseCategoryTotals(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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
                              categoryData.entries.map((entry) {
                                return ExpensesWidget(
                                  category: entry.key,
                                  expenseCount: entry.value['count'] ?? 0,
                                  amount: entry.value['totalAmount'] ?? 0.0,
                                );
                              }).toList(),
                        );
                      },
                    ),
                    isExpanded: _expandedIndex == 1,
                  ),

                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return MyExpansionPanelHeader(title: "List of Expense");
                    },
                    canTapOnHeader: true,
                    body: FutureBuilder<List<Expense>>(
                      future: _expensesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text(
                            "Error: ${snapshot.error}",
                          );
                        }
                        final expenses = snapshot.data!;
                        return Column(
                          children:
                              expenses.map((expense) {
                                return ExpenseList(
                                  typeofexpenses: expense.type ?? "Unknown",
                                  titleofExpenses:
                                      expense.expenseName ?? "Unknown",
                                  catagoryofexpenses:
                                      expense.category ?? "Unknown",
                                  amountofexpenses: expense.amount ?? 0.0,
                                );
                              }).toList(),
                        );
                      },
                    ),
                    isExpanded: _expandedIndex == 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseList extends StatelessWidget {
  final String typeofexpenses;
  final String titleofExpenses;
  final catagoryofexpenses;
  final num amountofexpenses;

  const ExpenseList({
    super.key,
    required this.amountofexpenses,
    required this.catagoryofexpenses,
    required this.titleofExpenses,
    required this.typeofexpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .035,
            right: MediaQuery.of(context).size.width * .035,
            top: MediaQuery.of(context).size.height * .0125,
            bottom: MediaQuery.of(context).size.height * .0125,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * .025),
              typeofexpenses == "Must Expenses"
                  ? const Icon(
                    Icons.circle_rounded,
                    size: 17,
                    color: Colors.green,
                  )
                  : typeofexpenses == "MayBe Expenses"
                  ? const Icon(
                    Icons.circle_rounded,
                    size: 17,
                    color: Colors.orange,
                  )
                  : const Icon(
                    Icons.circle_rounded,
                    size: 17,
                    color: Colors.red,
                  ),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
              Container(
                width: MediaQuery.of(context).size.width * .55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleofExpenses,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .005),
                    Text(
                      catagoryofexpenses,
                      style: GoogleFonts.lato(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$ ${amountofexpenses}ETB",
                style: GoogleFonts.lato(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
