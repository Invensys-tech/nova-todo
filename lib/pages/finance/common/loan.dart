// import 'package:badges/badges.dart' as badges;
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/datamanager.dart';
// import 'package:flutter_application_1/datamodel.dart';
// import 'package:flutter_translate/flutter_translate.dart';

// class LoanWidget extends StatefulWidget {
//   const LoanWidget({super.key});

//   @override
//   State<LoanWidget> createState() => _LoanWidgetState();
// }

// class _LoanWidgetState extends State<LoanWidget> {
//   late Future<List<Loan>> _loanFuture;

//   @override
//   void initState() {
//     super.initState();
//     _loanFuture = Datamanager().getLoan();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Loan>>(
//       future: _loanFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return SizedBox(
//             height: MediaQuery.of(context).size.height * .2675,
//             child: const Center(child: CircularProgressIndicator()),
//           );
//         }
//         if (snapshot.hasError || !snapshot.hasData) {
//           return SizedBox(
//             height: MediaQuery.of(context).size.height * .2675,
//             child: Center(child: Text('Error loading loans')),
//           );
//         }

//         final loans = snapshot.data!;
//         // Compute sums
//         final receivableSum = loans
//             .where((l) => l.type == "Receivable")
//             .fold<double>(0, (sum, l) => sum + l.amount);
//         final payableSum = loans
//             .where((l) => l.type == "Payable")
//             .fold<double>(0, (sum, l) => sum + l.amount);
//         final netSum = receivableSum - payableSum;

