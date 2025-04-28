// import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/datamanager.dart';
// import 'package:flutter_application_1/datamodel.dart';
// import 'package:flutter_application_1/pages/finance/common/loan.dart';
// import 'package:flutter_application_1/pages/finance/common/loaninfo.dart';
// import 'package:flutter_application_1/pages/finance/loan/addloan.dart';
// import 'package:flutter_application_1/pages/finance/loan/editloan.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// import '../analytics/analytics.dart';
// import '../bank/bank.dart';
// import '../expenses/ExpnesePgae.dart';
// import '../income/income.view.dart';

// class Loanpage extends StatefulWidget {
//   final Datamanager datamanager;
//   const Loanpage({super.key, required this.datamanager});

//   @override
//   State<Loanpage> createState() => _LoanpageState();
// }

// class _LoanpageState extends State<Loanpage> {
//   late Future<List<Loan>> _loanFuture;

//   @override
//   void initState() {
//     super.initState();
//     _loanFuture = Datamanager().getLoan();
//   }

//   void _refreshLoans() {
//     setState(() {
//       _loanFuture = Datamanager().getLoan();
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final newLoans =
//               await PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//                 context,
//                 screen: AddLoan(),
//                 withNavBar: false,
//                 pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                 settings: const RouteSettings(),
//               );

//           // If new data is returned, update the UI
//           if (newLoans != null) {
//             setState(() {
//               _loanFuture = Future.value(newLoans);
//             });
//           }
//         },
//         backgroundColor: Colors.green,
//         child: Icon(Icons.add, color: Colors.white, size: 30),
//       ),

//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.045,
//         ),
//         child: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               LoanWidget(),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),

//               Container(
//                 height: MediaQuery.of(context).size.height * .7,
//                 child: ContainedTabBarView(
//                   tabs: [
//                     Tab(text: "All Loans"),
//                     Tab(text: "Recivable Loans"),
//                     Tab(text: "Payable Loans"),
//                   ],
//                   tabBarProperties: TabBarProperties(
//                     width: MediaQuery.of(context).size.width,
//                     height: 32,
//                     isScrollable: false,
//                     labelPadding: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width * .035,
//                     ),
//                     background: Container(
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).scaffoldBackgroundColor,
//                         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                       ),
//                     ),
//                     position: TabBarPosition.top,
//                     alignment: TabBarAlignment.start,
//                     indicatorColor: Color(0xff009966),
//                     labelStyle: TextStyle(
//                       fontSize: 16,
//                       color: Color(0xff009966),
//                     ),
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     unselectedLabelColor: Theme.of(context).primaryColorLight,
//                     unselectedLabelStyle: TextStyle(fontSize: 13),
//                   ),
//                   views: [
//                     FutureBuilder(
//                       future: _loanFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           var loans = snapshot.data as List<Loan>;

//                           // Group and aggregate by loanerName
//                           final Map<String, Map<String, dynamic>> grouped = {};

//                           for (var loan in loans) {
//                             final name = loan.loanerName;
//                             final phone = loan.phoneNumber;
//                             final amount =
//                                 loan.type == "Receivable"
//                                     ? loan.amount
//                                     : -loan.amount;

//                             if (grouped.containsKey(name)) {
//                               grouped[name]!['amount'] += amount;
//                             } else {
//                               grouped[name] = {
//                                 'phoneNumber': phone,
//                                 'amount': amount,
//                                 'id': loan.id, // Optional: pick first one
//                               };
//                             }
//                           }

//                           final distinctLoans =
//                               grouped.entries.map((entry) {
//                                 return {
//                                   'name': entry.key,
//                                   'phoneNumber': entry.value['phoneNumber'],
//                                   'amount': entry.value['amount'],
//                                   'id': entry.value['id'],
//                                 };
//                               }).toList();

//                           return ListView.builder(
//                             shrinkWrap: true,
//                             physics: ClampingScrollPhysics(),
//                             itemCount: distinctLoans.length,
//                             itemBuilder: (context, index) {
//                               final loan = distinctLoans[index];
//                               return LoanCard(
//                                 name: loan['name'],
//                                 phoneNumber: loan['phoneNumber'],
//                                 loanAmount: loan['amount'],
//                                 id: loan['id'],
//                                 type: loan['type'],
//                                 datamanager: widget.datamanager,
//                               );
//                             },
//                           );
//                         } else if (snapshot.hasError) {
//                           return Text("Error fetching data: ${snapshot.error}");
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       },
//                     ),
//                     FutureBuilder(
//                       future: _loanFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           var loans = snapshot.data as List<Loan>;

//                           // Group and aggregate by loanerName
//                           final Map<String, Map<String, dynamic>> grouped = {};

