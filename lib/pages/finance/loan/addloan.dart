// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/datamanager.dart';
// import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
// import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
// import 'package:flutter_application_1/ui/inputs/dateselector.dart';
// import 'package:flutter_application_1/ui/inputs/loandate.dart';
// import 'package:flutter_application_1/ui/inputs/loantype.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AddLoan extends StatefulWidget {
//   const AddLoan({super.key});

//   @override
//   State<AddLoan> createState() => _AddLoanState();
// }

// class _AddLoanState extends State<AddLoan> {
//   final TextEditingController _loanerName = TextEditingController();
//   final TextEditingController _phoneNumber = TextEditingController();
//   final TextEditingController _amount = TextEditingController();
//   final TextEditingController _type = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   // We'll no longer use a static list for bank; instead,
//   // _bank controller will hold the selected bank's name.
//   final TextEditingController _bank = TextEditingController();

//   final List<String> searchItems = [
//     "Abebe",
//     "Kebede",
//     "Chala",
//     "Alemu",
//     "Ayele",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff2F2F2F),
//       appBar: AppBar(
//         backgroundColor: const Color(0xff2F2F2F),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: const Text(
//           "Add Loan",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.045,
//         ),
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: const Color(0xff27272A), // Border color
//                 width: 1.0, // Border width
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Loan type selector as before
//                 TypeSelector(controller: _type),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 const Text(
//                   "Loaner Name",
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.white70,
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//                 FutureBuilder(
//                   future: Datamanager().getLoan(),
//                   builder: (context, snapshot) {
//                     List<String> loanerNames = [];

