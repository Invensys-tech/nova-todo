// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/datamanager.dart';
// import 'package:flutter_application_1/datamodel.dart';
// import 'package:flutter_application_1/pages/finance/bank/addbank.dart';
// import 'package:flutter_application_1/pages/finance/bank/editbank.dart';
// import 'package:flutter_application_1/pages/finance/common/balance.dart';
// import 'package:flutter_application_1/pages/finance/common/bank.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// class BankPage extends StatefulWidget {
//   final Datamanager datamanager;
//   const BankPage({super.key, required this.datamanager});

//   @override
//   State<BankPage> createState() => _BankPageState();
// }

// class _BankPageState extends State<BankPage> {
//   late Future<List<Bank>> _banksFuture;

//   @override
//   void initState() {
//     super.initState();
//     _banksFuture = Datamanager().getBanks();
//   }

//   void _refreshBanks() {
//     setState(() {
//       _banksFuture = Datamanager().getBanks();
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         foregroundColor: Colors.white,
//         backgroundColor: const Color(0xff009966),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50), // Rounded corners
//         ),
//         onPressed: () async {
//           // Action when pressed

//           final newBanks =
//               await PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//                 context,
//                 screen: AddBank(),
//                 withNavBar: false,
//                 pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                 settings: const RouteSettings(),
//               );

//           if (newBanks != null) {
//             setState(() {
//               _banksFuture = Future.value(newBanks);
//             });
//           }

//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => AddBank(),
//           //   ), // Navigate to NewScreen
//           // );
//         },
//         child: Icon(Icons.add), // The icon inside the button
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.03,
//         ),
//         child: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//               BankBalance(total: 4000.0),

//               FutureBuilder(
//                 future: widget.datamanager.getBanks(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     var banks = snapshot.data as List<Bank>;
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       physics: ClampingScrollPhysics(),
//                       itemCount: banks.length,
//                       itemBuilder: (context, index) {
//                         final bank = banks[index];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Slidable(
//                               key: ValueKey(bank.id),
//                               endActionPane: ActionPane(
//                                 motion: const ScrollMotion(),
//                                 children: [
//                                   SlidableAction(
//                                     onPressed: (context) {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder:
//                                               (context) => EditBank(
//                                                 bankId: bank.id,
//                                                 datamanager: widget.datamanager,
//                                               ),
//                                         ),
//                                       );
//                                     },
//                                     backgroundColor: Colors.blue,
//                                     foregroundColor: Colors.white,
//                                     icon: Icons.edit,
//                                     label: 'Edit',
//                                   ),
//                                 ],
//                               ),
//                               startActionPane: ActionPane(
//                                 motion: const ScrollMotion(),
//                                 children: [
//                                   SlidableAction(
//                                     onPressed: (context) {
//                                       // Show a confirmation dialog before deleting
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: const Text('Confirm Delete'),
//                                             content: const Text(
//                                               'Are you sure you want to delete this bank?',
//                                             ),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () {
//                                                   Navigator.of(
//                                                     context,
//                                                   ).pop(); // Dismiss the dialog
//                                                 },
//                                                 child: const Text('Cancel'),
//                                               ),
//                                               TextButton(
//                                                 onPressed: () {
//                                                   // Place your delete logic here

//                                                   print('Deleted ${bank.id}');
//                                                   Navigator.of(
//                                                     context,
//                                                   ).pop(); // Dismiss the dialog
//                                                 },
//                                                 child: const Text(
//                                                   'Delete',
//                                                   style: TextStyle(
//                                                     color: Colors.red,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                     icon: Icons.delete,
//                                     label: 'Delete',
//                                   ),
//                                 ],
//                               ),

//                               child: BankWidget(
//                                 id: banks[index].id,
//                                 accountname: banks[index].accountHolder,
//                                 accoutnumber: banks[index].accountNumber,
//                                 balance: banks[index].balance,
//                                 datamanager: widget.datamanager,
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   } else {
//                     if (snapshot.hasError) {
//                       print(snapshot.error);
//                       return Text(
//                         "There was an error fetching data ${snapshot.error}",
//                       );
//                     } else {
//                       return const CircularProgressIndicator();
//                     }
//                   }
//                 },
//               ),

//               // BankWidget(),
//               // BankWidget(),
//               // BankWidget(),
//               // BankWidget(),
//               // BankWidget(),
//               // BankWidget(),
//               // BankWidget(),
//               // BankWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/bank/addbank.dart';
import 'package:flutter_application_1/pages/finance/bank/editbank.dart';
import 'package:flutter_application_1/pages/finance/common/balance.dart';
import 'package:flutter_application_1/pages/finance/common/bank.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankPage extends StatefulWidget {
  final Datamanager datamanager;
  const BankPage({super.key, required this.datamanager});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  late Future<List<Bank>> _banksFuture;

  double _totalBankExpense = 0.0;
  double _totalBankIncome = 0.0;

  @override
  void initState() {
    super.initState();
    _banksFuture = Datamanager().getBanks();
    _fetchAndComputeBankStats();
  }

  Future<void> _fetchAndComputeBankStats() async {
    // final expenses = await widget.datamanager.fetchExpense();
    final expenses = await Supabase.instance.client.from('expense').select('*');

    final incomes = await Supabase.instance.client.from('incomes').select('*');

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

  void _refreshBanks() {
    setState(() {
      _banksFuture = Datamanager().getBanks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff009966),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          final newBanks =
              await PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: AddBank(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                settings: const RouteSettings(),
              );

          if (newBanks != null) {
            setState(() {
              _banksFuture = Future.value(newBanks);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<List<Bank>>(
            future: _banksFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text("There was an error: ${snapshot.error}");
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("No bank data found.");
              }

              List<Bank> banks = snapshot.data!;
              double totalBalance = banks.fold(
                0.0,
                (sum, bank) => sum + bank.balance,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  BankBalance(
                    total: totalBalance,
                    expense: _totalBankExpense,
                    income: _totalBankIncome,
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: banks.length,
                    itemBuilder: (context, index) {
                      final bank = banks[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Slidable(
                            key: ValueKey(bank.id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => EditBank(
                                              bankId: bank.id,
                                              datamanager: widget.datamanager,
                                            ),
                                      ),
                                    );
                                  },
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ],
                            ),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Delete'),
                                          content: const Text(
                                            'Are you sure you want to delete this bank?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                print('Deleted ${bank.id}');
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
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
                            child: BankWidget(
                              id: bank.id,
                              accountname: bank.accountHolder,
                              accoutnumber: bank.accountNumber,
                              balance: bank.balance,
                              datamanager: widget.datamanager,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
