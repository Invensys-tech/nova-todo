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

import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

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
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  // Remove fixed height to allow content to determine height
                  color: Color(0xff202020),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.045,
                  vertical: MediaQuery.of(context).size.height * 0.0095,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Balance',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Total Balance',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_drop_down),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      "\$ 99,000",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
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
                            fontSize: 11,
                            fontWeight: FontWeight.w200,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.003,
                        ),
                        Text(
                          '\$ 15,000',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.white.withOpacity(0.8),
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
                            fontSize: 11,
                            fontWeight: FontWeight.w200,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.003,
                        ),
                        Text(
                          '\$ -5,000',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.white.withOpacity(0.8),
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
              _buildAccountSection(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _buildAccountSection(), // Add one more to ensure content overflows
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _buildAccountSection(), // Add one more to ensure content overflows
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
            Text("Account", style: TextStyle(fontWeight: FontWeight.w500)),
            Text("See All"),
          ],
        ),
        _buildAccountItem(),
        _buildAccountItem(),
        _buildAccountItem(),
      ],
    );
  }

  Widget _buildAccountItem() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.083,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.003,
      ),
      decoration: BoxDecoration(
        color: Color(0xff292929),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.045,
            width: MediaQuery.of(context).size.height * 0.045,
            decoration: BoxDecoration(
              color: Color(0xff8466fc),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.045),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "Commercial bank of eth.",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Text(
                "10000000000000",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '\$ 1,000,000',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