//         return Container(
//           height: MediaQuery.of(context).size.height * .2675,
//           width: MediaQuery.of(context).size.width * .95,
//           padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width * .025,
//             vertical: MediaQuery.of(context).size.height * .02,
//           ),
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColorDark,
//             borderRadius: const BorderRadius.all(Radius.circular(15)),
//             border: Border.all(color: Colors.grey.withOpacity(.2)),
//           ),
//           child: Column(
//             children: [
//               // Top box: net amount
//               Container(
//                 width: MediaQuery.of(context).size.width * .9,
//                 height: MediaQuery.of(context).size.height * .12,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Theme.of(context).disabledColor,
//                 ),
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * .035,
//                         vertical: MediaQuery.of(context).size.height * .01,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .01,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 translate('Net Amount Loan.  '),
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               badges.Badge(
//                                 showBadge: true,
//                                 badgeContent: Text(
//                                   netSum >= 0 ? translate("Receivable" ): translate("Payable"),
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color:
//                                         netSum >= 0 ? Colors.green : Colors.red,
//                                   ),
//                                 ),
//                                 badgeStyle: badges.BadgeStyle(
//                                   shape: badges.BadgeShape.square,
//                                   badgeColor: Colors.black,
//                                   padding: const EdgeInsets.all(4),
//                                   borderRadius: BorderRadius.circular(4),
//                                   elevation: 0,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Text(
//                                 translate('Today'),
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const Icon(
//                                 Icons.arrow_drop_down,
//                                 size: 20,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .005,
//                           ),
//                           Text(
//                             'ETB ${netSum.abs().toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               fontSize: 27,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       top: MediaQuery.of(context).size.height * .03,
//                       left: MediaQuery.of(context).size.width * .4,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * .3,
//                         height: MediaQuery.of(context).size.height * .1,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: const Color(0xff009966).withOpacity(.1),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: MediaQuery.of(context).size.height * .05,
//                       left: MediaQuery.of(context).size.width * .5,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * .35,
//                         height: MediaQuery.of(context).size.height * .15,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: const Color(0xffFAFAFA).withOpacity(.1),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: MediaQuery.of(context).size.height * .015),

//               // Bottom row: receivable and payable boxes
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width * .035,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Receivable
//                     Container(
//                       height: MediaQuery.of(context).size.height * .09,
//                       width: MediaQuery.of(context).size.width * .35,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * .02,
//                         vertical: MediaQuery.of(context).size.height * .01,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).cardColor,
//                         border: Border.all(
//                           width: 1,
//                           color: Colors.grey.withOpacity(.2),
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                            Text(
//                            translate( "Receivable"),
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               const Text(
//                                 "+ ",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.green,
//                                 ),
//                               ),
//                               Text(
//                                 "ETB ${receivableSum.toStringAsFixed(2)}",
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Payable
//                     Container(
//                       height: MediaQuery.of(context).size.height * .09,
//                       width: MediaQuery.of(context).size.width * .35,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * .02,
//                         vertical: MediaQuery.of(context).size.height * .01,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).cardColor,
//                         border: Border.all(
//                           width: 1,
//                           color: Colors.grey.withOpacity(.2),
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                            Text(
//                            translate( "Payable"),
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               const Text(
//                                 "- ",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               Text(
//                                 "ETB ${payableSum.toStringAsFixed(2)}",
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:badges/badges.dart' as badges;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoanWidget extends StatefulWidget {
  const LoanWidget({super.key});

  @override
  State<LoanWidget> createState() => _LoanWidgetState();
}

class _LoanWidgetState extends State<LoanWidget> {
  late Future<List<Loan>> _loanFuture;

  @override
  void initState() {
    super.initState();
    _loadLoans();
  }

  Future<void> _loadLoans() async {
    setState(() {
      _loanFuture = Datamanager().getLoan();
    });
  }

  Future<void> _handleRefresh() async {
    await _loadLoans();
    // wait for the future to complete before ending the refresh indicator
    await _loanFuture;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .2675,
      child: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        child: FutureBuilder<List<Loan>>(
          future: _loanFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: Text('Error loading loans'));
            }

            final loans = snapshot.data!;
            // Compute sums
            final receivableSum = loans
                .where((l) => l.type == "Receivable")
                .fold<double>(0, (sum, l) => sum + l.amount);
            final payableSum = loans
                .where((l) => l.type == "Payable")
                .fold<double>(0, (sum, l) => sum + l.amount);
            final netSum = receivableSum - payableSum;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width * .95,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .025,
                  vertical: MediaQuery.of(context).size.height * .02,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: Colors.grey.withOpacity(.2)),
                ),
                child: Column(
                  children: [
                    // Top box: net amount
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).disabledColor,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .035,
                              vertical:
                                  MediaQuery.of(context).size.height * .01,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .01,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      translate('Net Amount Loan.  '),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    badges.Badge(
                                      showBadge: true,
                                      badgeContent: Text(
                                        netSum >= 0
                                            ? translate("Receivable")
                                            : translate("Payable"),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              netSum >= 0
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                      badgeStyle: badges.BadgeStyle(
                                        shape: badges.BadgeShape.square,
                                        badgeColor: Colors.black,
                                        padding: const EdgeInsets.all(4),
                                        borderRadius: BorderRadius.circular(4),
                                        elevation: 0,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      translate('Today'),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .005,
                                ),
                                Text(
                                  'ETB ${netSum.abs().toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .03,
                            left: MediaQuery.of(context).size.width * .4,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .3,
                              height: MediaQuery.of(context).size.height * .1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff009966).withOpacity(.1),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .05,
                            left: MediaQuery.of(context).size.width * .5,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .35,
                              height: MediaQuery.of(context).size.height * .15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xffFAFAFA).withOpacity(.1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * .015),

                    // Bottom row: receivable and payable boxes
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .035,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Receivable
                          Container(
                            height: MediaQuery.of(context).size.height * .09,
                            width: MediaQuery.of(context).size.width * .35,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .02,
                              vertical:
                                  MediaQuery.of(context).size.height * .01,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(.2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translate("Receivable"),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "+ ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      "ETB ${receivableSum.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Payable
                          Container(
                            height: MediaQuery.of(context).size.height * .09,
                            width: MediaQuery.of(context).size.width * .35,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .02,
                              vertical:
                                  MediaQuery.of(context).size.height * .01,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(.2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translate("Payable"),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "- ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      "ETB ${payableSum.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
