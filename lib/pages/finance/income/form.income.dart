import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/income.repository.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class IncomeForm extends StatefulWidget {
  final Datamanager datamanager;
  const IncomeForm({super.key, required this.datamanager});

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
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
      'date': formatDate(date.controller.text),
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
  void initState() {
    super.initState();
    _paidBySelection = paid_from.controller.text;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as String?;
    print('in change dependencies');
    if (args != null) {
      print('found args');
      print(args);
      setState(() {
        amount.controller.text = args;
      });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Add Income",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),

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
                icon: Icons.fingerprint,
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
                icon: Icons.attach_money,
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
                  List<String> dynamicItems = [];

                  if (paid_from.controller.text == 'Partner') {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text(
                        "Error fetching partner names: ${snapshot.error}",
                      );
                    } else if (snapshot.hasData) {
                      // Assume snapshot.data is List<Loan> for partner
                      for (Loan loan in snapshot.data as List<Loan>) {
                        partnerMapping[loan.loanerName] = loan.id;
                      }
                      dynamicItems = partnerMapping.keys.toList();
                    }
                  } else if (paid_from.controller.text == 'Bank') {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error fetching banks: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      // Assume snapshot.data is List<Bank> for banks
                      dynamicItems =
                          (snapshot.data as List<Bank>)
                              .map((bank) => bank.accountHolder)
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
                      // "Paid By" Dropdown remains as before
                      CustomDropdown(
                        hintText: "Select an option",
                        icon: Icons.ac_unit_sharp,
                        items: ["Partner", "Bank"],
                        controller: paid_from.controller,

                        onChanged: (value) {
                          setState(() {
                            _paidBySelection = value;
                            paid_from.controller.text = value ?? '';
                            specific_from.controller
                                .clear(); // Clear previous selection
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
                          // If partner is selected, update _parentLoanId based on partnerMapping.
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
                        // Clear all input controllers

                        setState(() {});
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
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
    );
  }
}
