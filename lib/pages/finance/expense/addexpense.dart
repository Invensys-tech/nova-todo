import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseTypeController = TextEditingController();
  final TextEditingController _expenseCategoryController =
      TextEditingController();
  final TextEditingController _bankAccountCOntroller = TextEditingController();
  final TextEditingController _paidByController = TextEditingController();

  // final TextEditingController _searchController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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
  final _expenseStream = Supabase.instance.client
      .from('expense')
      .stream(primaryKey: ['id']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F2F2F),
      appBar: AppBar(
        backgroundColor: Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Add Expense",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ), // Bold title
        ),
        centerTitle: true,
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
              Text(
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

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
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

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "Category",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              // CustomDropdown(
              //   hintText: "Select an option",
              //   icon: Icons.local_mall,
              //   items: ["Option 1", "Option 2", "Option 3"],
              //   controller: dropdownController,
              // ),
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
                        color: Colors.white, // White text
                      ),
                    ),
                    subtitle: Text(
                      "Tap to select",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey, // Light grey subtitle
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
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
                items: ["Option 1", "Option 2", "Option 3"],
                controller: _expenseTypeController,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
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

              // CustomDropdown(
              //   hintText: "Select an option",
              //   icon: Icons.local_mall,
              //   items: ["Option 1", "Option 2", "Option 3"],
              //   controller: _dropdownController,
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "Paid By",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomDropdown(
                hintText: "Select an option",
                icon: Icons.ac_unit_sharp,
                items: ["Option 1", "Option 2", "Option 3"],
                controller: _paidByController,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "Bank Account",
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
                items: ["Option 1", "Option 2", "Option 3"],
                controller: _bankAccountCOntroller,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [],
              // ),
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
                        _bankAccountCOntroller.clear();
                        _descriptionController.clear();
                        _dateController.clear();
                        _expenseTypeController.clear();
                        _expenseCategoryController.clear();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Gray background
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
                          final response = await Supabase.instance.client
                              .from('expense')
                              .insert({
                                'amount':
                                    double.tryParse(_amountController.text) ??
                                    0.0,
                                'expenseName': _expenseNameController.text,
                                'category': _expenseCategoryController.text,
                                'type': _expenseTypeController.text,
                                'bankAccount': _bankAccountCOntroller.text,
                                'paidBy': _paidByController.text,
                                'description': _descriptionController.text,
                                'date': formatDate(
                                  _dateController.text,
                                ), // Ensure correct format
                              });

                          print(response);

                          // Check if response has an error
                          // if (response == null) {
                          //   print("Error: Response is null");
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text(
                          //         "Failed to add expense. No response received.",
                          //       ),
                          //     ),
                          //   );
                          //   return;
                          // }

                          print("Expense added successfully!");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
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
                        backgroundColor: Colors.green, // Green background
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
