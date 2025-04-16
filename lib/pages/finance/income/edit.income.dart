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

  String? _paidBySelection;
  int? _parentLoanId;
  bool _isLoading = true;

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
    _paidBySelection = paid_from.controller.text;
    _fetchIncome();
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
        // Format date as needed (here, using ISO string split)
        date.controller.text =
            incomeData.date.toIso8601String().split("T").first;
        paid_from.controller.text = incomeData.paidBy;
        specific_from.controller.text = incomeData.specificFrom;
        description.controller.text = incomeData.description;
        _isLoading = false;
      });
    } catch (e) {
      print("Failed to fetch income: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching income")));
      Navigator.pop(context);
    }
  }

  // Helper to format date if needed
  String formatDate(String dateStr) {
    List<String> parts = dateStr.split('-'); // expects DD-MM-YYYY
    if (parts.length < 3) return dateStr;
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    List<String> specificItems = [];
    Map<String, int> partnerMapping = {};
    if (paid_from.controller.text == 'Partner') {
      // partnerMapping logic if needed
    } else if (paid_from.controller.text == 'Bank') {
      specificItems = banks;
    }
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
                    // icon: Icons.fingerprint,
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
                    // icon: Icons.attach_money,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  DateSelector(
                    hintText: "Select a date",
                    controller: date.controller,
                    icon: Icons.calendar_today,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  FutureBuilder(
                    future:
                        _paidBySelection == "Partner"
                            ? widget.datamanager.getLoan()
                            : _paidBySelection == "Bank"
                            ? widget.datamanager.getBanks()
                            : Future.value([]),
                    builder: (context, snapshot) {
                      Map<String, int> partnerMapping = {};
                      List<String>? dynamicItems = [];
                      if (paid_from.controller.text == 'Partner') {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            "Error fetching partner names: ${snapshot.error}",
                          );
                        } else if (snapshot.hasData) {
                          for (Loan loan in snapshot.data as List<Loan>) {
                            partnerMapping[loan.loanerName] = loan.id;
                          }
                          dynamicItems = partnerMapping.keys.toList();
                        }
                      } else if (paid_from.controller.text == 'Bank') {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            "Error fetching banks: ${snapshot.error}",
                          );
                        } else if (snapshot.hasData) {
                          dynamicItems =
                              (snapshot.data as List)
                                  .map((bank) => bank.accountHolder)
                                  .cast<String>()
                                  .toList();
                        }
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            "Paid By",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          CustomDropdown(
                            hintText: "Select an option",
                            icon: Icons.ac_unit_sharp,
                            items: ["Partner", "Bank"],
                            controller: paid_from.controller,
                            onChanged: (value) {
                              setState(() {
                                _paidBySelection = value;
                                paid_from.controller.text = value ?? '';
                                specific_from.controller.clear();
                                _parentLoanId = null;
                              });
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            "Bank Account",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          CustomDropdown(
                            hintText: "Select a specific payer",
                            icon: Icons.account_balance_wallet,
                            items: dynamicItems,
                            controller: specific_from.controller,
                            onChanged: (value) {
                              if (paid_from.controller.text == 'Partner' &&
                                  partnerMapping.containsKey(value!)) {
                                setState(() {
                                  _parentLoanId = partnerMapping[value];
                                });
                              }
                            },
                          ),
                        ],
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
                    hintText: 'description',
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
                            // Simply pop without saving changes
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
