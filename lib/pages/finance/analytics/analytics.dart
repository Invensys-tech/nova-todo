// import 'package:flutter/material.dart';

// class AnalyticsPage extends StatefulWidget {
//   const AnalyticsPage({super.key});

//   @override
//   State<AnalyticsPage> createState() => _AnalyticsPageState();
// }

// class _AnalyticsPageState extends State<AnalyticsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * 0.045,
//       ),
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height * 0.12,
//                 decoration: BoxDecoration(
//                   color: Color(0xff202020),
//                   borderRadius: BorderRadius.all(Radius.circular(15)),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width * 0.045,
//                   vertical: MediaQuery.of(context).size.height * 0.0095,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'Total Balance',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.29,
//                         ),
//                         Text(
//                           'Total Balance',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(Icons.arrow_drop_down),
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "\$ 99,000",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white.withOpacity(0.8),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.43,
//                     height: MediaQuery.of(context).size.height * 0.085,
//                     decoration: BoxDecoration(
//                       color: Color(0xff202020),
//                       borderRadius: BorderRadius.all(Radius.circular(11)),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width * 0.045,
//                       vertical: MediaQuery.of(context).size.height * 0.0095,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Total Income',
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.003,
//                         ),
//                         Text(
//                           '\$ 15,000',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.43,
//                     height: MediaQuery.of(context).size.height * 0.085,
//                     decoration: BoxDecoration(
//                       color: Color(0xff202020),
//                       borderRadius: BorderRadius.all(Radius.circular(11)),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width * 0.045,
//                       vertical: MediaQuery.of(context).size.height * 0.0095,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Total Expense',
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.003,
//                         ),
//                         Text(
//                           '\$ -5,000',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//               Container(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Account",
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         Text("See All"),
//                       ],
//                     ),

//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         vertical: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       width: MediaQuery.of(context).size.width * 1,
//                       height: MediaQuery.of(context).size.height * 0.083,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.02,
//                         vertical: MediaQuery.of(context).size.height * 0.003,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xff292929),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.height * 0.045,
//                             decoration: BoxDecoration(
//                               color: Color(0xff8466fc),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.width * 0.045,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.01,
//                               ),
//                               Text(
//                                 "Commercial bank of eth.",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                               Text(
//                                 "10000000000000",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.185,
//                           ),
//                           Text(
//                             '\$ 1,000,000',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w200,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         vertical: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       width: MediaQuery.of(context).size.width * 1,
//                       height: MediaQuery.of(context).size.height * 0.083,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.02,
//                         vertical: MediaQuery.of(context).size.height * 0.003,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xff292929),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.height * 0.045,
//                             decoration: BoxDecoration(
//                               color: Color(0xff8466fc),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.width * 0.045,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.01,
//                               ),
//                               Text(
//                                 "Commercial bank of eth.",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                               Text(
//                                 "10000000000000",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.185,
//                           ),
//                           Text(
//                             '\$ 1,000,000',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w200,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         vertical: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       width: MediaQuery.of(context).size.width * 1,
//                       height: MediaQuery.of(context).size.height * 0.083,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.02,
//                         vertical: MediaQuery.of(context).size.height * 0.003,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xff292929),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.height * 0.045,
//                             decoration: BoxDecoration(
//                               color: Color(0xff8466fc),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.width * 0.045,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.01,
//                               ),
//                               Text(
//                                 "Commercial bank of eth.",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                               Text(
//                                 "10000000000000",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.185,
//                           ),
//                           Text(
//                             '\$ 1,000,000',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w200,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),

//               Container(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Account",
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         Text("See All"),
//                       ],
//                     ),

//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         vertical: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       width: MediaQuery.of(context).size.width * 1,
//                       height: MediaQuery.of(context).size.height * 0.083,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.02,
//                         vertical: MediaQuery.of(context).size.height * 0.003,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xff292929),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.height * 0.045,
//                             decoration: BoxDecoration(
//                               color: Color(0xff8466fc),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.width * 0.045,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.01,
//                               ),
//                               Text(
//                                 "Commercial bank of eth.",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                               Text(
//                                 "10000000000000",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.185,
//                           ),
//                           Text(
//                             '\$ 1,000,000',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w200,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         vertical: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       width: MediaQuery.of(context).size.width * 1,
//                       height: MediaQuery.of(context).size.height * 0.083,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.02,
//                         vertical: MediaQuery.of(context).size.height * 0.003,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xff292929),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.height * 0.045,
//                             decoration: BoxDecoration(
//                               color: Color(0xff8466fc),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.width * 0.045,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.01,
//                               ),
//                               Text(
//                                 "Commercial bank of eth.",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                               Text(
//                                 "10000000000000",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.185,
//                           ),
//                           Text(
//                             '\$ 1,000,000',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w200,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         vertical: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       width: MediaQuery.of(context).size.width * 1,
//                       height: MediaQuery.of(context).size.height * 0.083,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.02,
//                         vertical: MediaQuery.of(context).size.height * 0.003,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xff292929),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.height * 0.045,
//                             decoration: BoxDecoration(
//                               color: Color(0xff8466fc),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.045,
//                             width: MediaQuery.of(context).size.width * 0.045,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.01,
//                               ),
//                               Text(
//                                 "Commercial bank of eth.",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                               Text(
//                                 "10000000000000",
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.185,
//                           ),
//                           Text(
//                             '\$ 1,000,000',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w200,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/analytics/analytics.view.dart';
import 'package:flutter_application_1/pages/finance/common/Expenses.dart';
import 'package:flutter_application_1/pages/finance/common/balance.dart';
import 'package:flutter_application_1/pages/finance/common/bank.dart';
import 'package:flutter_application_1/repositories/expense.repository.dart';
import 'package:slider_bar_chart/slider_bar_chart.dart';

class AnalyticsPage extends StatefulWidget {
  final Datamanager datamanager;
  const AnalyticsPage({super.key, required this.datamanager});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
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
              BankBalance(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // Income and Expense containers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Income container
                  Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    decoration: BoxDecoration(
                      // Remove fixed height
                      color: Color(0xff202020),
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.045,
                      vertical: MediaQuery.of(context).size.height * 0.0095,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Income',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.003,
                        ),
                        Text(
                          '\$ 15,000',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expense container
                  Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    decoration: BoxDecoration(
                      // Remove fixed height
                      color: Color(0xff202020),
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.045,
                      vertical: MediaQuery.of(context).size.height * 0.0095,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Expense',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.003,
                        ),
                        Text(
                          '\$ -5,000',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              // Add more content to ensure scrolling
              _buildAccountSection(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _ExpensesCatagorypage(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _GraphDesign(), // Add one more to ensure content overflows
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
              "Account",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            Text(
              "See All",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        Column(
          children: [
            FutureBuilder(
              future: widget.datamanager.getBanks(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var banks = snapshot.data as List<Bank>;
                  return ListView.builder(
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
          ],
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
              "Expenses Catagory",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            AnalyticsView(datamanager: widget.datamanager),
                  ),
                );
                print("touched");
              },
              child: Container(
                padding: EdgeInsets.all(8), // Give it tappable space
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),

        Column(
          children: [
            FutureBuilder<Map<String, Map<String, dynamic>>>(
              future: ExpenseRepository().getExpenseCategoryTotals(),
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
