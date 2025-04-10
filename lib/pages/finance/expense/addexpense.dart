import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddExpense extends StatefulWidget {
  final Datamanager datamanager;
  const AddExpense({super.key, required this.datamanager});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseTypeController = TextEditingController();
  final TextEditingController _expenseCategoryController =
      TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _paidByController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? _paidBySelection;
  int? _parentLoanId;

  final List<String> searchNames = [
    "Abebe",
    "Kebede",
    "Chala",
    "Alemu",
    "Ayele",
  ];

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

  bool isFromNotification = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as String?;
    // print('in change dependencies');
    if (args != null) {
      // print('found args');
      // print(args);
      setState(() {
        isFromNotification = true;
        _paidByController.text = 'Bank';
        _amountController.text = args;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> specificItems = [];
    Map<String, int> partnerMapping = {};
    if (_paidByController.text == 'Partner') {
    } else if (_paidByController.text == 'Bank') {
      specificItems = banks;
    }

    return Scaffold(
      backgroundColor: const Color(0xff2F2F2F),
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Add Expense",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Amount Field ---
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
                hinttext: '0.0',
                whatIsInput: '0',
                controller: _amountController,
                icon: Icons.attach_money,
              ),
              // --- Expense Name Field ---
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                "Expense Name",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFields(
                hinttext: 'Lunch At Bole',
                whatIsInput: '1',
                controller: _expenseNameController,
                icon: Icons.fingerprint,
              ),
              // --- Category ---
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AutoCompleteText(
                suggestions: searchItems,
                controller: _expenseCategoryController,
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
                    subtitle: const Text(
                      "Tap to select",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                "Types of Expenses",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomDropdown(
                hintText: "Select an option",
                icon: Icons.local_mall,
                items: ["Must", "Maybe", "Unwanted"],
                controller: _expenseTypeController,
              ),
              // --- Date ---
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
                controller: _dateController,
                icon: Icons.calendar_today,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDate: DateTime.now(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              FutureBuilder(
                // Use different futures based on the "Paid By" selection.
                future:
                    _paidByController.text == "Partner"
                        ? widget.datamanager.getLoan()
                        : _paidByController.text == "Bank"
                        ? widget.datamanager.getBanks()
                        : Future.value(
                          [],
                        ), // if nothing selected, return empty list
                builder: (context, snapshot) {
                  Map<String, int> partnerMapping = {};
                  List<String> dynamicItems = [];

                  if (_paidByController.text == 'Partner') {
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
                  } else if (_paidByController.text == 'Bank') {
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
                        controller: _paidByController,
                        selectedValue: isFromNotification ? 'Bank' : null,
                        onChanged: (value) {
                          setState(() {
                            _paidBySelection = value;
                            _paidByController.text = value ?? '';
                            // Clear payment selection when switching modes.
                            _paymentController.clear();
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
                        controller: _paymentController,
                        onChanged: (value) {
                          // If partner is selected, update _parentLoanId based on partnerMapping.
                          if (_paidByController.text == 'Partner' &&
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
                controller: _descriptionController,
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
                        _amountController.clear();
                        _expenseNameController.clear();
                        _paidByController.clear();
                        _paymentController.clear();
                        _descriptionController.clear();
                        _dateController.clear();
                        _expenseTypeController.clear();
                        _expenseCategoryController.clear();
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
                          final expenseResponse = await Supabase.instance.client
                              .from('expense')
                              .insert({
                                'amount':
                                    double.tryParse(_amountController.text) ??
                                    0.0,
                                'expenseName': _expenseNameController.text,
                                'category': _expenseCategoryController.text,
                                'type': _expenseTypeController.text,
                                'bankAccount':
                                    _paidByController.text == "Partner"
                                        ? null
                                        : _paymentController.text,

                                'paidBy': _paidByController.text,
                                'description': _descriptionController.text,
                                'date': formatDate(_dateController.text),
                                'userid': 1,
                              });
                          print(expenseResponse);
                          print("Expense added successfully!");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Expense added successfully!"),
                            ),
                          );

                          if (_paidByController.text == "Partner") {
                            final singleLoanResponse = await Supabase
                                .instance
                                .client
                                .from('single_loan')
                                .insert({
                                  'amount':
                                      double.tryParse(_amountController.text) ??
                                      0.0,
                                  'type': "Payable",
                                  'paidFrom': "Partner",
                                  'specificFrom': _paymentController.text,
                                  'parentId': _parentLoanId,
                                  'date': formatDate(_dateController.text),
                                  'source': "Expense",
                                });
                            print('-----------------------------------------');
                            print(singleLoanResponse);
                            print('-----------------------------------------');
                          }
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

String formatDate(String date) {
  List<String> parts = date.split('-'); // Split DD-MM-YYYY
  return '${parts[2]}-${parts[1]}-${parts[0]}'; // Convert to YYYY-MM-DD
}
