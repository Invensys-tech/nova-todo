import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_time_ago/get_time_ago.dart';

class SingleIcomeFullViewPage extends StatefulWidget {
  final String incomename;
  final num amount;
  final String paidBy;
  final String? accountNumber;
  final String category;
  final DateTime date;
  final String? notes;
  const SingleIcomeFullViewPage({
    super.key,
    required this.incomename,
    required this.amount,
    required this.paidBy,
    this.accountNumber,
    required this.category,
    required this.date,
    this.notes,
  });

  @override
  State<SingleIcomeFullViewPage> createState() =>
      _SingleIcomeFullViewPageState();
}

class _SingleIcomeFullViewPageState extends State<SingleIcomeFullViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark.withOpacity(.6),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .41,
              width: MediaQuery.of(context).size.width * 1,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .59,
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
                      translate("Income Details"),
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
                             translate( "Income Name"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              widget.incomename,
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
                            translate("Amount"),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .00,
                          ),
                          Text(
                            "${translate("ETB")} ${widget.amount}",
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
                              translate("Paid To"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              widget.paidBy,
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
                            translate("Account Number"),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .00,
                          ),
                          Text(
                            "10023289433",
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
                             translate( "Date"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "${widget.date.toLocal().toString().split(' ')[0]} (${GetTimeAgo.parse(widget.date.toLocal())})",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             translate( "Catagory"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              widget.category,
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
                // Divider(),
                //
                // SizedBox(height: MediaQuery.of(context).size.height*.025,),
                // Container(
                //   child: Row(
                //     children: [
                //       Container(
                //         width: MediaQuery.of(context).size.width*.55,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text("Date",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                //             Text("12-08-2025 , 12:43 (last Week)",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                //           ],
                //         ),
                //       ),
                //
                //
                //     ],
                //   ),
                // ),
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
                              translate("Addtional Note"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              widget.notes ?? '',
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
        ],
      ),
    );
  }
}
