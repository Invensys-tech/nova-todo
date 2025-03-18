import 'package:flutter/material.dart';

class LoanWidget extends StatefulWidget {
  const LoanWidget({super.key});

  @override
  State<LoanWidget> createState() => _LoanWidgetState();
}

class _LoanWidgetState extends State<LoanWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
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
          Text(
            "Total Amounts of Loan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.009),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "\$ 2000",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              Text(
                "Total Amounts of Loan",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.height * 0.035,
                    decoration: BoxDecoration(
                      color: Color(0xFF474646),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.trending_up,
                      color: Colors.green,
                      size: MediaQuery.of(context).size.height * 0.032,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Receivable Loan",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        "15,000",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.height * 0.035,
                    decoration: BoxDecoration(
                      color: Color(0xFF474646),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.trending_down,
                      color: Colors.red,
                      size: MediaQuery.of(context).size.height * 0.032,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Payable Loan",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        "15,000",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
