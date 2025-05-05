// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/datamanager.dart';
// import 'package:flutter_application_1/datamodel.dart';
// import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
// import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
// import 'package:flutter_application_1/ui/inputs/dateselector.dart';
// import 'package:flutter_application_1/ui/inputs/loandate.dart';
// import 'package:flutter_application_1/ui/inputs/loantype.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../../main.dart';

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
//   final TextEditingController _bank = TextEditingController();

//   // we'll stash the fetched Loan objects here:
//   List<Loan> _loanList = [];

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
//     // pre‐fetch the loans once up front
//     Datamanager()
//         .getLoan()
//         .then((list) {
//           setState(() {
//             _loanList = list;
//           });
//         })
//         .catchError((e) {
//           // you may want to show an error
//           print("Error loading loans: $e");
//         });
//   }

//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: FaIcon(
//             FontAwesomeIcons.chevronLeft,
//             size: 25,
//             color: Color(0xff006045),
//           ),
//         ),
//         title: const Text(
//           "Add Loan",
//           style: TextStyle(fontWeight: FontWeight.bold),
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
//               color: isDark ? Color(0xff27272A) : Color(0xFFF4F4F5),
//               border: Border.all(
//                 color: Colors.grey.withOpacity(.3), // Border color
//                 width: 1.0, // Border width
//               ),
//               borderRadius: BorderRadius.circular(
//                 8,
//               ), // Optional: rounded corners
//             ),
//             padding: const EdgeInsets.all(10),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // — Loan type selector —
//                   TypeSelector(controller: _type),
//                   SizedBox(height: 24),

//                   // — Loaner Name + autocomplete —
//                   const Text(
//                     "Loaner Name",
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * .0025),

//                   // Only show autocomplete once our _loanList is loaded:
//                   AutoCompleteText(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select a Category';
//                       }
//                       return null;
//                     },
//                     suggestions:
//                         _loanList
//                             .map((loan) => loan.loanerName)
//                             .toSet()
//                             .toList() ??
//                         [],
//                     controller: _loanerName,
//                     hintText: "Loaner Name",
//                     icon: Icons.person,
//                     suggestionBuilder: (String text) {
//                       return ListTile(
//                         title: Text(
//                           text,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       );
//                     },

//                     onSelect: (selectedName) {
//                       // find that Loan and auto‐fill its phone #
//                       final loan = _loanList.firstWhere(
//                         (l) => l.loanerName == selectedName,
//                         orElse:
//                             () => Loan(
//                               id: 0,
//                               loanerName: selectedName,
//                               phoneNumber: '',
//                               amount: 0,
//                               date: DateTime.now(),
//                               type: '',
//                               bank: '',
//                               userId: 0,
//                             ),
//                       );
//                       print(loan);
//                       _phoneNumber.text = loan.phoneNumber ?? '';
//                       setState(() {}); // refresh the UI
//                     },
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * .02),

//                   // — Phone number field (now prefilled if matched) —
//                   const Text(
//                     "Phone Number",
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * .0025),
//                   TextFields(
//                     hinttext: 'Phone Number',
//                     whatIsInput: '0',
//                     controller: _phoneNumber,
//                     prefixText: '+251',
//                     func: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a phone number';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 24),

//                   // — Amount —
//                   const Text(
//                     "Amount",
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * .0025),
//                   TextFields(
//                     hinttext: '0.0',
//                     whatIsInput: '0',
//                     controller: _amount,
//                     prefixText: 'ETB',
//                     func: (value) {
//                       if (value == null || value.isEmpty)
//                         return 'Amount is required';
//                       final amount = double.tryParse(value);
//                       if (amount == null || amount <= 0)
//                         return 'Enter a valid amount';
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 24),

//                   // — Date —
//                   const Text(
//                     "Date",
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * .0025),
//                   DateSelector(
//                     hintText: "Select a date",
//                     controller: _dateController,
//                     icon: Icons.calendar_today,
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2100),
//                     initialDate: DateTime.now(),
//                   ),
//                   SizedBox(height: 24),

