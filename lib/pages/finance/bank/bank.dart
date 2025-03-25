import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/finance/bank/addbank.dart';
import 'package:flutter_application_1/pages/finance/common/balance.dart';
import 'package:flutter_application_1/pages/finance/common/bank.dart';

class BankPage extends StatefulWidget {
  final Datamanager datamanager;
  const BankPage({super.key, required this.datamanager});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  late Future<List<Bank>> _banksFuture;

  @override
  void initState() {
    super.initState();
    _banksFuture = Datamanager().getBanks();
  }

  void _refreshBanks() {
    setState(() {
      _banksFuture = Datamanager().getBanks();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
        ),
        onPressed: () async {
          // Action when pressed

          final newBanks = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBank()),
          );
          if (newBanks != null) {
            setState(() {
              _banksFuture = Future.value(newBanks);
            });
          }

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AddBank(),
          //   ), // Navigate to NewScreen
          // );
        },
        child: Icon(Icons.add), // The icon inside the button
      ),
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

              FutureBuilder(
                future: widget.datamanager.getBanks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var banks = snapshot.data as List<Bank>;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: banks.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BankWidget(
                              accountname: banks[index].accountHolder,
                              accoutnumber: banks[index].accountNumber,
                              balance: banks[index].balance,
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

              // BankWidget(),
              // BankWidget(),
              // BankWidget(),
              // BankWidget(),
              // BankWidget(),
              // BankWidget(),
              // BankWidget(),
              // BankWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
