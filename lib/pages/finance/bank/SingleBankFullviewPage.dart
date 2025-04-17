// import 'package:flutter/material.dart';

// class Singlebankfullviewpage extends StatefulWidget {
//   final int id;
//   final String name;
//   const Singlebankfullviewpage({
//     super.key,
//     required this.id,
//     required this.name,
//   });

//   @override
//   State<Singlebankfullviewpage> createState() => _SinglebankfullviewpageState();
// }

// class _SinglebankfullviewpageState extends State<Singlebankfullviewpage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         leading: Icon(Icons.arrow_back, size: 20, color: Colors.white),
//         title: Text(
//           "Abyssinya Bank",
//           style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//         actions: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width * .005,
//                   vertical: MediaQuery.of(context).size.height * .005,
//                 ),
//                 width: MediaQuery.of(context).size.width * .225,
//                 height: MediaQuery.of(context).size.height * .0375,
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 1, color: Colors.grey),
//                   borderRadius: BorderRadius.circular(7),
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(width: MediaQuery.of(context).size.width * .015),
//                     Icon(
//                       Icons.date_range_rounded,
//                       size: 18,
//                       color: Colors.white.withOpacity(.75),
//                     ),
//                     SizedBox(width: MediaQuery.of(context).size.width * .035),
//                     Text(
//                       "2015",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width * .015),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * .2,
//             child: Column(
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * .05),
//                 Center(
//                   child: Text(
//                     "Avilable Balance ",
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff038722),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * .015),
//                 Center(
//                   child: Text(
//                     "\$ 350,435 ",
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * .005),
//                 Center(
//                   child: Text(
//                     "Saving Account",
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff038722).withOpacity(.7),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Container(
//             width: MediaQuery.of(context).size.width * .9,
//             height: MediaQuery.of(context).size.height * .125,
//             margin: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * .05,
//             ),
//             decoration: BoxDecoration(
//               border: Border.all(width: 1, color: Colors.grey.withOpacity(.5)),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * .02),
//                 Center(
//                   child: Text(
//                     "10002211260373",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * .02),
//                 Row(
//                   children: [
//                     SizedBox(width: MediaQuery.of(context).size.width * .02),
//                     Text(
//                       "Created In: 12 -02 -2022",
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                     SizedBox(width: MediaQuery.of(context).size.width * .2),
//                     Text(
//                       "Abbysinya Branch ",
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                     SizedBox(width: MediaQuery.of(context).size.width * .02),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height * .035),
//           Container(
//             height: MediaQuery.of(context).size.height * .465,
//             color: Colors.black,
//             child: Column(
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * .01),
//                 Container(
//                   height: MediaQuery.of(context).size.height * .075,
//                   color: Colors.grey.withOpacity(.1),
//                   child: Row(
//                     children: [
//                       SizedBox(width: MediaQuery.of(context).size.width * .02),
//                       Icon(
//                         Icons.transit_enterexit_rounded,
//                         color: Colors.red,
//                         size: 25,
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width * .02),
//                       Column(
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .0075,
//                           ),
//                           Text(
//                             "Paid For Expenses in",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .0035,
//                           ),
//                           Text(
//                             "12 - 02 -2025  11:50",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(width: MediaQuery.of(context).size.width * .3),
//                       Text(
//                         "-",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.red,
//                         ),
//                       ),
//                       Text(
//                         "\$ 350",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * .015),
//                 Container(
//                   height: MediaQuery.of(context).size.height * .075,
//                   color: Colors.grey.withOpacity(.1),
//                   child: Row(
//                     children: [
//                       SizedBox(width: MediaQuery.of(context).size.width * .02),
//                       Icon(
//                         Icons.transit_enterexit_rounded,
//                         color: Colors.red,
//                         size: 25,
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width * .02),
//                       Column(
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .0075,
//                           ),
//                           Text(
//                             "Paid For Expenses in",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .0035,
//                           ),
//                           Text(
//                             "12 - 02 -2025  11:50",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(width: MediaQuery.of(context).size.width * .3),
//                       Text(
//                         "-",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.red,
//                         ),
//                       ),
//                       Text(
//                         "\$ 350",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * .015),
//                 Container(
//                   height: MediaQuery.of(context).size.height * .075,
//                   color: Colors.grey.withOpacity(.1),
//                   child: Row(
//                     children: [
//                       SizedBox(width: MediaQuery.of(context).size.width * .02),
//                       Icon(
//                         Icons.transit_enterexit_rounded,
//                         color: Colors.red,
//                         size: 25,
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width * .02),
//                       Column(
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .0075,
//                           ),
//                           Text(
//                             "Paid For Expenses in",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .0035,
//                           ),
//                           Text(
//                             "12 - 02 -2025  11:50",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(width: MediaQuery.of(context).size.width * .3),
//                       Text(
//                         "-",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.red,
//                         ),
//                       ),
//                       Text(
//                         "\$ 350",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * .015),
//                 Container(
//                   color: Theme.of(context).canvasColor,
//                   width: MediaQuery.of(context).size.width * 1,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width * .025,
//                       vertical: MediaQuery.of(context).size.height * .015,
//                     ),
//                     child: Row(
//                       children: [
//                         Action != "Added"
//                             ? Icon(
//                               Icons.transit_enterexit,
//                               color: Colors.red,
//                               size: 15,
//                             )
//                             : Icon(
//                               Icons.call_made,
//                               color: Colors.green,
//                               size: 15,
//                             ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * .02,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * .68,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Transactionname",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * .005,
//                               ),
//                               Text(
//                                 "12 - 02 -2025 12:30PM",
//                                 style: TextStyle(
//                                   color: Colors.white.withOpacity(.5),
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w200,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               "-",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "\$ 500",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w300,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';

