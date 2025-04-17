// import 'package:calendar_timeline/calendar_timeline.dart';
// import 'package:ethiopian_datetime/ethiopian_datetime.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/datamanager.dart';
// import 'package:flutter_application_1/datamodel.dart';
// import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Expensespage extends StatefulWidget {
//   final Datamanager datamanager;
//   const Expensespage({super.key, required this.datamanager});

//   @override
//   State<Expensespage> createState() => _ExpensespageState();
// }

// class _ExpensespageState extends State<Expensespage> {
//   ETDateTime noww = ETDateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         foregroundColor: Colors.white,
//         backgroundColor: Color(0xFF2b2d30),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50), // Rounded corners
//         ),
//         onPressed: () {
//           // Action when pressed
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddExpense(datamanager: widget.datamanager),
//             ), // Navigate to NewScreen
//           );
//           print('Floating Action Button Pressed');
//         },
//         child: Icon(Icons.add), // The icon inside the button
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: MediaQuery.of(context).size.height * .015),
//           CalendarTimeline(
//             initialDate: ETDateTime.now(),
//             firstDate: noww,
//             lastDate: DateTime(2027, 11, 20),
//             onDateSelected: (date) {
//               print(ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(noww));
//             },

//             leftMargin: 20,
//             showYears: false,
//             monthColor: Colors.blueGrey,
//             dayColor: Colors.teal[200],
//             activeDayColor: Colors.white,
//             activeBackgroundDayColor: Colors.grey,
//             shrink: true,
//             locale: 'en_ISO',
//           ),

