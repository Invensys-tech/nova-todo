import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/analytics/analytics.view.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/finance/expense/editexpense.dart';
import 'package:flutter_application_1/pages/finance/expenses/SingleExpensesViewPage.dart';
import 'package:flutter_application_1/repositories/expense.repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Expensespage extends StatefulWidget {
  final Datamanager datamanager;
  const Expensespage({Key? key, required this.datamanager}) : super(key: key);

  @override
  State<Expensespage> createState() => _ExpensespageState();
}

class _ExpensespageState extends State<Expensespage> {
  // Use ETDateTime only to seed today, but store selections as DateTime
  final DateTime _today = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  late Future<List<Expense>> _expensesFuture;
  final ExpenseRepository _expenseRepository = ExpenseRepository();

  // Totals
  num _mustTotal = 0, _maybeTotal = 0, _unwantedTotal = 0, _grandTotal = 0;

  @override
  void initState() {
    super.initState();
    _loadExpenses(); // initial load (no date filter = all)
  }

  void _loadExpenses() {
    _expensesFuture = widget.datamanager
        .getExpense(dateTime: _selectedDate)
        .then((list) {
          // compute your category sums
          _mustTotal = list
              .where((e) => e.type == "Must")
              .fold<num>(0, (s, e) => s + e.amount);
          _maybeTotal = list
              .where((e) => e.type == "Maybe")
              .fold<num>(0, (s, e) => s + e.amount);
          _unwantedTotal = list
              .where((e) => e.type == "Unwanted")
              .fold<num>(0, (s, e) => s + e.amount);
          _grandTotal = _mustTotal + _maybeTotal + _unwantedTotal;
          return list;
        });
  }

  void _onDateSelected(DateTime date) {
    // send into Datamanager and reload
    setState(() {
      _selectedDate = date;
      _loadExpenses();
    });
  }
  ETDateTime now = ETDateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff009966),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {


          PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
            context,
            screen: AddExpense(datamanager: widget.datamanager),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino, settings: const RouteSettings(),
          ).then((_) => setState(_loadExpenses));
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // ─── CalendarTimeline ───
            CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime(2000, 11, 20),
              lastDate: DateTime(2027, 11, 20),
              onDateSelected: _onDateSelected,
              leftMargin: 20,
              showYears: false,
              monthColor: Colors.blueGrey,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Theme.of(context).disabledColor,
              shrink: true,
              locale: 'am',
            ),

            const SizedBox(height: 24),

            // ─── Summary + List ───
            FutureBuilder<List<Expense>>(
              future: _expensesFuture,
              builder: (context, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('Error: ${snap.error}'));
                }
                final expenses = snap.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // — Summary Card —
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width*.25,),
                                const Icon(
                                  Icons.trending_up_outlined,
                                  color: Color(0xff0d805e),
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "\$ ${_grandTotal.toStringAsFixed(2)} ETB",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildCategorySummary(Colors.green, _mustTotal),
                                _buildCategorySummary(
                                  Colors.orange,
                                  _maybeTotal,
                                ),
                                _buildCategorySummary(
                                  Colors.red,
                                  _unwantedTotal,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.05, top: MediaQuery.of(context).size.height*.045),
                      child: Text("Transaction List",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    ),

                    // — Expense List —
                    ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: expenses.length,
                      itemBuilder: (ctx, i) {
                        final e = expenses[i];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.of(context).push(PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return SingleEpensesFullViewPage(

                                      );
                                    }
                                ));
                              },
                              child: Slidable(
                                key: ValueKey(e.id),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        _expenseRepository.deleteExpense(e.id);
                                        setState(_loadExpenses);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => EditExpense(
                                                  datamanager: widget.datamanager,
                                                  expenseId: e.id,
                                                ),
                                          ),
                                        ).then((_) => setState(_loadExpenses));
                                      },
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                                child: ExpenseList(
                                  amountofexpenses: e.amount,
                                  catagoryofexpenses: e.category,
                                  titleofExpenses: e.category,
                                  typeofexpenses: e.type,
                                ),
                              ),
                            ),

                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySummary(Color color, num amount) => Row(
    children: [
      Icon(Icons.circle, size: 14, color: color),
      const SizedBox(width: 4),
      Text(
        "\$ ${amount.toStringAsFixed(2)}",
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    ],
  );
}
