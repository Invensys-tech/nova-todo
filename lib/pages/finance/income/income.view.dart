import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/finance/income/edit.income.dart';
import 'package:flutter_application_1/pages/finance/income/form.income.dart';
import 'package:flutter_application_1/repositories/income.repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeView extends StatefulWidget {
  final Datamanager datamanager;
  const IncomeView({super.key, required this.datamanager});

  @override
  State<IncomeView> createState() => _IncomeViewState();
}

class _IncomeViewState extends State<IncomeView> {
  ETDateTime noww = ETDateTime.now();
  late Future<List<Income>> _incomeList;
  @override
  Widget IncomeList(Income income) {
    return Slidable(
      key: ValueKey(income.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // Left slide (Delete)
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text(
                      'Are you sure you want to delete this income?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cancel
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await IncomeRepository().deleteIncome(income.id);
                            Navigator.of(context).pop(); // Close dialog
                            setState(() {
                              _incomeList = IncomeRepository().getIncome();
                            });
                          } catch (e) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")),
                            );
                          }
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
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
          // Right slide (Edit)
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => EditIncome(
                        datamanager: widget.datamanager,
                        incomeId: income.id,
                      ),
                ),
              ).then((value) {
                setState(() {
                  _incomeList = IncomeRepository().getIncome();
                });
              });
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
                const Icon(Icons.circle_rounded, size: 17, color: Colors.green),
                SizedBox(width: MediaQuery.of(context).size.width * .05),
                Container(
                  width: MediaQuery.of(context).size.width * .55,
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
                  "\$ ${income.amount} ETB",
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
      ),
    );
  }

  void initState() {
    super.initState();
    _incomeList = IncomeRepository().getIncome();

    _incomeList
        .then((incomes) {
          print("Income List: ${incomes.map((income) => income.toJson())}");
        })
        .catchError((error) {
          print("Error fetching income: $error");
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
        ),
        onPressed: () {
          // Action when pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IncomeForm(datamanager: widget.datamanager),
            ), // Navigate to NewScreen
          );
          print('Floating Action Button Pressed');
        },
        child: Icon(Icons.add), // The icon inside the button
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .015),
            CalendarTimeline(
              initialDate: ETDateTime.now(),
              firstDate: noww,
              lastDate: DateTime(2027, 11, 20),
              onDateSelected: (date) {
                print(ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(noww));
              },
        
              leftMargin: 20,
              showYears: false,
              monthColor: Colors.blueGrey,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.grey,
              shrink: true,
              locale: 'en_ISO',
            ),
        
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .02,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .0,
                      bottom: MediaQuery.of(context).size.height * .015,
                    ),
                    height: MediaQuery.of(context).size.height * .1175,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -78,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.width * .25,
                            decoration: const BoxDecoration(),
                          ),
                        ),
        
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .015,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .22,
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
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
                                      "\$ 15,000 ETB",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: Colors.white70),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .005,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .0155,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .275,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .do_not_disturb_on_total_silence_outlined,
                                        size: 15,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            .015,
                                      ),
                                      Text(
                                        "\$ 45,000",
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
        
                                Container(
                                  width: MediaQuery.of(context).size.width * .275,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .do_not_disturb_on_total_silence_outlined,
                                        size: 15,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            .015,
                                      ),
                                      Text(
                                        "\$ 35,000",
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          color: Colors.deepOrangeAccent,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
        
                                Container(
                                  width: MediaQuery.of(context).size.width * .275,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .do_not_disturb_on_total_silence_outlined,
                                        size: 15,
                                        color: Color(0xff0d805e),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            .015,
                                      ),
                                      Text(
                                        "\$ 17,500",
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          color: Color(0xff0d805e),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .025),
              ],
            ),
        
            FutureBuilder(
              future: _incomeList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return Column(
                    children: data!.map((e) => IncomeList(e)).toList(),
                  );
                } else {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