//                           for (var loan in loans) {
//                             final name = loan.loanerName;
//                             final phone = loan.phoneNumber;
//                             final amount =
//                                 loan.type == "Receivable"
//                                     ? loan.amount
//                                     : -loan.amount;

//                             if (grouped.containsKey(name)) {
//                               grouped[name]!['amount'] += amount;
//                             } else {
//                               grouped[name] = {
//                                 'phoneNumber': phone,
//                                 'amount': amount,
//                                 'id': loan.id, // Optional: pick first one
//                               };
//                             }
//                           }

//                           final distinctLoans =
//                               grouped.entries.map((entry) {
//                                 return {
//                                   'name': entry.key,
//                                   'phoneNumber': entry.value['phoneNumber'],
//                                   'amount': entry.value['amount'],
//                                   'id': entry.value['id'],
//                                 };
//                               }).toList();

//                           return ListView.builder(
//                             shrinkWrap: true,
//                             physics: ClampingScrollPhysics(),
//                             itemCount: distinctLoans.length,
//                             itemBuilder: (context, index) {
//                               final loan = distinctLoans[index];
//                               return LoanCard(
//                                 name: loan['name'],
//                                 phoneNumber: loan['phoneNumber'],
//                                 loanAmount: loan['amount'],
//                                 id: loan['id'],
//                                 datamanager: widget.datamanager,
//                                 type: loan['type'],
//                               );
//                             },
//                           );
//                         } else if (snapshot.hasError) {
//                           return Text("Error fetching data: ${snapshot.error}");
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       },
//                     ),
//                     FutureBuilder(
//                       future: _loanFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           var loans = snapshot.data as List<Loan>;

//                           // Group and aggregate by loanerName
//                           final Map<String, Map<String, dynamic>> grouped = {};

//                           for (var loan in loans) {
//                             final name = loan.loanerName;
//                             final phone = loan.phoneNumber;
//                             final amount =
//                                 loan.type == "Receivable"
//                                     ? loan.amount
//                                     : -loan.amount;

//                             if (grouped.containsKey(name)) {
//                               grouped[name]!['amount'] += amount;
//                             } else {
//                               grouped[name] = {
//                                 'phoneNumber': phone,
//                                 'amount': amount,
//                                 'id': loan.id, // Optional: pick first one
//                               };
//                             }
//                           }

//                           final distinctLoans =
//                               grouped.entries.map((entry) {
//                                 return {
//                                   'name': entry.key,
//                                   'phoneNumber': entry.value['phoneNumber'],
//                                   'amount': entry.value['amount'],
//                                   'id': entry.value['id'],
//                                 };
//                               }).toList();