//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Center(child: CircularProgressIndicator()),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Error fetching banks",
//                           style: TextStyle(color: Colors.white70),
//                         ),
//                       );
//                     } else if (snapshot.hasData) {
//                       loanerNames =
//                           (snapshot.data as List)
//                               .map((loan) => loan.loanerName as String)
//                               .toList();
//                     }
//                     return AutoCompleteText(
//                       suggestions: loanerNames,
//                       controller: _loanerName,
//                       hintText: "Loaner Name",
//                       icon: Icons.shopping_bag_rounded,
//                       suggestionBuilder: (String text) {
//                         return ListTile(
//                           title: Text(
//                             text,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 const Text(
//                   "Phone Number",
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.white70,
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 TextFields(
//                   hinttext: 'Phone Number',
//                   whatIsInput: '0',
//                   controller: _phoneNumber,
//                   prefixText: '+251',
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 const Text(
//                   "Amount",
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.white70,
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 TextFields(
//                   hinttext: '0.0',
//                   whatIsInput: '0',
//                   controller: _amount,
//                   prefixText: 'ETB',
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 const Text(
//                   "Date",
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.white70,
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 // You may uncomment if you have a DateSelector widget
//                 DateSelector(
//                   hintText: "Select a date",
//                   controller: _dateController,
//                   icon: Icons.calendar_today,
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100),
//                   initialDate: DateTime.now(),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 const Text(
//                   "Bank",
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.white70,
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 FutureBuilder<List<dynamic>>(
//                   future: Datamanager().getBanks(),
//                   builder: (context, snapshot) {
//                     List<String> bankNames = [];

//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Center(child: CircularProgressIndicator()),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Error fetching banks",
//                           style: TextStyle(color: Colors.white70),
//                         ),
//                       );
//                     } else if (snapshot.hasData) {
//                       bankNames =
//                           (snapshot.data as List)
//                               .map((bank) => bank.accountHolder as String)
//                               .toList();
//                     }

//                     return Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.black87.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Colors.black38.withOpacity(0.3),
//                           width: 1.0,
//                         ),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           dropdownColor: Colors.black87,
//                           isExpanded: true,
//                           value: _bank.text.isEmpty ? null : _bank.text,
//                           hint: const Text(
//                             "Select a Bank",
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                           icon: const Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.white60,
//                           ),
//                           style: const TextStyle(
//                             color: Colors.white70,
//                             fontSize: 13,
//                           ),
//                           items:
//                               bankNames.map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               _bank.text = value ?? "";
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Clear all input controllers
//                           _amount.clear();
//                           _bank.clear();
//                           _dateController.clear();
//                           _loanerName.clear();
//                           _type.clear();
//                           _phoneNumber.clear();
//                           setState(() {});
//                           Navigator.pop(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xff27272A),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                         child: const Text(
//                           "Cancel",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       flex: 3,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           try {
//                             final response = await Supabase.instance.client
//                                 .from('loan')
//                                 .insert({
//                                   'amount':
//                                       double.tryParse(_amount.text) ?? 0.0,
//                                   'loanerName': _loanerName.text,
//                                   'type': _type.text,
//                                   'bank': _bank.text,
//                                   'phoneNumber': _phoneNumber.text,
//                                   'userId': 1,
//                                   'date': _dateController.text,
//                                 });
//                             print(response);
//                             print("Loan added successfully!");
//                             final updatedLoans =
//                                 await Datamanager().fetchLoan();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text("Loan added successfully!"),
//                               ),
//                             );
//                             Navigator.pop(context, updatedLoans);
//                           } catch (e) {
//                             print("Error inserting loan: $e");
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("Error: $e")),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xff009966),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                         child: const Text(
//                           "Save",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.09),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart'; // Loan model lives here
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/loandate.dart';
import 'package:flutter_application_1/ui/inputs/loantype.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';

class AddLoan extends StatefulWidget {
  const AddLoan({super.key});

  @override
  State<AddLoan> createState() => _AddLoanState();
}

class _AddLoanState extends State<AddLoan> {
  final TextEditingController _loanerName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _bank = TextEditingController();

  // we'll stash the fetched Loan objects here:
  List<Loan> _loanList = [];

  @override
  void initState() {
    super.initState();
    // pre‐fetch the loans once up front
    Datamanager()
        .getLoan()
        .then((list) {
          setState(() {
            _loanList = list;
          });
        })
        .catchError((e) {
          // you may want to show an error
          print("Error loading loans: $e");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: FaIcon(FontAwesomeIcons.chevronLeft,size: 25, color: Color(0xff006045),),
        ),
        title: const Text(
          "Add Loan",
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                // — Loan type selector —
                TypeSelector(controller: _type),
                SizedBox(height: 24),

                // — Loaner Name + autocomplete —
                const Text(
                  "Loaner Name",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.0025),
                // Only show autocomplete once our _loanList is loaded:
                _loanList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : AutoCompleteText(
                      suggestions:
                          _loanList
                              .map((loan) => loan.loanerName)
                              .toSet()
                              .toList(),
                      controller: _loanerName,
                      hintText: "Loaner Name",
                      icon: Icons.person,
                      suggestionBuilder: (String text) {
                        return ListTile(
                          title: Text(
                            text,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                      onSelect: (selectedName) {
                        // find that Loan and auto‐fill its phone #
                        final loan = _loanList.firstWhere(
                          (l) => l.loanerName == selectedName,
                          orElse:
                              () => Loan(
                                id: 0,
                                loanerName: selectedName,
                                phoneNumber: '',
                                amount: 0,
                                date: DateTime.now(),
                                type: '',
                                bank: '',
                                userId: 0,
                              ),
                        );
                        print(loan);
                        _phoneNumber.text = loan.phoneNumber ?? '';
                        setState(() {}); // refresh the UI
                      },
                    ),
                SizedBox(height: MediaQuery.of(context).size.height*.02),

                // — Phone number field (now prefilled if matched) —
                const Text(
                  "Phone Number",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.0025),
                TextFields(
                  hinttext: 'Phone Number',
                  whatIsInput: '0',
                  controller: _phoneNumber,
                  prefixText: '+251',
                ),
                SizedBox(height: 24),

                // — Amount —
                const Text(
                  "Amount",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.0025),
                TextFields(
                  hinttext: '0.0',
                  whatIsInput: '0',
                  controller: _amount,
                  prefixText: 'ETB',
                ),
                SizedBox(height: 24),

                // — Date —
                const Text(
                  "Date",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.0025),
                DateSelector(
                  hintText: "Select a date",
                  controller: _dateController,
                  icon: Icons.calendar_today,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                ),
                SizedBox(height: 24),

                // — Bank dropdown (as before) —
                const Text(
                  "Bank",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.0025),
                FutureBuilder<List<dynamic>>(
                  future: Datamanager().getBanks(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final bankNames =
                        (snapshot.data!)
                            .map((b) => b.accountHolder as String)
                            .toList();
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                       color: Colors.grey.withOpacity(.4),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.withOpacity(.4),
                          width: 1.0,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _bank.text.isEmpty ? null : _bank.text,
                          hint: const Text(
                            "Select a Bank",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                          ),
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          items:
                              bankNames
                                  .map(
                                    (value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              _bank.text = value ?? "";
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 48),
                // — Cancel / Save buttons (unchanged) —
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _loanerName.clear();
                          _phoneNumber.clear();
                          _amount.clear();
                          _type.clear();
                          _dateController.clear();
                          _bank.clear();
                          setState(() {});
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Color(0xff27272A) : Color(0xffD4D4D8),
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final response = await Supabase.instance.client
                                .from('loan')
                                .insert({
                                  'amount':
                                      double.tryParse(_amount.text) ?? 0.0,
                                  'loanerName': _loanerName.text,
                                  'type': _type.text,
                                  'bank': _bank.text,
                                  'phoneNumber': _phoneNumber.text,
                                  'userId': 1,
                                  'date': formatDate(_dateController.text),
                                });
                            print(response);
                            print("Loan added successfully!");
                            final updatedLoans =
                                await Datamanager().fetchLoan();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Loan added successfully!"),
                              ),
                            );
                            Navigator.pop(context, updatedLoans);
                          } catch (e) {
                            print("Error inserting loan: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")),
                            );
                          }
                          // insert your Supabase logic here...
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff009966),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
