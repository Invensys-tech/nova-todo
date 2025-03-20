// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/ui/inputs/dateselector.dart';
// import 'package:flutter_application_1/ui/inputs/dropdown.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';

// class SingleLoan extends StatefulWidget {
//   const SingleLoan({super.key});

//   @override
//   State<SingleLoan> createState() => _SingleLoanState();
// }

// class _SingleLoanState extends State<SingleLoan> {
//   final TextEditingController _phoneNumber = TextEditingController();
//   final TextEditingController _amount = TextEditingController();
//   final TextEditingController _type = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _bank = TextEditingController();
//   final TextEditingController _paidFrom = TextEditingController();
//   final TextEditingController _specificFrom = TextEditingController();

//   final List<String> searchNames = [
//     "Abebe",
//     "Kebede",
//     "Chala",
//     "Alemu",
//     "Ayele",
//   ];

//   final List<String> banks = [
//     'Abay Bank',
//     'Addis International Bank',
//     'Ahadu Bank',
//     'Amhara Bank',
//     'Awash Bank',
//     'Bank of Abyssinia',
//     'Berhan Bank',
//     'Bunna Bank',
//     'Commercial Bank of Ethiopia',
//     'Cooperative Bank of Oromia',
//     'Dashen Bank',
//     'Development Bank of Ethiopia',
//     'Gadaa Bank',
//     'Hibret Bank',
//     'Lion International Bank',
//     'NIB International Bank',
//     'Oromia International Bank',
//     'Rammis Bank',
//     'Sidama Bank',
//     'Siket Bank',
//     'Tsedey Bank',
//     'Tsehay Bank',
//     'Wegagen Bank',
//     'Zemen Bank',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff2F2F2F),
//       appBar: AppBar(
//         backgroundColor: Color(0xff2F2F2F),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: Text(
//           "Add Loan",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ), // Bold title
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.045,
//         ),
//         child: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               Text(
//                 "Amount",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               TextFields(
//                 hinttext: '0.0',
//                 whatIsInput: '0',
//                 controller: _amount,
//                 icon: Icons.attach_money,
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//               Text(
//                 "Types ",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               CustomDropdown(
//                 hintText: "Select an option",
//                 icon: Icons.local_mall,
//                 items: ["Payable", "Receivable"],
//                 controller: _type,
//               ),

//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//               Text(
//                 "Date",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               DateSelector(
//                 hintText: "Select a date",
//                 controller: _dateController,
//                 icon: Icons.calendar_today,
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2100),
//                 initialDate: DateTime.now(),
//               ),

//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//               Text(
//                 "Types ",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               CustomDropdown(
//                 hintText: "Select an option",
//                 icon: Icons.local_mall,
//                 items: ["Partner", "Bank"],
//                 controller: _paidFrom,
//               ),

//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//               Text(
//                 "Specific From ",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               CustomDropdown(
//                 hintText: "Select an option",
//                 icon: Icons.account_balance,
//                 items:
//                     _paidFrom.text == "Partner"
//                         ? searchNames
//                         : _paidFrom.text == "Bank"
//                         ? banks
//                         : [],
//                 controller: _specificFrom,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SingleLoan extends StatefulWidget {
  const SingleLoan({super.key});

  @override
  State<SingleLoan> createState() => _SingleLoanState();
}

class _SingleLoanState extends State<SingleLoan> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _paidFrom = TextEditingController();
  final TextEditingController _specificFrom = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    // Determine items for the "Specific From" dropdown based on _paidFrom value
    List<String> specificItems = [];
    if (_paidFrom.text == "Partner") {
      specificItems = searchNames;
    } else if (_paidFrom.text == "Bank") {
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
          "Add Loan",
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
                controller: _amount,
                icon: Icons.attach_money,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                "Type",
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
              const Text(
                "Paid From",
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
                items: ["Partner", "Bank"],
                controller: _paidFrom,
                onChanged: (value) {
                  // Trigger rebuild when _paidFrom changes
                  setState(() {});
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                "Specific From",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomDropdown(
                hintText: "Select an option",
                icon: Icons.account_balance,
                items: specificItems,
                controller: _specificFrom,
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
                        _specificFrom.clear();
                        _dateController.clear();
                        _paidFrom.clear();
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
                              .from('single_loan')
                              .insert({
                                'amount': double.tryParse(_amount.text) ?? 0.0,

                                'type': _type.text,
                                'paidFrom': _paidFrom.text,
                                'specificFrom': _specificFrom.text,
                                'parentId': 1,
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
                              content: Text("Child Loan added successfully!"),
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
