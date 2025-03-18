import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance/common/loan.dart';
import 'package:flutter_application_1/pages/finance/common/loaninfo.dart';

class Loanpage extends StatefulWidget {
  const Loanpage({super.key});

  @override
  State<Loanpage> createState() => _LoanpageState();
}

class _LoanpageState extends State<Loanpage> {
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
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              LoanWidget(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.008),
              LoanCard(),
              LoanCard(),
              LoanCard(),
              LoanCard(),
              LoanCard(),
              LoanCard(),
              LoanCard(),
              LoanCard(),
              LoanCard(),
              LoanCard(),
              LoanCard(),
            ],
          ),
        ),
      ),
    );
  }
}
