import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance/common/transaction.dart';
import 'package:flutter_application_1/pages/finance/loan/singleloan.dart';

class LoanView extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final double loanAmount;

  const LoanView({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.loanAmount,
  }) : super(key: key);

  @override
  State<LoanView> createState() => _LoanViewState();
}

class _LoanViewState extends State<LoanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleLoan(),
            ), // Navigate to NewScreen
          );
        },
        backgroundColor: Colors.green, // Green background
        child: Icon(
          Icons.add,
          color: Colors.white, // White icon color
          size: 30, // Adjust size if needed
        ),
      ),
      backgroundColor: Color(0xff2F2F2F),
      appBar: AppBar(
        backgroundColor: Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Back to Loans",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ), // Bold title
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.045,
                  vertical: MediaQuery.of(context).size.height * 0.0095,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.009,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Alex Jhonson",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.009,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(
                              0.8,
                            ), // Background color
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Rounded corners
                          ),
                          child: Text(
                            "Owes Me",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text(
                              "0911561789",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amount",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text(
                              "\$ 500,000",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Transaction(),
              Transaction(),
              Transaction(),
              Transaction(),
              Transaction(),
            ],
          ),
        ),
      ),
    );
  }
}