//                           return ListView.builder(
//                             shrinkWrap: true,
//                             physics: ClampingScrollPhysics(),
//                             itemCount: distinctLoans.length,
//                             itemBuilder: (context, index) {
//                               final loan = distinctLoans[index];
//                               return LoanCard(
//                                 name: loan['name'],
//                                 phoneNumber: loan['phoneNumber'],
//                                 loanAmount: loan['amount'],
//                                 id: loan['id'],
//                                 type: loan['type'],
//                                 datamanager: widget.datamanager,
//                               );
//                             },
//                           );
//                         } else if (snapshot.hasError) {
//                           return Text("Error fetching data: ${snapshot.error}");
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget AllLoans() {
//     return FutureBuilder(
//       future: _loanFuture,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           var loans = snapshot.data as List<Loan>;
//           return ListView.builder(
//             shrinkWrap: true,
//             physics: ClampingScrollPhysics(),
//             itemCount: loans.length,
//             itemBuilder: (context, index) {
//               final loan = loans[index];

//               return Slidable(
//                 key: ValueKey(loan.id),
//                 startActionPane: ActionPane(
//                   motion: const ScrollMotion(),
//                   children: [
//                     SlidableAction(
//                       onPressed: (context) {
//                         // Show a confirmation dialog before deleting
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Confirm Delete'),
//                               content: const Text(
//                                 'Are you sure you want to delete this Loan?',
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(
//                                       context,
//                                     ).pop(); // Dismiss the dialog
//                                   },
//                                   child: const Text('Cancel'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     // Place your delete logic here
//                                     // _expenseRepository.deleteExpense(
//                                     //   expense.id,
//                                     // );
//                                     print('Deleted ${loan.id}');
//                                     Navigator.of(
//                                       context,
//                                     ).pop(); // Dismiss the dialog
//                                   },
//                                   child: const Text(
//                                     'Delete',
//                                     style: TextStyle(color: Colors.red),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                       icon: Icons.delete,
//                       label: 'Delete',
//                     ),
//                   ],
//                 ),
//                 endActionPane: ActionPane(
//                   motion: const ScrollMotion(),
//                   children: [
//                     SlidableAction(
//                       onPressed: (context) async {
//                         final updatedLoans = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => EditLoan(
//                                   loanId: loan.id,
//                                   datamanager: widget.datamanager,
//                                 ),
//                           ),
//                         );

//                         if (updatedLoans != null) {
//                           setState(() {
//                             _loanFuture = Future.value(updatedLoans);
//                           });
//                         }
//                       },
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                       icon: Icons.edit,
//                       label: 'Edit',
//                     ),
//                   ],
//                 ),
//                 child: LoanCard(
//                   name: loans[index].loanerName,
//                   phoneNumber: loans[index].phoneNumber,
//                   loanAmount: loans[index].amount,
//                   id: loans[index].id,
//                   datamanager: widget.datamanager,
//                   type: loans[index].type,
//                 ),
//               );
//             },
//           );
//         } else {
//           if (snapshot.hasError) {
//             print(snapshot.error);
//             return Text("There was an error fetching data ${snapshot.error}");
//           } else {
//             return const CircularProgressIndicator();
//           }
//         }
//       },
//     );
//   }
// }

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/common/loan.dart';
import 'package:flutter_application_1/pages/finance/common/loaninfo.dart';
import 'package:flutter_application_1/pages/finance/loan/addloan.dart';
import 'package:flutter_application_1/pages/finance/loan/editloan.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Loanpage extends StatefulWidget {
  final Datamanager datamanager;
  const Loanpage({super.key, required this.datamanager});

  @override
  State<Loanpage> createState() => _LoanpageState();
}

class _LoanpageState extends State<Loanpage> {
  late Future<List<Loan>> _loanFuture;

  @override
  void initState() {
    super.initState();
    _loanFuture = Datamanager().getLoan();
  }

  void _refreshLoans() {
    setState(() {
      _loanFuture = Datamanager().getLoan();
    });
  }

  List<Map<String, dynamic>> _groupLoans(
    List<Loan> loans, {
    String? filterType,
  }) {
    final Map<String, Map<String, dynamic>> grouped = {};

    for (var loan in loans) {
      if (filterType != null && loan.type != filterType) continue;

      final name = loan.loanerName;
      final phone = loan.phoneNumber;
      final amount = loan.type == "Receivable" ? loan.amount : -loan.amount;

      if (grouped.containsKey(name)) {
        grouped[name]!['amount'] += amount;

        // When we're showing "All", we can't trust the type of a single loan.
        if (filterType == null) {
          grouped[name]!['types'].add(loan.type);
        }
      } else {
        grouped[name] = {
          'phoneNumber': phone,
          'amount': amount,
          'id': loan.id,
          'types': filterType == null ? {loan.type} : {filterType},
        };
      }
    }

    return grouped.entries.map((entry) {
      final types = entry.value['types'] as Set<String>;
      final netAmount = entry.value['amount'] as int;

      return {
        'name': entry.key,
        'phoneNumber': entry.value['phoneNumber'],
        'amount': netAmount,
        'id': entry.value['id'],
        'type':
            types.length == 1
                ? types.first
                : (netAmount >= 0 ? 'Receivable' : 'Payable'),
      };
    }).toList();
  }

  Widget _loanTabView({required List<Loan> loans, String? filterType}) {
    final filteredLoans = _groupLoans(loans, filterType: filterType);

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: filteredLoans.length,
      itemBuilder: (context, index) {
        final loan = filteredLoans[index];
        return LoanCard(
          name: loan['name'],
          phoneNumber: loan['phoneNumber'],
          loanAmount: loan['amount'],
          id: loan['id'],
          datamanager: widget.datamanager,
          type: loan['type'],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newLoans =
              await PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: AddLoan(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                settings: const RouteSettings(),
              );

          if (newLoans != null) {
            setState(() {
              _loanFuture = Future.value(newLoans);
            });
          }
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              LoanWidget(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                height: MediaQuery.of(context).size.height * .7,
                child: FutureBuilder(
                  future: _loanFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var loans = snapshot.data as List<Loan>;
                      return ContainedTabBarView(
                        tabs: [
                          Tab(text: "All Loans"),
                          Tab(text: "Receivable Loans"),
                          Tab(text: "Payable Loans"),
                        ],
                        tabBarProperties: TabBarProperties(
                          height: 32,
                          isScrollable: false,
                          labelPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .035,
                          ),
                          background: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                          ),
                          position: TabBarPosition.top,
                          alignment: TabBarAlignment.start,
                          indicatorColor: Color(0xff009966),
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xff009966),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor:
                              Theme.of(context).primaryColorLight,
                          unselectedLabelStyle: TextStyle(fontSize: 13),
                        ),
                        views: [
                          _loanTabView(
                            loans: loans,
                            filterType: null,
                          ), // All loans
                          _loanTabView(loans: loans, filterType: "Receivable"),
                          _loanTabView(loans: loans, filterType: "Payable"),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error fetching data: ${snapshot.error}");
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
