import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/bank/SingleTransactionDetail.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Singlebankfullviewpage extends StatefulWidget {
  final int id;
  final String name;
  final Datamanager datamanager;
  final String accountBank;
  final String branch;
  final num balace;
  final num accountNumber;

  const Singlebankfullviewpage({
    super.key,
    required this.id,
    required this.name,
    required this.datamanager,
    required this.accountBank,
    required this.branch,
    required this.balace,
    required this.accountNumber,
  });

  @override
  State<Singlebankfullviewpage> createState() => _SinglebankfullviewpageState();
}

class _SinglebankfullviewpageState extends State<Singlebankfullviewpage> {
  late Future<Map<String, dynamic>> _bankView;

  @override
  void initState() {
    super.initState();
    // fetch the bank view using the provided id and name from widget
    _bankView = widget.datamanager.fetchBankView(widget.id, widget.name);
    print("Whod dis");
    print(_bankView);
  }

  // Unified widget to build a transaction row for both expenses and incomes.
  Widget _buildTransactionRow({
    Income? income,
    Expense? expense,
    required String transactionType, // "expense" or "income"
    required String title,
    required String date,
    required num amount,
  }) {
    print("what ois this ");
    print(income?.toJson());
    print(expense);
    final isIncome = transactionType == "income";
    final iconData = isIncome ? Icons.arrow_upward : Icons.arrow_downward;
    final iconColor = isIncome ? Colors.green : Colors.red;
    final sign = isIncome ? "+" : "-";
    final amountColor = isIncome ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.black.withOpacity(0.5), // background dim
            pageBuilder:
                (_, __, ___) => SingleTransactionDetails(
                  amount:
                      transactionType == "income"
                          ? (income?.amount ?? 0)
                          : (expense?.amount ?? 0),
                  // date: DateTime.now(),
                  date: expense?.date ?? income?.date ?? DateTime.now(),
                  name: expense?.expenseName ?? income?.name ?? '',
                  notes: expense?.description ?? income?.description ?? '',
                  type: transactionType,
                  whatType: transactionType == "income" ? "Debit" : "Credit",
                ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(.2)),
        ),
        child: Row(
          children: [
            Icon(iconData, color: iconColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "$sign \$${amount}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: amountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .02,
                vertical: MediaQuery.of(context).size.height * .01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_left,
                          size: 30,
                          color: Color(0xff009966),
                        ),
                        Text(
                          widget.accountBank,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .0175,
                          ),
                          Text(
                            "${widget.branch} brnach",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "Created at 12-02-2015",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * .02),
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.grey.withOpacity(
                            0.5,
                          ), // Choose your color and opacity
                          BlendMode
                              .modulate, // Or try `BlendMode.color` or others
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.045,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                "https://combanketh.et/cbeapi/uploads/logo_1ae2fb1df4.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 0),
                  FutureBuilder<Map<String, dynamic>>(
                    future: _bankView,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text("No Data Found"));
                      } else {
                        // Extract bank details and transactions
                        final bank = snapshot.data!['bank'] as Bank;
                        final List<Expense> expenseData =
                            (snapshot.data!['expenses'] as List<dynamic>)
                                .map(
                                  (e) => Expense.fromJson(
                                    e as Map<String, dynamic>,
                                  ),
                                )
                                .toList();
                        final List<Income> incomeList =
                            (snapshot.data!['incomes'] as List<dynamic>)
                                .map(
                                  (e) => Income.fromJson(
                                    e as Map<String, dynamic>,
                                  ),
                                )
                                .toList();
                        print(expenseData);
                        print(incomeList);
                        print("object");
                        return Column(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * .2675,
                              width: MediaQuery.of(context).size.width * .95,
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .025,
                                vertical:
                                    MediaQuery.of(context).size.height * .02,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(.2),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        .12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .035,
                                            vertical:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                .01,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    .01,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    translate('Total Balance'),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    translate('Today'),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    .005,
                                              ),
                                              Text(
                                                "ETB ${widget.balace}",
                                                style: TextStyle(
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              .03,
                                          left:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              .4,
                                          child: Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .3,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                .1,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(
                                                0xff009966,
                                              ).withOpacity(.1),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              .05,
                                          left:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              .5,
                                          child: Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .35,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                .15,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(
                                                0xffFAFAFA,
                                              ).withOpacity(.1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        .015,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                          .035,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              .09,
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              .82,
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .02,
                                            vertical:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                .01,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey.withOpacity(
                                                .2,
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.name,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    widget.accountNumber
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .015,
                            ),

                            // Transactions Section
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const Text(
                                  //   "Expenses",
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  // Display expenses using the unified transaction widget
                                  ...expenseData.map((expense) {
                                    // Adjust field names as needed; assuming expense JSON has keys:
                                    // 'bankAccount', 'date', 'amount'
                                    return _buildTransactionRow(
                                      expense: expense as Expense,
                                      transactionType: "expense",
                                      title:
                                          "${expense.expenseName ?? 'Unknown'}",
                                      date:
                                          "${expense.date.toLocal()}".split(
                                            ' ',
                                          )[0],
                                      amount: expense.amount ?? 0,
                                    );
                                  }).toList(),
                                  // const SizedBox(height: 16),
                                  // const Text(
                                  //   "Incomes",
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  // Display incomes using the unified transaction widget
                                  ...incomeList.map((income) {
                                    // Convert the date to a readable format if needed.
                                    String formattedDate =
                                        "${income.date.toLocal()}".split(
                                          ' ',
                                        )[0];
                                    return _buildTransactionRow(
                                      income: income,
                                      transactionType: "income",
                                      title: "Income: ${income.name}",
                                      date: formattedDate,
                                      amount: income.amount,
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
