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
    _bankView = widget.datamanager.fetchBankView(widget.id, widget.name);
  }

  /// Builds each row, now taking before/after amounts.
  Widget _buildTransactionRow({
    Income? income,
    Expense? expense,
    required String transactionType, // "expense" or "income"
    required String title,
    required String date,
    required num amount,
    required num beforeAmount,
    required num afterAmount,
  }) {
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
            barrierColor: Colors.black.withOpacity(0.5),
            pageBuilder:
                (_, __, ___) => SingleTransactionDetails(
                  type: transactionType,
                  amount: amount,
                  date: expense?.date ?? income?.date ?? DateTime.now(),
                  name: expense?.expenseName ?? income?.name ?? '',
                  notes: expense?.description ?? income?.description ?? '',
                  whatType: transactionType == "income" ? "Debit" : "Credit",
                  beforeAmount: beforeAmount,
                  afterAmount: afterAmount,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$sign \$${amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: amountColor,
                  ),
                ),
              ],
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
                          Colors.grey.withOpacity(0.5),
                          BlendMode.modulate,
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

            FutureBuilder<Map<String, dynamic>>(
              future: _bankView,
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting)
                  return const Center(child: CircularProgressIndicator());
                if (snap.hasError || snap.data == null)
                  return Center(child: Text("Error: ${snap.error}"));

                final bank = snap.data!['bank'] as Bank;
                final expenses =
                    (snap.data!['expenses'] as List)
                        .map((e) => Expense.fromJson(e))
                        .toList();
                final incomes =
                    (snap.data!['incomes'] as List)
                        .map((e) => Income.fromJson(e))
                        .toList();

                // merge & sort
                final all = <_Tx>[];
                for (var e in expenses) {
                  all.add(
                    _Tx(
                      date: e.date,
                      amount: e.amount,
                      type: 'expense',
                      obj: e,
                    ),
                  );
                }
                for (var i in incomes) {
                  all.add(
                    _Tx(date: i.date, amount: i.amount, type: 'income', obj: i),
                  );
                }

                // merge & sort ascending
                all.sort((a, b) => a.date.compareTo(b.date));

                // compute net change of every tx
                final netChange = all.fold<num>(
                  0,
                  (sum, tx) =>
                      sum + (tx.type == 'income' ? tx.amount : -tx.amount),
                );

                // opening balance = current balance minus everything that’s happened since
                num running = widget.balace - netChange;

                final views = <_View>[];
                for (var tx in all) {
                  final before = running;
                  final after =
                      tx.type == 'income'
                          ? before + tx.amount
                          : before - tx.amount;
                  views.add(_View(tx: tx, before: before, after: after));
                  running = after;
                }

                // all.sort((a, b) => a.date.compareTo(b.date));

                // // running balance
                // num running = widget.balace;
                // final views = <_View>[];
                // for (var tx in all) {
                //   final before = running;
                //   final after =
                //       tx.type == 'income'
                //           ? before + tx.amount
                //           : before - tx.amount;
                //   views.add(_View(tx: tx, before: before, after: after));
                //   running = after;
                // }

                print("Before and after");
                print(views);

                return Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .03),

                    Container(
                      width: MediaQuery.of(context).size.width * .95,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .025,
                        vertical: MediaQuery.of(context).size.height * .02,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.grey.withOpacity(.2)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).disabledColor,
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                        .035,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                        .01,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            .01,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            translate('Total Balance'),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            translate('Today'),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
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
                                            MediaQuery.of(context).size.height *
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
                                  top: MediaQuery.of(context).size.height * .03,
                                  left: MediaQuery.of(context).size.width * .4,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff009966).withOpacity(.1),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: MediaQuery.of(context).size.height * .05,
                                  left: MediaQuery.of(context).size.width * .5,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .35,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        .15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFAFAFA).withOpacity(.1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .035,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .82,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * .02,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                        .01,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(.2),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
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
                                            widget.accountNumber.toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
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

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children:
                            views.map((v) {
                              final tx = v.tx;
                              final title =
                                  tx.type == 'income'
                                      ? "Income: ${(tx.obj as Income).name}"
                                      : "${(tx.obj as Expense).expenseName}";
                              final dateStr =
                                  tx.date.toLocal().toString().split(' ')[0];
                              return _buildTransactionRow(
                                income:
                                    tx.type == 'income'
                                        ? tx.obj as Income
                                        : null,
                                expense:
                                    tx.type == 'expense'
                                        ? tx.obj as Expense
                                        : null,
                                transactionType: tx.type,
                                title: title,
                                date: dateStr,
                                amount: tx.amount,
                                beforeAmount: v.before,
                                afterAmount: v.after,
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Tx {
  final DateTime date;
  final num amount;
  final String type;
  final Object obj;
  _Tx({
    required this.date,
    required this.amount,
    required this.type,
    required this.obj,
  });
}

class _View {
  final _Tx tx;
  final num before, after;
  _View({required this.tx, required this.before, required this.after});
}
