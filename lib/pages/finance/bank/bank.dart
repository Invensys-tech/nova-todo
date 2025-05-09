import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/finance/bank/addbank.dart';
import 'package:flutter_application_1/pages/finance/bank/editbank.dart';
import 'package:flutter_application_1/pages/finance/common/balance.dart';
import 'package:flutter_application_1/pages/finance/common/bank.dart';
import 'package:flutter_application_1/repositories/bank-repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankPage extends StatefulWidget {
  final Datamanager datamanager;
  const BankPage({super.key, required this.datamanager});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  late Future<List<Bank>> _banksFuture;

  double _totalBankExpense = 0.0;
  double _totalBankIncome = 0.0;

  @override
  void initState() {
    super.initState();
    _banksFuture = Datamanager().getBanks();
    _fetchAndComputeBankStats();
  }

  Future<void> _fetchAndComputeBankStats() async {
    // final expenses = await widget.datamanager.fetchExpense();
    final expenses = await Supabase.instance.client
        .from('expense')
        .select('*')
        .eq('userid', userId);

    final incomes = await Supabase.instance.client
        .from('incomes')
        .select('*')
        .eq('user_id', userId);

    final parsedIncomes =
        (incomes as List)
            .map((e) => Income.fromJson(e as Map<String, dynamic>))
            .toList();
    final parsedExpenses =
        (expenses as List)
            .map((e) => Expense.fromJson(e as Map<String, dynamic>))
            .toList();

    setState(() {
      _totalBankExpense = widget.datamanager.totalBankExpense(parsedExpenses);
      _totalBankIncome = widget.datamanager.totalBankIncome(parsedIncomes);
    });
  }

  void _refreshBanks() {
    setState(() {
      _banksFuture = Datamanager().getBanks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff009966),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          final newBanks =
              await PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: AddBank(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                settings: const RouteSettings(),
              );

          if (newBanks != null) {
            setState(() {
              _banksFuture = Future.value(newBanks);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        child: LiquidPullToRefresh(
          onRefresh: () async {
            _refreshBanks();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<List<Bank>>(
              future: _banksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text("There was an error: ${snapshot.error}");
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("No bank data found.");
                }

                List<Bank> banks = snapshot.data!;
                double totalBalance = banks.fold(
                  0.0,
                  (sum, bank) => sum + bank.balance,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                    BankBalance(
                      total: totalBalance,
                      expense: _totalBankExpense,
                      income: _totalBankIncome,
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: banks.length,
                      itemBuilder: (context, index) {
                        final bank = banks[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slidable(
                              key: ValueKey(bank.id),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                                        context,
                                        screen: EditBank(
                                          bankId: bank.id,
                                          datamanager: widget.datamanager,
                                        ),

                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                        settings: const RouteSettings(),
                                      );
                                    },
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: translate('Edit'),
                                  ),
                                ],
                              ),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext c) {
                                          return AlertDialog(
                                            title: Text(
                                              translate('Confirm Delete'),
                                            ),
                                            content: Text(
                                              translate(
                                                'Are you sure you want to delete this bank?',
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(c).pop();
                                                },
                                                child: Text(
                                                  translate('Cancel'),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  // Navigator.of(dialogCtx).pop();

                                                  final messenger =
                                                      ScaffoldMessenger.of(c);
                                                  final supabase =
                                                      Supabase.instance.client;
                                                  final bankId = bank.id;

                                                  final expenses =
                                                      await supabase
                                                          .from('expense')
                                                          .select('id')
                                                          .eq(
                                                            'bankAccount',
                                                            bankId,
                                                          )
                                                          .limit(1);

                                                  final incomes = await supabase
                                                      .from('incomes')
                                                      .select('id')
                                                      .eq(
                                                        'specific_from',
                                                        bankId,
                                                      )
                                                      .limit(1);

                                                  final loans = await supabase
                                                      .from('loan')
                                                      .select('id')
                                                      .eq(
                                                        'bank',
                                                        bank.accountBank,
                                                      )
                                                      .limit(1);

                                                  if ((expenses as List)
                                                          .isNotEmpty ||
                                                      (incomes as List)
                                                          .isNotEmpty ||
                                                      (loans as List)
                                                          .isNotEmpty) {
                                                    messenger.showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          translate(
                                                            'Cannot delete bank: it has associated expenses or incomes.',
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Colors.redAccent,
                                                      ),
                                                    );
                                                    Navigator.of(c).pop();

                                                    return;
                                                  }

                                                  try {
                                                    await BankRepository()
                                                        .deleteBank(bankId);
                                                    messenger.showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          translate(
                                                            'Bank successfully deleted.',
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    );
                                                    setState(() {});
                                                    Navigator.of(c).pop();
                                                  } catch (e) {
                                                    messenger.showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          translate(
                                                                'Error deleting bank: ',
                                                              ) +
                                                              e.toString(),
                                                        ),
                                                        backgroundColor:
                                                            Colors.redAccent,
                                                      ),
                                                    );
                                                    Navigator.of(c).pop();
                                                  }
                                                },
                                                child: Text(
                                                  translate('Delete'),
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: translate('Delete'),
                                  ),
                                ],
                              ),
                              child: BankWidget(
                                id: bank.id,
                                accountname: bank.accountHolder,
                                accoutnumber: bank.accountNumber,
                                balance: bank.balance,
                                datamanager: widget.datamanager,
                                bankName: bank.accountBank,
                                accountBank: bank.accountBank,
                                branch: bank.branch,
                                balace: bank.balance,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