//           SizedBox(height: MediaQuery.of(context).size.height * .025),
//           Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: MediaQuery.of(context).size.width * .02,
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.only(
//                     left: MediaQuery.of(context).size.width * .0,
//                     bottom: MediaQuery.of(context).size.height * .015,
//                   ),
//                   height: MediaQuery.of(context).size.height * .1175,
//                   width: MediaQuery.of(context).size.width * .9,
//                   decoration: BoxDecoration(
//                     color: Colors.black38,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         right: -78,
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * .07,
//                           width: MediaQuery.of(context).size.width * .25,
//                           decoration: const BoxDecoration(),
//                         ),
//                       ),

//                       Column(
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .015,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: MediaQuery.of(context).size.width * .22,
//                             ),
//                             child: Center(
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.trending_up_outlined,
//                                     color: Color(0xff0d805e),
//                                     size: 25,
//                                   ),
//                                   SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width *
//                                         .035,
//                                   ),
//                                   Text(
//                                     "\$ 15,000 ETB",
//                                     style: GoogleFonts.lato(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Divider(color: Colors.white70),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .005,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * .0155,
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width * .275,
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons
//                                           .do_not_disturb_on_total_silence_outlined,
//                                       size: 15,
//                                       color: Colors.red,
//                                     ),
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           .015,
//                                     ),
//                                     Text(
//                                       "\$ 45,000",
//                                       style: GoogleFonts.lato(
//                                         fontSize: 13,
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               Container(
//                                 width: MediaQuery.of(context).size.width * .275,
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons
//                                           .do_not_disturb_on_total_silence_outlined,
//                                       size: 15,
//                                       color: Colors.deepOrangeAccent,
//                                     ),
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           .015,
//                                     ),
//                                     Text(
//                                       "\$ 35,000",
//                                       style: GoogleFonts.lato(
//                                         fontSize: 13,
//                                         color: Colors.deepOrangeAccent,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               Container(
//                                 width: MediaQuery.of(context).size.width * .275,
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons
//                                           .do_not_disturb_on_total_silence_outlined,
//                                       size: 15,
//                                       color: Color(0xff0d805e),
//                                     ),
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           .015,
//                                     ),
//                                     Text(
//                                       "\$ 17,500",
//                                       style: GoogleFonts.lato(
//                                         fontSize: 13,
//                                         color: Color(0xff0d805e),
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * .025),
//             ],
//           ),
//           FutureBuilder(
//             future: Datamanager().getExpense(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 var expenses = snapshot.data as List<Expense>;

//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: expenses.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           // SizedBox(
//                           //   height: MediaQuery.of(context).size.height * 0.09,
//                           // ),
//                           ExpenseList(
//                             amountofexpenses: expenses[index].amount,
//                             catagoryofexpenses: expenses[index].category,
//                             titleofExpenses: expenses[index].category,
//                             typeofexpenses: expenses[index].type,
//                           ),
//                           // SizedBox(
//                           //   height: MediaQuery.of(context).size.height * 0.09,
//                           // ),
//                         ],
//                       );
//                     },
//                   ),
//                 );
//               } else {
//                 if (snapshot.hasError) {
//                   print(snapshot.error);
//                   return Text(
//                     "There was an error fetching data ${snapshot.error}",
//                   );
//                 } else {
//                   return const CircularProgressIndicator();
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ExpenseList extends StatelessWidget {
//   final String typeofexpenses;
//   final String titleofExpenses;
//   final catagoryofexpenses;
//   final num amountofexpenses;

//   const ExpenseList({
//     super.key,
//     required this.amountofexpenses,
//     required this.catagoryofexpenses,
//     required this.titleofExpenses,
//     required this.typeofexpenses,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.width * .035,
//                 right: MediaQuery.of(context).size.width * .035,
//                 top: MediaQuery.of(context).size.height * .0125,
//                 bottom: MediaQuery.of(context).size.height * .0125,
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(width: MediaQuery.of(context).size.width * .025),
//                   typeofexpenses == "Must Expenses"
//                       ? Icon(
//                         Icons.circle_rounded,
//                         size: 17,
//                         color: Colors.green,
//                       )
//                       : typeofexpenses == "MayBe Expenses"
//                       ? Icon(
//                         Icons.circle_rounded,
//                         size: 17,
//                         color: Colors.orange,
//                       )
//                       : Icon(Icons.circle_rounded, size: 17, color: Colors.red),
//                   SizedBox(width: MediaQuery.of(context).size.width * .05),
//                   Container(
//                     width: MediaQuery.of(context).size.width * .55,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           titleofExpenses,
//                           style: GoogleFonts.lato(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * .005,
//                         ),
//                         Text(
//                           catagoryofexpenses,
//                           style: GoogleFonts.lato(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Text(
//                     "\$ ${amountofexpenses}ETB",
//                     style: GoogleFonts.lato(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Divider(),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/finance/expense/editexpense.dart';
import 'package:flutter_application_1/pages/finance/expenses/SingleExpensesViewPage.dart';
import 'package:flutter_application_1/repositories/expense.repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Expensespage extends StatefulWidget {
  final Datamanager datamanager;
  const Expensespage({super.key, required this.datamanager});

  @override
  State<Expensespage> createState() => _ExpensespageState();
}

class _ExpensespageState extends State<Expensespage> {
  ETDateTime noww = ETDateTime.now();
  late Future<List<Expense>> _expensesFuture;

  final ExpenseRepository _expenseRepository = ExpenseRepository();

  @override
  void initState() {
    super.initState();
    _refreshExpenses();
  }

  void _refreshExpenses() {
    _expensesFuture = widget.datamanager.getExpense();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff009966),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpense(datamanager: widget.datamanager),
            ),
          ).then((_) {
            setState(() {
              widget.datamanager.getExpense();
            });
          });
          print('Floating Action Button Pressed');
        },
        child: const Icon(Icons.add),
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
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -78,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.width * .25,
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
                                      "\$ 15,000 ETB",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
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
                                      const Icon(
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
                                        style: TextStyle(
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
                                      const Icon(
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
                                        style: TextStyle(
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
                                      const Icon(
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
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: const Color(0xff0d805e),
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
              future: _expensesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var expenses = snapshot.data as List<Expense>;
                  return Container(
                    height: expenses.length * MediaQuery.of(context).size.height*.2,
                    child: ListView.builder(
                      itemCount: expenses.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final expense = expenses[index];
                        // Inside your ListView.builder in the FutureBuilder:
                        return GestureDetector(
                          onTap: (){
                           /* Navigator.of(context).push(PageRouteBuilder(
                              fullscreenDialog: true,
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return SingleEpensesFullViewPage(

                                  );
                                }
                            )); */

                            Navigator.of(context, rootNavigator: true).push(
                              PageRouteBuilder(
                                opaque: false,
                                barrierColor: Colors.black.withOpacity(0.5), // optional background blur
                                pageBuilder: (BuildContext context, _, __) {
                                  return SingleEpensesFullViewPage();
                                },
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Slidable(
                                key: ValueKey(expense.id),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [

                                   SlidableAction(
                                      onPressed: (context) {
                                        // Show a confirmation dialog before deleting
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Confirm Delete'),
                                              content: const Text(
                                                'Are you sure you want to delete this expense?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(
                                                      context,
                                                    ).pop(); // Dismiss the dialog
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Place your delete logic here
                                                    _expenseRepository.deleteExpense(
                                                      expense.id,
                                                    );
                                                    print(
                                                      'Deleted ${expense.category}',
                                                    );
                                                    Navigator.of(context).pop();
                                                    setState(() {
                                                      _refreshExpenses();
                                                    }); // Dismiss the dialog
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
                                ), // ensure each expense has a unique id or use index
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => EditExpense(
                                                  datamanager:
                                                      widget
                                                          .datamanager, // make sure it's accessible
                                                  expenseId: expense.id,
                                                ),
                                          ),
                                        ).then((_) {
                                          setState(() {
                                            widget.datamanager.getExpense();
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
                                child: ExpenseList(
                                  amountofexpenses: expense.amount,
                                  catagoryofexpenses: expense.category,
                                  titleofExpenses: expense.category,
                                  typeofexpenses: expense.type,
                                ),
                              ),

                              const Divider(),
                            ],
                          ),
                        );
                      },
                    ),
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
          ],
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
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: MediaQuery.of(context).size.width*1,
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
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .005),
                        Text(
                          catagoryofexpenses,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$ ${amountofexpenses}ETB",
                    style: TextStyle(
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
    );
  }
}
