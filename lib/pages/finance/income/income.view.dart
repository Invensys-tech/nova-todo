import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/drawer/Seeting%20Page/SeetingPage.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/income/SingleIncomeFullViewPage.dart';
import 'package:flutter_application_1/pages/finance/income/form.income.dart';
import 'package:flutter_application_1/pages/finance/income/edit.income.dart';
import 'package:flutter_application_1/repositories/income.repository.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class IncomeView extends StatefulWidget {
  final Datamanager datamanager;
  const IncomeView({super.key, required this.datamanager});

  @override
  State<IncomeView> createState() => _IncomeViewState();
}

class _IncomeViewState extends State<IncomeView> {
  ETDateTime noww = ETDateTime.now();
  late Future<List<Income>> _incomeList;
  final DateTime _today = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  final HiveService _hiveService = HiveService();
  String _dateType = 'Gregorian';

  @override
  void initState() {
    super.initState();
    _loadIncomes();
    checkDate();
    //initAll();
  }

  checkDate() {
    if (eth == true) {
      setState(() {
        _selectedDate = noww;
      });
    }
  }

  Future<void> initAll() async {
    await _hiveService.initHive(boxName: 'dateTime');
    final stored = await _hiveService.getData('dateType');
    setState(() {
      _dateType = stored == 'Ethiopian' ? 'Ethiopian' : 'Gregorian';
      if (stored == "Ethiopian") {
        setState(() {
          _selectedDate = noww;
        });
      }
    });
  }

  void _loadIncomes() {
    if (_selectedDate != null) {
      _incomeList = IncomeRepository().getIncome(_selectedDate);
    } else {
      _incomeList = IncomeRepository().getIncome(null);
    }
  }

  void _onDateSelected(DateTime date) {
    print("What is this hit");
    print(date);
    setState(() {
      _selectedDate = date;
    });
    _loadIncomes();
  }

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
            screen: IncomeForm(datamanager: widget.datamanager),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
            settings: const RouteSettings(),
          ).then((_) => setState(_loadIncomes));
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .015),
            CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime(2000, 1, 1),
              lastDate: DateTime(2027, 11, 20),
              onDateSelected: _onDateSelected,
              leftMargin: 20,
              showYears: false,
              monthColor: Colors.blueGrey,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Theme.of(context).disabledColor,
              shrink: true,

              locale: 'en_ISO',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .025),

            FutureBuilder<List<Income>>(
              future: _incomeList,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final incomes = snapshot.data!;
                // **calculate the total here**
                final num total = incomes.fold<num>(
                  0,
                  (sum, inc) => sum + inc.amount,
                );

                return Column(
                  children: [
                    // ——— Top summary card with dynamic total ———
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .02,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .0075,
                        ),
                        height: MediaQuery.of(context).size.height * .075,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .015,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .22,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.trending_up_outlined,
                                    color: Color(0xff0d805e),
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        .035,
                                  ),
                                  Text(
                                    "\$ ${total.toStringAsFixed(2)} ETB",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * .025),

                    // ——— List of incomes ———
                    Column(
                      children:
                          incomes.map((inc) => _buildIncomeItem(inc)).toList(),
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

  /// your existing row widget for each income
  Widget _buildIncomeItem(Income income) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              PageRouteBuilder(
                opaque: false,
                barrierColor: Colors.black.withOpacity(0.5), // background dim
                pageBuilder:
                    (_, __, ___) => SingleIcomeFullViewPage(
                      amount: income.amount,
                      category: income.category,
                      date: income.date,
                      incomename: income.name,
                      paidBy: income.paidBy,
                      notes: income.description,
                    ),
              ),
            );
          },
          child: Slidable(
            key: ValueKey(income.id),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                Column(
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                  'Are you sure you want to delete this income?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await IncomeRepository().deleteIncome(
                                        income.id,
                                      );
                                      Navigator.of(context).pop();
                                      setState(_loadIncomes);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => EditIncome(
                              datamanager: widget.datamanager,
                              incomeId: income.id,
                            ),
                      ),
                    ).then((_) => setState(_loadIncomes));
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .0125,
                    horizontal: MediaQuery.of(context).size.width * .035,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.circle_rounded,
                        size: 17,
                        color: Colors.green,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * .05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              income.name,
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .005,
                            ),
                            Text(
                              income.category,
                              style: GoogleFonts.lato(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$ ${income.amount.toStringAsFixed(2)} ETB",
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const Divider(),
      ],
    );
  }
}
