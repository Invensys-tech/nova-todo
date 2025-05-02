import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/common/transaction.dart';
import 'package:flutter_application_1/pages/finance/loan/singleloan.dart';
import 'package:flutter_application_1/pages/finance/loan/singleloanedit.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoanView extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final num loanAmount;
  final int parentLoanId;
  final Datamanager datamanager;

  const LoanView({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.loanAmount,
    required this.parentLoanId,
    required this.datamanager,
  }) : super(key: key);

  @override
  State<LoanView> createState() => _LoanViewState();
}

class _LoanViewState extends State<LoanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder:
      //             (context) => SingleLoan(parentLoanId: widget.parentLoanId),
      //       ), // Navigate to NewScreen
      //     );
      //   },
      //   backgroundColor: Colors.green, // Green background
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white, // White icon color
      //     size: 30, // Adjust size if needed
      //   ),
      // ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,),
        ),
        title: Text(
          translate("Back to Loans"),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ), // Bold title
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.045,
                  vertical: MediaQuery.of(context).size.height * 0.0095,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.009,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.009,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(
                              0.8,
                            ), // Background color
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Rounded corners
                          ),
                          child: Text(
                            translate("Owes Me"),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             translate( "Phone"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text(
                              widget.phoneNumber,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate("Amount"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text(
                              "${translate(("ETB"))} ${widget.loanAmount}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate("Transactions"),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    translate("See All"),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              FutureBuilder(
                future: widget.datamanager.getLoansByName(widget.name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var loans = snapshot.data as List<Loan>;
                    double cumulative = 0;
                    final List<Map<String, double>> cumulativeAmounts = [];

                    for (var loan in loans) {
                      double before = cumulative;
                      double after =
                          loan.type.toLowerCase() == 'payable'
                              ? before - loan.amount
                              : before + loan.amount;
                      cumulative = after;
                      cumulativeAmounts.add({"before": before, "after": after});
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: loans.length,
                      itemBuilder: (context, index) {
                        final loan = loans[index];
                        final amounts = cumulativeAmounts[index];

                        return Transaction(
                          date: loan.date,
                          amount: loan.amount,
                          before: amounts["before"]!,
                          after: amounts["after"]!,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error loading loans: ${snapshot.error}");
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),

              // FutureBuilder(
              //   future: widget.datamanager.getChildLoan(widget.parentLoanId),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       var childLoans = snapshot.data as List<ChildLoan>;
              //       print("my child loans $childLoans");
              //       double cumulative = 0;
              //       final List<Map<String, double>> cumulativeAmounts = [];
              //       for (var loan in childLoans) {
              //         double before = cumulative;
              //         double after;
              //         if (loan.type.toLowerCase() == 'payable') {
              //           // If type is Payable, subtract the amount.
              //           after = before - loan.amount;
              //         } else {
              //           // Otherwise, add the amount.
              //           after = before + loan.amount;
              //         }
              //         cumulative = after;
              //         cumulativeAmounts.add({"before": before, "after": after});
              //       }
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         physics: ClampingScrollPhysics(),
              //         itemCount: childLoans.length,
              //         itemBuilder: (context, index) {
              //           final loan = childLoans[index];
              //           final amounts = cumulativeAmounts[index];

              //           // Check the source property.
              //           // If source is "Expense" or "Income", don't add the Slidable.
              //           if (loan.source == "Expense" ||
              //               loan.source == "Income") {
              //             return Column(
              //               children: [
              //                 Transaction(
              //                   date: loan.date,
              //                   amount: loan.amount,
              //                   before: amounts["before"]!,
              //                   after: amounts["after"]!,
              //                 ),
              //               ],
              //             );
              //           } else {
              //             return Slidable(
              //               key: ValueKey(loan.id),
              //               // Left side for delete
              //               startActionPane: ActionPane(
              //                 motion: const ScrollMotion(),
              //                 children: [
              //                   SlidableAction(
              //                     onPressed: (context) {
              //                       showDialog(
              //                         context: context,
              //                         builder: (BuildContext context) {
              //                           return AlertDialog(
              //                             title: const Text('Confirm Delete'),
              //                             content: const Text(
              //                               'Are you sure you want to delete this loan?',
              //                             ),
              //                             actions: [
              //                               TextButton(
              //                                 onPressed: () {
              //                                   Navigator.of(
              //                                     context,
              //                                   ).pop(); // Dismiss the dialog
              //                                 },
              //                                 child: const Text('Cancel'),
              //                               ),
              //                               TextButton(
              //                                 onPressed: () async {
              //                                   try {
              //                                     // Replace this with your actual delete method.
              //                                     // await widget.datamanager
              //                                     //     .deleteChildLoan(loan.id);
              //                                     await supabaseClient
              //                                         .from("single_loan")
              //                                         .delete()
              //                                         .eq("id", loan.id);

              //                                     Navigator.of(
              //                                       context,
              //                                     ).pop(); // Dismiss the dialog
              //                                     setState(() {
              //                                       // Refresh the list after deletion.
              //                                       widget.datamanager
              //                                           .getChildLoan(
              //                                             widget.parentLoanId,
              //                                           );
              //                                     });
              //                                   } catch (e) {
              //                                     Navigator.of(context).pop();
              //                                     ScaffoldMessenger.of(
              //                                       context,
              //                                     ).showSnackBar(
              //                                       SnackBar(
              //                                         content: Text(
              //                                           "Error: $e",
              //                                         ),
              //                                       ),
              //                                     );
              //                                   }
              //                                 },
              //                                 child: const Text(
              //                                   'Delete',
              //                                   style: TextStyle(
              //                                     color: Colors.red,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           );
              //                         },
              //                       );
              //                     },
              //                     backgroundColor: Colors.red,
              //                     foregroundColor: Colors.white,
              //                     icon: Icons.delete,
              //                     label: 'Delete',
              //                   ),
              //                 ],
              //               ),
              //               // Right side for edit
              //               endActionPane: ActionPane(
              //                 motion: const ScrollMotion(),
              //                 children: [
              //                   SlidableAction(
              //                     onPressed: (context) {
              //                       Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                           builder:
              //                               (context) => EditSingleLoan(
              //                                 singleLoanId: loan.id,
              //                                 parentLoanId: loan.parentId,
              //                               ),
              //                         ),
              //                       ).then((_) {
              //                         setState(() {
              //                           // Refresh the list after edit.
              //                           widget.datamanager.getChildLoan(
              //                             widget.parentLoanId,
              //                           );
              //                         });
              //                       });
              //                     },
              //                     backgroundColor: Colors.blue,
              //                     foregroundColor: Colors.white,
              //                     icon: Icons.edit,
              //                     label: 'Edit',
              //                   ),
              //                 ],
              //               ),
              //               child: Column(
              //                 children: [
              //                   Transaction(
              //                     date: loan.date,
              //                     amount: loan.amount,
              //                     before: amounts["before"]!,
              //                     after: amounts["after"]!,
              //                   ),
              //                 ],
              //               ),
              //             );
              //           }
              //         },
              //       );
              //     } else {
              //       if (snapshot.hasError) {
              //         print(snapshot.error);
              //         return Text(
              //           "There was an error fetching data ${snapshot.error}",
              //         );
              //       } else {
              //         return const CircularProgressIndicator();
              //       }
              //     }
              //   },
              // ),

              // FutureBuilder(
              //   future: widget.datamanager.getChildLoan(widget.parentLoanId),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       var childLoans = snapshot.data as List<ChildLoan>;
              //       print("my child loans ${childLoans}");
              //       double cumulative = 0;
              //       final List<Map<String, double>> cumulativeAmounts = [];
              //       for (var loan in childLoans) {
              //         double before = cumulative;
              //         double after;
              //         if (loan.type.toLowerCase() == 'payable') {
              //           // If type is Payable, subtract the amount.
              //           after = before - loan.amount;
              //         } else {
              //           // Otherwise, add the amount.
              //           after = before + loan.amount;
              //         }
              //         cumulative = after;
              //         cumulativeAmounts.add({"before": before, "after": after});
              //       }
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         physics: ClampingScrollPhysics(),
              //         itemCount: childLoans.length,
              //         itemBuilder: (context, index) {
              //           final loan = childLoans[index];
              //           final amounts = cumulativeAmounts[index];
              //           return Column(
              //             children: [
              //               Transaction(
              //                 date: childLoans[index].date,
              //                 amount: childLoans[index].amount,
              //                 before: amounts["before"]!,
              //                 after: amounts["after"]!,
              //               ),
              //             ],
              //           );
              //         },
              //       );
              //     } else {
              //       if (snapshot.hasError) {
              //         print(snapshot.error);
              //         return Text(
              //           "There was an error fetching data ${snapshot.error}",
              //         );
              //       } else {
              //         return const CircularProgressIndicator();
              //       }
              //     }
              //   },
              // ),

              // Transaction(date: '04/2/3455',amount: 500.00,),
            ],
          ),
        ),
      ),
    );
  }
}
