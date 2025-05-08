import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_time_ago/get_time_ago.dart';

class SingleTransactionDetails extends StatefulWidget {
  final String type;
  final num amount;
  final DateTime date;
  final String whatType;
  final String name;
  final String notes;
  final num beforeAmount;
  final num afterAmount;

  const SingleTransactionDetails({
    super.key,
    required this.amount,
    required this.date,
    required this.name,
    required this.notes,
    required this.type,
    required this.whatType,
    required this.beforeAmount,
    required this.afterAmount,
  });

  @override
  State<SingleTransactionDetails> createState() =>
      _SingleTransactionDetailsState();
}

class _SingleTransactionDetailsState extends State<SingleTransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark.withOpacity(.6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .035,
                vertical: MediaQuery.of(context).size.height * .015,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Single Transaction Details ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FaIcon(FontAwesomeIcons.x, size: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .035),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type Of Transaction",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${widget.whatType}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amount",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .00,
                            ),
                            Text(
                              "ETB ${widget.amount}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Before Amount",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.beforeAmount.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AfterAmount ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .00,
                            ),
                            Text(
                              widget.afterAmount.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),

                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${widget.date.toLocal().toString().split(" ")[0]} , (${GetTimeAgo.parse(widget.date.toLocal())})",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.type,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),

                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name Of Type",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .93,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Addtional Note",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.notes,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                ),
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
          ),
        ],
      ),
    );
  }
}

// SingleTransactionDetail.dart
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get_time_ago/get_time_ago.dart';

// class SingleTransactionDetails extends StatelessWidget {
//   final String type;
//   final num amount;
//   final DateTime date;
//   final String whatType;
//   final String name;
//   final String notes;
//   final num beforeAmount;
//   final num afterAmount;

//   const SingleTransactionDetails({
//     super.key,
//     required this.type,
//     required this.amount,
//     required this.date,
//     required this.name,
//     required this.notes,
//     required this.whatType,
//     required this.beforeAmount,
//     required this.afterAmount,
//   });

//   Widget _row(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColorDark.withOpacity(.6),
//       body: Column(
//         children: [
//           // tap to dismiss
//           GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Container(height: MediaQuery.of(context).size.height * .41),
//           ),
//           // detail pane
//           Container(
//             height: MediaQuery.of(context).size.height * .59,
//             color: Theme.of(context).scaffoldBackgroundColor,
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * .035,
//               vertical: MediaQuery.of(context).size.height * .015,
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Single Transaction Details",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: FaIcon(FontAwesomeIcons.x, size: 15),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * .035),
//                 _row("Type Of Transaction", whatType),
//                 Divider(),
//                 _row("Amount", "ETB ${amount.toStringAsFixed(2)}"),
//                 Divider(),
//                 _row("Before Amount", "ETB ${beforeAmount.toStringAsFixed(2)}"),
//                 Divider(),
//                 _row("After Amount", "ETB ${afterAmount.toStringAsFixed(2)}"),
//                 Divider(),
//                 _row(
//                   "Date",
//                   "${date.toLocal().toString().split(' ')[0]} (${GetTimeAgo.parse(date)})",
//                 ),
//                 Divider(),
//                 _row("Category", type),
//                 Divider(),
//                 _row("Name Of Type", name),
//                 Divider(),
//                 _row("Additional Note", notes),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
