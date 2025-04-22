import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/income.repository.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/expense-payment.selector.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/testdate.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../main.dart';

class IncomeForm extends StatefulWidget {
  final Datamanager datamanager;
  const IncomeForm({super.key, required this.datamanager});

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  bool isFromNotification = false;
  List<Income> _incomeList = [];

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

  saveIncome() async {
    print("Income data ${specific_from.controller.text}");
    Income income = await IncomeRepository().createIncome({
      "name": name.controller.text,
      'category': category.controller.text,
      'date': (date.controller.text),
      'paid_from': paid_from.controller.text,
      "specific_from": specific_from.controller.text,
      "amount": amount.controller.text,
      'user_id': 1,
      'description': description.controller.text,
    });
    print("Income Saved");
  }

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
  // void initState() {
  //   super.initState();
  //   _paidBySelection = paid_from.controller.text;
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as String?;
    // print('in change dependencies');
    if (args != null) {
      // print('found args');
      // print(args);
      setState(() {
        paid_from.controller.text == 'Bank';
        isFromNotification = true;
        amount.controller.text = args;
      });
    }
  }

  final List<String> searchItems = [
    "Orange",
    "Apple",
    "Banana",
    "Mango",
    "Carrot",
    "Watermelon",
    "Grapes",
    "Dates",
    "Dragon Fruit",
  ];
  Future<List<dynamic>>? _dataFuture;

  @override
  void initState() {
    super.initState();
    _updateFuture();
    _loadIncomeList();
  }

  void _loadIncomeList() async {
    _incomeList = await IncomeRepository().getIncome(null);
    setState(() {}); // Rebuild to show autocomplete suggestions
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

  @override
  Widget build(BuildContext context) {
    List<String> specificItems = [];
    Map<String, int> partnerMapping = {};
    if (paid_from.controller.text == 'Partner') {
    } else if (paid_from.controller.text == 'Bank') {
      specificItems = banks;
    }

    if (isFromNotification) {
      specificItems = banks;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 25,
            color: Color(0xff006045),
          ),
        ),
        title: const Text(
          "Add Income",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),

          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Color(0xff27272A) : Color(0xFFF4F4F5),
              border: Border.all(
                color: Colors.grey.withOpacity(.3), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(
                8,
              ), // Optional: rounded corners
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  "Income Name",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                TextFields(
                  hinttext: name.hint,
                  controller: name.controller,
                  whatIsInput: name.type,
                  // icon: Icons.fingerprint,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  "Amount",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                TextFields(
                  hinttext: amount.hint,
                  whatIsInput: amount.type,
                  controller: amount.controller,
                  prefixText: 'ETB',
                  // icon: Icons.attach_money,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0025,
                          ),
                          _incomeList.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : AutoCompleteText(
                                suggestions:
                                    _incomeList
                                        .map((income) => income.category)
                                        .toSet()
                                        .toList(),
                                controller: category.controller,
                                hintText: "Search for a Category...",
                                icon: Icons.search,
                                suggestionBuilder: (String text) {
                                  return ListTile(
                                    title: Text(
                                      text,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                        ],
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * .05),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0025,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .05,
                            child: DateSelector(
                              hintText: DateTime.now().toString(),
                              controller: date.controller,
                              icon: Icons.calendar_today,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                FutureBuilder(
                  future: _dataFuture,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        PaidByAndSpecificFromInput(
                          paidByController: paid_from.controller,
                          specificFromController: specific_from.controller,
                          dataFuture: _dataFuture ?? Future.value([]),
                          // When Paid By changes, update the future.
                          onPaidByChanged: (newPaidBy) {
                            setState(() {
                              _updateFuture();
                            });
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        // Additional UI elements…
                      ],
                    );
                  },
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
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
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          // Clear all input controllers

                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDark ? Color(0xff27272A) : Color(0xffD4D4D8),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // Insert expense
                            saveIncome();

                            print("Income added successfully!");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Expense added successfully!"),
                              ),
                            );

                            Navigator.pop(context);
                          } catch (e) {
                            print("Error inserting expense: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff009966),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Add Expense",
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
      ),
    );
  }
}
