import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/common/loan.dart';
import 'package:flutter_application_1/pages/finance/common/loaninfo.dart';
import 'package:flutter_application_1/pages/finance/loan/addloan.dart';

class Loanpage extends StatefulWidget {
  final Datamanager datamanager;
  const Loanpage({super.key, required this.datamanager});

  @override
  State<Loanpage> createState() => _LoanpageState();
}

class _LoanpageState extends State<Loanpage> {
  late Future<List<Loan>> _loanFuture;

  @override
  void initState() {
    super.initState();
    _loanFuture = Datamanager().getLoan();
  }

  void _refreshLoans() {
    setState(() {
      _loanFuture = Datamanager().getLoan();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newLoans = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddLoan()),
          );

          // If new data is returned, update the UI
          if (newLoans != null) {
            setState(() {
              _loanFuture = Future.value(newLoans);
            });
          }
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),

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

              FutureBuilder(
                future: _loanFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var loans = snapshot.data as List<Loan>;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: loans.length,
                      itemBuilder: (context, index) {
                        return (Column(
                          children: [
                            LoanCard(
                              name: loans[index].loanerName,
                              phoneNumber: loans[index].phoneNumber,
                              loanAmount: loans[index].amount,
                              id: loans[index].id,
                              datamanager: widget.datamanager,
                            ),
                          ],
                        ));
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
            ],
          ),
        ),
      ),
    );
  }
}
