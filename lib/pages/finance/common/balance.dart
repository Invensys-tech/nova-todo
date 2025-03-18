import 'package:flutter/material.dart';

class BankBalance extends StatefulWidget {
  const BankBalance({super.key});

  @override
  State<BankBalance> createState() => _BankBalanceState();
}

class _BankBalanceState extends State<BankBalance> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
