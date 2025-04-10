import 'package:flutter/material.dart';

class ExpensesWidget extends StatefulWidget {
  final num expenseCount;
  final String category;
  final num amount;
  ExpensesWidget({
    super.key,
    required this.expenseCount,
    required this.category,
    required this.amount,
  });

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.073,
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
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.height * 0.045,
            decoration: BoxDecoration(
              color: Color(0xff057939),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.local_pizza, color: Colors.deepOrange, size: 24),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.035),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "${widget.category}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              Text(
                "${widget.expenseCount} Expenses",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '\$ ${widget.amount}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .015),
          Icon(
            Icons.chevron_right,
            size: 25,
            color: Colors.white.withOpacity(.8),
          ),
        ],
      ),
    );
  }
}
