import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddLoan extends StatefulWidget {
  const AddLoan({super.key});

  @override
  State<AddLoan> createState() => _AddLoanState();
}

class _AddLoanState extends State<AddLoan> {
  @override
  final TextEditingController _loanerName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _bank = TextEditingController();

  final List<String> searchItems = [
    "Abebe",
    "Kebede",
    "Chala",
    "Alemu",
    "Ayele",
  ];

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
          "Add Loan",
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
                "Loaner Name",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              AutoCompleteText(
                suggestions: searchItems,
                controller: _loanerName,
                hintText: "Loaner Name",
                icon: Icons.shopping_bag_rounded,
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
                "Phone Number",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              TextFields(
                hinttext: 'Phone Number',
                whatIsInput: '0',
                controller: _phoneNumber,
                icon: Icons.phone,
              ),

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
                controller: _amount,
                icon: Icons.attach_money,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Text(
                "Types ",
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
                items: ["Payable", "Receivable"],
                controller: _type,
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

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "Bank",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomDropdown(
                hintText: "Select a Bank",
                icon: Icons.local_mall,
                items: [
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
                ],
                controller: _bank,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Clear all input controllers
                        _amount.clear();
                        _bank.clear();
                        _dateController.clear();
                        _loanerName.clear();
                        _type.clear();

                        _phoneNumber.clear();
                        setState(() {});
                        Navigator.pop(context);
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
                              .from('loan')
                              .insert({
                                'amount': double.tryParse(_amount.text) ?? 0.0,
                                'loanerName': _loanerName.text,

                                'type': _type.text,
                                'bank': _bank.text,
                                'phoneNumber': _phoneNumber.text,
                                'userId': 1,
                                'date': formatDate(
                                  _dateController.text,
                                ), // Ensure correct format
                              });

                          print(response);

                          print("Expense added successfully!");
                          final updatedLoans = await Datamanager().fetchLoan();

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Loan added successfully!")),
                          );

                          // Pass the updated loan data back before popping the screen
                          Navigator.pop(context, updatedLoans);
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
                        "Add Loan",
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
