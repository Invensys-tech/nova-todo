import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance/bank/SingleBankFullviewPage.dart';

class BankWidget extends StatefulWidget {
  const BankWidget({
    super.key,
    required this.accountname,
    required this.accoutnumber,
    required this.balance,
  });

  final String accountname;
  final num accoutnumber;
  final num balance;

  @override
  State<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends State<BankWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Singlebankfullviewpage()),
        );
      },
      child: Container(
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
                color: Color(0xff8466fc),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.035),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  '${widget.accountname}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${widget.accoutnumber}',
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
              '${widget.balance}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
