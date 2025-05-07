import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class BankBalance extends StatefulWidget {
  final double total;
  final double expense;
  final double income;
  const BankBalance({
    super.key,
    required this.total,
    required this.expense,
    required this.income,
  });

  @override
  State<BankBalance> createState() => _BankBalanceState();
}

class _BankBalanceState extends State<BankBalance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .95,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .025,
        vertical: MediaQuery.of(context).size.height * .02,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.grey.withOpacity(.2)),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).disabledColor,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .035,
                    vertical: MediaQuery.of(context).size.height * .01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Row(
                        children: [
                          Text(
                            translate('Total Balance'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text(
                            translate('Today'),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .005,
                      ),
                      Text(
                        "\$ ${widget.total}",
                        style: TextStyle(
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
                      color: Color(0xff009966).withOpacity(.1),
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
                      color: Color(0xffFAFAFA).withOpacity(.1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .015),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .035,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .35,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .02,
                    vertical: MediaQuery.of(context).size.height * .01,
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
                        translate("Total Income"),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "+ ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            "${widget.income}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .35,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .02,
                    vertical: MediaQuery.of(context).size.height * .01,
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
                        translate("Total Expenses"),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "- ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "${widget.expense}",
                            style: TextStyle(
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
    );
  }
}
