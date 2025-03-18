import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance/common/balance.dart';
import 'package:flutter_application_1/pages/finance/common/bank.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F2F2F),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              BankBalance(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              BankWidget(),
              BankWidget(),
              BankWidget(),
              BankWidget(),
              BankWidget(),
              BankWidget(),
              BankWidget(),
              BankWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
