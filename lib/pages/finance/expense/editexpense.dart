import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/expense-entity.dart';
import 'package:flutter_application_1/repositories/expense.repository.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EditExpense extends StatefulWidget {
  final Datamanager datamanager;
  final int expenseId;
  const EditExpense({
    Key? key,
    required this.datamanager,
    required this.expenseId,
  }) : super(key: key);

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
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
  bool _isLoading = true;

  final ExpenseRepository _expenseRepository = ExpenseRepository();

  @override
  void initState() {
    super.initState();
    _fetchExpense();
  }

  Future<void> _fetchExpense() async {
    try {
      final expense = await _expenseRepository.getSingleExpense(
        widget.expenseId,
      );
      // Assuming your Expense model has these fields
      _amountController.text = expense.amount.toString();
      _expenseNameController.text = expense.expenseName;
      _expenseCategoryController.text = expense.category;
      _expenseTypeController.text = expense.type;
      _paidByController.text = expense.paidBy;
      _paymentController.text = expense.bankAccount ?? '';
      _descriptionController.text = expense.description;
      _dateController.text = expense.date.toIso8601String().split('T')[0];

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching expense: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xff2F2F2F),
        appBar: AppBar(
          backgroundColor: const Color(0xff2F2F2F),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: const Text(
            "Edit Expense",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xff2F2F2F),
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Edit Expense",
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
                suggestions: [
                  "Orange",
                  "Apple",
                  "Banana",
                  "Mango",
                  "Carrot",
                  "Watermelon",
                  "Grapes",
                  "Dates",
                  "Dragon Fruit",
                ],

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
              // --- Types of Expenses ---
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
              // --- Paid By and Bank Account ---
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              FutureBuilder(
                future:
                    _paidByController.text == "Partner"
                        ? widget.datamanager.getLoan()
                        : _paidByController.text == "Bank"
                        ? widget.datamanager.getBanks()
                        : Future.value([]),
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
                      CustomDropdown(
                        hintText: "Select an option",
                        icon: Icons.ac_unit_sharp,
                        items: ["Partner", "Bank"],
                        controller: _paidByController,
                        onChanged: (value) {
                          setState(() {
                            _paidBySelection = value;
                            _paidByController.text = value ?? '';
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
              // --- Description ---
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
              // --- Buttons ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Cancel changes and navigate back
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
                        try {
                          // Update expense logic using Supabase update operation
                          final response = await Supabase.instance.client
                              .from('expense')
                              .update({
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
                              })
                              .eq('id', widget.expenseId);
                          print(response);
                          print("Expense updated successfully!");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Expense updated successfully!"),
                            ),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          print("Error updating expense: $e");
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
                        "Update Expense",
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
  List<String> parts = date.split('-'); // expects DD-MM-YYYY
  return '${parts[2]}-${parts[1]}-${parts[0]}'; // converts to YYYY-MM-DD
}