//                   // — Bank dropdown (as before) —
//                   const Text(
//                     "Bank",
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * .0025),
//                   FutureBuilder<List<dynamic>>(
//                     future: Datamanager().getBanks(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       final bankNames =
//                           (snapshot.data!)
//                               .map(
//                                 (b) => '${b.accountHolder}-${b.accountNumber}',
//                               )
//                               .toList();
//                       return Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(.4),
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(.4),
//                             width: 1.0,
//                           ),
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             isExpanded: true,
//                             value: _bank.text.isEmpty ? null : _bank.text,
//                             hint: const Text(
//                               "Select a Bank",
//                               style: TextStyle(fontSize: 12),
//                             ),
//                             icon: const Icon(Icons.arrow_drop_down),
//                             style: const TextStyle(fontSize: 13),
//                             items:
//                                 bankNames
//                                     .map(
//                                       (value) => DropdownMenuItem(
//                                         value: value,
//                                         child: Text(value),
//                                       ),
//                                     )
//                                     .toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 _bank.text = value ?? "";
//                               });
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                   SizedBox(height: 48),
//                   // — Cancel / Save buttons (unchanged) —
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {
//                             _loanerName.clear();
//                             _phoneNumber.clear();
//                             _amount.clear();
//                             _type.clear();
//                             _dateController.clear();
//                             _bank.clear();
//                             setState(() {});
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 isDark ? Color(0xff27272A) : Color(0xffD4D4D8),
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           child: const Text(
//                             "Cancel",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed:
//                               isLoading
//                                   ? null
//                                   : () async {
//                                     if (_formKey.currentState!.validate()) {
//                                       print("Why Always me");
//                                       print(_bank.text.split("-")[0]);
//                                       setState(() {
//                                         isLoading = true;
//                                       });
//                                       try {
//                                         final bankData = (await Supabase
//                                             .instance
//                                             .client
//                                             .from('bank')
//                                             .select()
//                                             .eq(
//                                               'accountHolder',
//                                               _bank.text.split("-")[0],
//                                             ));

//                                         print("We Fetched The banks");

//                                         print(bankData);

//                                         final response = await Supabase
//                                             .instance
//                                             .client
//                                             .from('loan')
//                                             .insert({
//                                               'amount':
//                                                   double.tryParse(
//                                                     _amount.text,
//                                                   ) ??
//                                                   0.0,
//                                               'loanerName': _loanerName.text,
//                                               'type': _type.text,
//                                               'bank': _bank.text.split("-")[0],
//                                               'phoneNumber': _phoneNumber.text,
//                                               'userId': userId,
//                                               'date': formatDate(
//                                                 _dateController.text,
//                                               ),
//                                             });
//                                         print("Loan added successfully!");
//                                         final updatedLoans =
//                                             await Datamanager().fetchLoan();
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           const SnackBar(
//                                             content: Text(
//                                               "Loan added successfully!",
//                                             ),
//                                           ),
//                                         );
//                                         setState(() {
//                                           isLoading = false;
//                                         });
//                                         Navigator.pop(context, updatedLoans);
//                                       } catch (e) {
//                                         setState(() {
//                                           isLoading = false;
//                                         });
//                                         print("Error inserting loan: $e");
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           SnackBar(content: Text("Error: $e")),
//                                         );
//                                       }
//                                     }

//                                     // insert your Supabase logic here...
//                                   },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 isLoading ? Colors.grey : Color(0xff009966),
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           child: const Text(
//                             "Save",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/loandate.dart';
import 'package:flutter_application_1/ui/inputs/loantype.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';

class AddLoan extends StatefulWidget {
  const AddLoan({super.key});

  @override
  State<AddLoan> createState() => _AddLoanState();
}

class _AddLoanState extends State<AddLoan> {
  final _loanerName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _amount = TextEditingController();
  final _type = TextEditingController();
  final _dateController = TextEditingController();
  final _bank = TextEditingController();

  List<Loan> _loanList = [];
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    Datamanager()
        .getLoan()
        .then((list) => setState(() => _loanList = list))
        .catchError((e) => print("Error loading loans: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 25,
            color: Color(0xff006045),
          ),
        ),
        title: const Text(
          "Add Loan",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                color: Colors.grey.withOpacity(.3),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TypeSelector(controller: _type),
                  SizedBox(height: 24),

                  const Text(
                    "Loaner Name",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8),
                  AutoCompleteText(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a loaner';
                      }
                      return null;
                    },
                    suggestions:
                        _loanList.map((l) => l.loanerName).toSet().toList(),
                    controller: _loanerName,
                    hintText: "Loaner Name",
                    icon: Icons.person,
                    suggestionBuilder:
                        (text) => ListTile(
                          title: Text(
                            text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                    onSelect: (selected) {
                      final loan = _loanList.firstWhere(
                        (l) => l.loanerName == selected,
                        orElse:
                            () => Loan(
                              id: 0,
                              loanerName: selected,
                              phoneNumber: '',
                              amount: 0,
                              date: DateTime.now(),
                              type: '',
                              bank: '',
                              userId: 0,
                            ),
                      );
                      _phoneNumber.text = loan.phoneNumber ?? '';
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 24),

                  const Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8),
                  TextFields(
                    hinttext: 'Phone Number',
                    whatIsInput: '0',
                    controller: _phoneNumber,
                    prefixText: '+251',
                    func: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),

                  const Text(
                    "Amount",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8),
                  TextFields(
                    hinttext: '0.0',
                    whatIsInput: '0',
                    controller: _amount,
                    prefixText: 'ETB',
                    func: (value) {
                      if (value == null || value.isEmpty)
                        return 'Amount is required';
                      final amt = double.tryParse(value);
                      if (amt == null || amt <= 0)
                        return 'Enter a valid amount';
                      return null;
                    },
                  ),
                  SizedBox(height: 24),

                  const Text(
                    "Date",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8),
                  DateSelector(
                    hintText: "Select a date",
                    controller: _dateController,
                    icon: Icons.calendar_today,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  ),
                  SizedBox(height: 24),

                  const Text(
                    "Bank",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8),
                  FutureBuilder<List<dynamic>>(
                    future: Datamanager().getBanks(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final banks = snapshot.data!;
                      final items =
                          banks
                              .map(
                                (b) => '${b.accountHolder}-${b.accountNumber}',
                              )
                              .toList();
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.4),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.withOpacity(.4),
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _bank.text.isEmpty ? null : _bank.text,
                            hint: Text(
                              "Select a Bank",
                              style: TextStyle(fontSize: 12),
                            ),
                            items:
                                items
                                    .map(
                                      (val) => DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (val) => setState(() => _bank.text = val ?? ""),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 48),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDark ? Color(0xff27272A) : Color(0xffD4D4D8),
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
                          onPressed:
                              isLoading
                                  ? null
                                  : () async {
                                    if (!_formKey.currentState!.validate())
                                      return;
                                    setState(() => isLoading = true);

                                    try {
                                      final accountHolder =
                                          _bank.text.split('-')[0];
                                      // fetch single bank record
                                      final bankRec =
                                          await Supabase.instance.client
                                              .from('bank')
                                              .select()
                                              .eq(
                                                'accountHolder',
                                                accountHolder,
                                              )
                                              .single();

                                      final currentBalance =
                                          (bankRec['balance'] as num)
                                              .toDouble();
                                      final loanAmt = double.parse(
                                        _amount.text,
                                      );

                                      if (_type.text == 'Payable' &&
                                          currentBalance < loanAmt) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Insufficient bank balance',
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      // update bank balance
                                      await Supabase.instance.client
                                          .from('bank')
                                          .update({
                                            'balance':
                                                _type.text == 'Receivable'
                                                    ? currentBalance + loanAmt
                                                    : currentBalance - loanAmt,
                                          })
                                          .eq('id', bankRec['id']);

                                      // insert loan
                                      await Supabase.instance.client
                                          .from('loan')
                                          .insert({
                                            'amount': loanAmt,
                                            'loanerName': _loanerName.text,
                                            'type': _type.text,
                                            'bank': accountHolder,
                                            'phoneNumber': _phoneNumber.text,
                                            'userId': userId,
                                            'date': formatDate(
                                              _dateController.text,
                                            ),
                                          });

                                      // fetch updated list
                                      final updatedLoans =
                                          await Datamanager().getLoan();

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Loan added successfully',
                                          ),
                                        ),
                                      );

                                      Navigator.pop(context, updatedLoans);
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    } finally {
                                      if (mounted)
                                        setState(() => isLoading = false);
                                    }
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isLoading ? Colors.grey : Color(0xff009966),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child:
                              isLoading
                                  ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                  : const Text(
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
      ),
    );
  }
}
