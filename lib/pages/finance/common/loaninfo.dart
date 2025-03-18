import 'package:flutter/material.dart';

class LoanCard extends StatefulWidget {
  const LoanCard({super.key});

  @override
  State<LoanCard> createState() => _LoanCardState();
}

class _LoanCardState extends State<LoanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.07,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: Color(0xff292929),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "Demeke Zewdu",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.007),

              Text(
                "0911561780",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                '\$ 1,000,000',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.007),

              Text(
                'Payable Loan',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
