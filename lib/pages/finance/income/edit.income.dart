import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/entities/loan-entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/income.repository.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/ui/inputs/expense-payment.selector.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class EditIncome extends StatefulWidget {
  final int incomeId;
  final Datamanager datamanager;
  const EditIncome({
    super.key,
    required this.incomeId,
    required this.datamanager,
  });

  @override
  State<EditIncome> createState() => _EditIncomeState();
}

class _EditIncomeState extends State<EditIncome> {
  final name = FormInput(
    label: "Income Name",
    hint: "Income Name",
    type: "1",
    controller: TextEditingController(),
  );
  final category = FormInput(
    label: "Category",
    hint: "Category",
    type: "1",
    controller: TextEditingController(),
  );
  final amount = FormInput(
    label: "Amount",
    hint: "Amount",
    type: "0",
    controller: TextEditingController(),
  );
  final date = FormInput(
    label: "Date",
    hint: "Date",
    type: "1",
    controller: TextEditingController(),
  );
  final paid_from = FormInput(
    label: "Paid From",
    hint: "Paid From",
    type: "1",
    controller: TextEditingController(),
  );
  final specific_from = FormInput(
    label: "Specific From",
    hint: "Specific From",
    type: "1",
    controller: TextEditingController(),
  );
  final description = FormInput(
    label: "Description",
    hint: "Description",
    type: "1",
    controller: TextEditingController(),
  );

  bool _isLoading = true;
  String? _paidBySelection;
  int? _parentLoanId;
  Future<List<dynamic>>? _dataFuture;

  // Same bank list as in IncomeForm (used for the "Paid By" dropdown)
  final List<String> banks = [
    'Abay Bank',
    'Addis International Bank',
    'Ahadu Bank',
    'Amhara Bank',
    'Awash Bank',
    'Bank of Abyssinia',
    'Berhan Bank',
    'Bunna Bank',
    'Commercial Bank of Ethiopia',
    'Cooperative Bank of Oromia',
    'Dashen Bank',
    'Development Bank of Ethiopia',
    'Gadaa Bank',
    'Hibret Bank',
    'Lion International Bank',
    'NIB International Bank',
    'Oromia International Bank',
    'Rammis Bank',
    'Sidama Bank',
    'Siket Bank',
    'Tsedey Bank',
    'Tsehay Bank',
    'Wegagen Bank',
    'Zemen Bank',
  ];

  @override
  void initState() {
    super.initState();
    // Initial selection value based on controller text
    _paidBySelection = paid_from.controller.text;
    _fetchIncome();
  }

  void _updateFuture() {
    if (paid_from.controller.text == "Partner") {
      _dataFuture = widget.datamanager.getLoan();
    } else if (paid_from.controller.text == "Bank") {
      _dataFuture = widget.datamanager.getBanks();
    } else {
      _dataFuture = Future.value([]);
    }
  }

  Future<void> _fetchIncome() async {
    try {
      final data =
          await supabaseClient
              .from(Entities.INCOME.dbName)
              .select('*')
              .eq('id', widget.incomeId)
              .maybeSingle();
      if (data == null) throw Exception("Income not found");
      Income incomeData = Income.fromJson(data);
      setState(() {
        name.controller.text = incomeData.name;
        category.controller.text = incomeData.category;
        amount.controller.text = incomeData.amount.toString();
        // Format the date to match your date selector widget (e.g., YYYY-MM-DD)
        date.controller.text =
            incomeData.date.toIso8601String().split("T").first;
        paid_from.controller.text = incomeData.paidBy;
        specific_from.controller.text = incomeData.specificFrom;
        description.controller.text = incomeData.description;
        _isLoading = false;
        // Initialize future based on the paid_from value now
        _updateFuture();
      });
    } catch (e) {
      print("Failed to fetch income: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error fetching income")));
      Navigator.pop(context);
    }
  }

  // Helper to format date if needed (here assuming input in YYYY-MM-DD)
  String formatDate(String dateStr) {
    // You can enhance this function if you need a different format
    return dateStr;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
          backgroundColor: const Color(0xff2F2F2F),
          appBar: AppBar(
            backgroundColor: const Color(0xff2F2F2F),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const Text(
              "Edit Income",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: const Center(child: CircularProgressIndicator()),
        )
        : Scaffold(
          backgroundColor: const Color(0xff2F2F2F),
          appBar: AppBar(
            backgroundColor: const Color(0xff2F2F2F),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const Text(
              "Edit Income",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Income Name",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFields(
                    hinttext: name.hint,
                    controller: name.controller,
                    whatIsInput: name.type,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Amount",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFields(
                    hinttext: amount.hint,
                    whatIsInput: amount.type,
                    controller: amount.controller,
                    prefixText: 'ETB',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            // Optionally you can add an autocomplete widget here like in your add form
                            TextFields(
                              hinttext: category.hint,
                              controller: category.controller,
                              whatIsInput: category.type,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            DateSelector(
                              hintText: "Select a date",
                              controller: date.controller,
                              icon: Icons.calendar_today,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: DateTime.now(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Use the same custom widget from add income for "Paid By" and "Specific From"
                  FutureBuilder(
                    future: _dataFuture,
                    builder: (context, snapshot) {
                      // return Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     SizedBox(
                      //       height: MediaQuery.of(context).size.height * 0.02,
                      //     ),
                      //     PaidByAndSpecificFromInput(
                      //       paidByController: paid_from.controller,
                      //       specificFromController: specific_from.controller,
                      //       dataFuture: _dataFuture ?? Future.value([]),
                      //       // When Paid By changes, update the future.
                      //       onPaidByChanged: (newPaidBy) {
                      //         setState(() {
                      //           _updateFuture();
                      //         });
                      //       },
                      //     ),
                      //     SizedBox(
                      //       height: MediaQuery.of(context).size.height * 0.02,
                      //     ),
                      //     // Additional UI elements…
                      //   ],
                      // );
                      // Deal with this later
                      return PaidByAndSpecificFromInput(
                        paidByController: paid_from.controller,
                        specificFromController: specific_from.controller,
                        dataFuture: _dataFuture ?? Future.value([]),
                        onPaidByChanged: (newPaidBy) {
                          setState(() {
                            paid_from.controller.text = newPaidBy ?? '';
                            // Clear previous selection when this changes.
                            specific_from.controller.clear();
                            _parentLoanId = null;
                            _updateFuture();
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  MultiLineTextField(
                    hintText: description.hint,
                    controller: description.controller,
                    icon: Icons.description,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Cancel editing
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> updatedIncome = {
                              "name": name.controller.text,
                              "category": category.controller.text,
                              "date": formatDate(date.controller.text),
                              "paid_from": paid_from.controller.text,
                              "specific_from": specific_from.controller.text,
                              "amount": amount.controller.text,
                              "description": description.controller.text,
                            };
                            try {
                              await IncomeRepository().editIncome(
                                widget.incomeId,
                                updatedIncome,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Income updated successfully!"),
                                ),
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            "Update Income",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                ],
              ),
            ),
          ),
        );
  }
}
