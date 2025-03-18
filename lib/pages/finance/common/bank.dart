import 'package:flutter/material.dart';

class BankWidget extends StatefulWidget {
  const BankWidget({super.key});

  @override
  State<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends State<BankWidget> {
  @override
  Widget build(BuildContext context) {
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
