import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/common/transaction.dart';
import 'package:flutter_application_1/pages/finance/loan/singleloan.dart';

class LoanView extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final double loanAmount;
  final int parentLoanId;
  final Datamanager datamanager;

  const LoanView({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.loanAmount,
    required this.parentLoanId,
    required this.datamanager,
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
              builder:
                  (context) => SingleLoan(parentLoanId: widget.parentLoanId),
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

              FutureBuilder(
                future: widget.datamanager.getChildLoan(widget.parentLoanId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var childLoans = snapshot.data as List<ChildLoan>;
                    double cumulative = 0;
                    final List<Map<String, double>> cumulativeAmounts = [];
                    for (var loan in childLoans) {
                      double before = cumulative;
                      double after;
                      if (loan.type.toLowerCase() == 'payable') {
                        // If type is Payable, subtract the amount.
                        after = before - loan.amount;
                      } else {
                        // Otherwise, add the amount.
                        after = before + loan.amount;
                      }
                      cumulative = after;
                      cumulativeAmounts.add({"before": before, "after": after});
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: childLoans.length,
                      itemBuilder: (context, index) {
                        final loan = childLoans[index];
                        final amounts = cumulativeAmounts[index];
                        return Column(
                          children: [
                            Transaction(
                              date: childLoans[index].date,
                              amount: childLoans[index].amount,
                              before: amounts["before"]!,
                              after: amounts["after"]!,
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(
                        "There was an error fetching data ${snapshot.error}",
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                },
              ),

              // Transaction(date: '04/2/3455',amount: 500.00,),
            ],
          ),
        ),
      ),
    );
  }
}
