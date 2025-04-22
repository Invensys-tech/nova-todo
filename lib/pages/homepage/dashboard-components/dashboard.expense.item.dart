import 'package:flutter/material.dart';

class DashboardExpenseItem extends StatelessWidget {
  final dynamic expense;
  const DashboardExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .001),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .02,
              vertical: MediaQuery.of(context).size.height * .01,
            ),
            width: MediaQuery.of(context).size.width * .95,
            decoration: BoxDecoration(
              // color: Color(0xff0d805e).withOpacity(.35),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.withOpacity(.3),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: MediaQuery.of(context).size.width * .02,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF27272A),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        expense['icon'],
                        color: Color(0xFF9F9FA9),
                        size: 20,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense['title'],
                          style: TextStyle(
                            color: Color(0xFFE4E4E7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          expense['date'],
                          style: TextStyle(
                            color: Color(0xFFE4E4E7),
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .0125),
                // Text(

                // ),
                SizedBox(height: MediaQuery.of(context).size.height * .015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   "Status : ",
                        //   style: GoogleFonts.lato(
                        //     fontSize: 13,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Text("\$ ${expense['amount']}"),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xFF009966),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