class Singlebankfullviewpage extends StatefulWidget {
  final int id;
  final String name;
  final Datamanager datamanager;
  const Singlebankfullviewpage({
    super.key,
    required this.id,
    required this.name,
    required this.datamanager,
  });

  @override
  State<Singlebankfullviewpage> createState() => _SinglebankfullviewpageState();
}

class _SinglebankfullviewpageState extends State<Singlebankfullviewpage> {
  late Future<Map<String, dynamic>> _bankView;

  @override
  void initState() {
    super.initState();
    // fetch the bank view using the provided id and name from widget
    _bankView = widget.datamanager.fetchBankView(widget.id, widget.name);
    print(_bankView);
  }

  // Unified widget to build a transaction row for both expenses and incomes.
  Widget _buildTransactionRow({
    required String transactionType, // "expense" or "income"
    required String title,
    required String date,
    required num amount,
  }) {
    // Determine properties based on transaction type
    final isIncome = transactionType == "income";
    final iconData = isIncome ? Icons.arrow_upward : Icons.arrow_downward;
    final iconColor = isIncome ? Colors.green : Colors.red;
    final sign = isIncome ? "+" : "-";
    final amountColor = isIncome ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1,color: Colors.grey.withOpacity(.2))
      ),
      child: Row(
        children: [
          Icon(iconData, color: iconColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "$sign \$${amount}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.03,),
          Container(
            height: MediaQuery.of(context).size.height*.1,
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.02,vertical: MediaQuery.of(context).size.height*.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_left,size: 30,color:Color(0xff009966) ,),
                    Text("Awash bank",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),)
                  ],
                ),
              ), Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Column(
                     children: [
                       SizedBox(height: MediaQuery.of(context).size.height*.0175,),
                       Text("Dejat wube brnach",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                       Text("Created at 12-02-2015",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),),
                     ],
                   ),
                    SizedBox(width: MediaQuery.of(context).size.width*.02,),
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.grey.withOpacity(0.5), // Choose your color and opacity
                        BlendMode.modulate, // Or try `BlendMode.color` or others
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.height * 0.045,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            image: DecorationImage(image: CachedNetworkImageProvider("https://combanketh.et/cbeapi/uploads/logo_1ae2fb1df4.jpg"),fit: BoxFit.cover)
                        ),


                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: _bankView,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No Data Found"));
              } else {
                // Extract bank details and transactions
                final bank = snapshot.data!['bank'] as Bank;
                final List<dynamic> expenseData =
                    snapshot.data!['expenses'] as List<dynamic>;
                final List<Income> incomeList =
                    (snapshot.data!['incomes'] as List<dynamic>)
                        .map((e) => Income.fromJson(e as Map<String, dynamic>))
                        .toList();

                return SingleChildScrollView(
                  child: Column(
                    children: [
                  Container(
                  height: MediaQuery.of(context).size.height*.2675,
                  width: MediaQuery.of(context).size.width*.95,
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.02),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.grey.withOpacity(.2))
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*.9,
                        height: MediaQuery.of(context).size.height*.12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:Theme.of(context).disabledColor
                        ),
                        child:   Stack(
                          children: [

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035, vertical: MediaQuery.of(context).size.height*.01),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  Row(
                                    children: [
                                      Text(
                                        'Total Balance',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Today',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down, size: 20,color: Colors.white,),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.005,),
                                  Text(
                                    "\$ 99,000",
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height*.03,
                              left: MediaQuery.of(context).size.width*.4,
                              child: Container(
                                width: MediaQuery.of(context).size.width*.3,
                                height: MediaQuery.of(context).size.height*.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff009966).withOpacity(.1)
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height*.05,
                              left: MediaQuery.of(context).size.width*.5,
                              child: Container(
                                width: MediaQuery.of(context).size.width*.35,
                                height: MediaQuery.of(context).size.height*.15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFAFAFA).withOpacity(.1)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.015,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*.09,
                              width: MediaQuery.of(context).size.width*.82,
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.02,vertical: MediaQuery.of(context).size.height*.01),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(width: 1 , color: Colors.grey.withOpacity(.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Demeqe Zewdu ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                                  Row(
                                    children: [
                                      Text("1000221126037",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
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

                      SizedBox(height: MediaQuery.of(context).size.height * .015),

                      // Transactions Section
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text(
                            //   "Expenses",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            // Display expenses using the unified transaction widget
                            ...expenseData.map((expense) {
                              // Adjust field names as needed; assuming expense JSON has keys:
                              // 'bankAccount', 'date', 'amount'
                              return _buildTransactionRow(
                                transactionType: "expense",
                                title:
                                    "Expense: ${expense['bankAccount'] ?? 'Unknown'}",
                                date: expense['date'] ?? '',
                                amount: expense['amount'] ?? 0,
                              );
                            }).toList(),
                            // const SizedBox(height: 16),
                            // const Text(
                            //   "Incomes",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            // Display incomes using the unified transaction widget
                            ...incomeList.map((income) {
                              // Convert the date to a readable format if needed.
                              String formattedDate =
                                  "${income.date.toLocal()}".split(' ')[0];
                              return _buildTransactionRow(
                                transactionType: "income",
                                title: "Income: ${income.name}",
                                date: formattedDate,
                                amount: income.amount,
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
