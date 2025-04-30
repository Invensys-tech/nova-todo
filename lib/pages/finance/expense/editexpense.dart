// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/datamanager.dart';
// import 'package:flutter_application_1/datamodel.dart';
// import 'package:flutter_application_1/entities/expense-entity.dart';
// import 'package:flutter_application_1/repositories/expense.repository.dart';
// import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
// import 'package:flutter_application_1/ui/inputs/dropdown.dart';
// import 'package:flutter_application_1/ui/inputs/mutitext.dart';
// import 'package:flutter_application_1/ui/inputs/testdate.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class EditExpense extends StatefulWidget {
//   final Datamanager datamanager;
//   final int expenseId;
//   const EditExpense({
//     Key? key,
//     required this.datamanager,
//     required this.expenseId,
//   }) : super(key: key);

//   @override
//   State<EditExpense> createState() => _EditExpenseState();
// }

// class _EditExpenseState extends State<EditExpense> {
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _expenseNameController = TextEditingController();
//   final TextEditingController _expenseTypeController = TextEditingController();
//   final TextEditingController _expenseCategoryController =
//       TextEditingController();
//   final TextEditingController _paymentController = TextEditingController();
//   final TextEditingController _paidByController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();

//   String? _paidBySelection;
//   int? _parentLoanId;
//   bool _isLoading = true;

//   final ExpenseRepository _expenseRepository = ExpenseRepository();

//   @override
//   void initState() {
//     super.initState();
//     _fetchExpense();
//   }

//   Future<void> _fetchExpense() async {
//     try {
//       final expense = await _expenseRepository.getSingleExpense(
//         widget.expenseId,
//       );
//       print(expense);

//       _amountController.text = expense.amount?.toString() ?? '';
//       _expenseNameController.text = expense.expenseName ?? '';
//       _expenseCategoryController.text = expense.category ?? '';
//       _expenseTypeController.text = expense.type ?? '';
//       _paidByController.text = expense.paidBy ?? '';
//       _paymentController.text = expense.bankAccount ?? '';
//       _descriptionController.text = expense.description ?? '';

//       // Make sure expense.date is not null before formatting
//       _dateController.text =
//           expense.date != null
//               ? expense.date.toIso8601String().split('T')[0]
//               : '';

//       setState(() {
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("From Expense Edit");
//       print("Error fetching expense: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // While loading, show a spinner.
//     if (_isLoading) {
//       return Scaffold(
//         backgroundColor: const Color(0xff2F2F2F),
//         appBar: AppBar(
//           backgroundColor: const Color(0xff2F2F2F),
//           leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//           ),
//           title: const Text(
//             "Edit Expense",
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           centerTitle: true,
//         ),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }
//     return Scaffold(
//       backgroundColor: const Color(0xff2F2F2F),
//       appBar: AppBar(
//         backgroundColor: const Color(0xff2F2F2F),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: const Text(
//           "Edit Expense",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.045,
//         ),
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // --- Amount Field ---
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               const Text(
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
//                 controller: _amountController,
//               ),
//               // --- Expense Name Field ---
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               const Text(
//                 "Expense Name",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               TextFields(
//                 hinttext: 'Lunch At Bole',
//                 whatIsInput: '1',
//                 controller: _expenseNameController,
//               ),
//               // --- Category ---
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               const Text(
//                 "Category",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               AutoCompleteText(
//                 suggestions: [
//                   "Orange",
//                   "Apple",
//                   "Banana",
//                   "Mango",
//                   "Carrot",
//                   "Watermelon",
//                   "Grapes",
//                   "Dates",
//                   "Dragon Fruit",
//                 ],
//                 controller: _expenseCategoryController,
//                 hintText: "Search for a Category...",
//                 icon: Icons.search,
//                 suggestionBuilder: (String text) {
//                   return ListTile(
//                     title: Text(
//                       text,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                     subtitle: const Text(
//                       "Tap to select",
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   );
//                 },
//               ),
//               // --- Expense Type ---
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               const Text(
//                 "Types of Expenses",
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
//                 items: ["Must", "Maybe", "Unwanted"],
//                 controller: _expenseTypeController,
//               ),
//               // --- Date Selector ---
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               const Text(
//                 "Date",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               // We now use the same CustomDateSelectorRow component as in the Add form.
//               CustomDateSelectorRow(
//                 hintText: "Select a date",
//                 controller: _dateController,
//                 icon: Icons.calendar_today,
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2100),
//                 // Use the current date in _dateController if available, otherwise fallback to DateTime.now()
//                 initialDate:
//                     _dateController.text.isNotEmpty
//                         ? DateTime.parse(_dateController.text)
//                         : DateTime.now(),
//               ),
//               // --- Paid By and Bank Account ---
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               FutureBuilder(
//                 future:
//                     _paidByController.text == "Partner"
//                         ? widget.datamanager.getLoan()
//                         : _paidByController.text == "Bank"
//                         ? widget.datamanager.getBanks()
//                         : Future.value([]),
//                 builder: (context, snapshot) {
//                   Map<String, int> partnerMapping = {};
//                   List<String> dynamicItems = [];
//                   if (_paidByController.text == 'Partner') {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Text(
//                         "Error fetching partner names: ${snapshot.error}",
//                         style: const TextStyle(color: Colors.white),
//                       );
//                     } else if (snapshot.hasData) {
//                       for (Loan loan in snapshot.data as List<Loan>) {
//                         partnerMapping[loan.loanerName] = loan.id;
//                       }
//                       dynamicItems = partnerMapping.keys.toList();
//                     }
//                   } else if (_paidByController.text == 'Bank') {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Text(
//                         "Error fetching banks: ${snapshot.error}",
//                         style: const TextStyle(color: Colors.white),
//                       );
//                     } else if (snapshot.hasData) {
//                       dynamicItems =
//                           (snapshot.data as List<Bank>)
//                               .map((bank) => bank.accountHolder)
//                               .toList();
//                     }
//                   }
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       const Text(
//                         "Paid By",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white70,
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       CustomDropdown(
//                         hintText: "Select an option",
//                         icon: Icons.ac_unit_sharp,
//                         items: ["Partner", "Bank"],
//                         controller: _paidByController,
//                         onChanged: (value) {
//                           setState(() {
//                             _paidBySelection = value;
//                             _paidByController.text = value ?? '';
//                             _paymentController.clear();
//                             _parentLoanId = null;
//                           });
//                         },
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       const Text(
//                         "Bank Account",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white70,
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       CustomDropdown(
//                         hintText: "Select a specific payer",
//                         icon: Icons.account_balance_wallet,
//                         items: dynamicItems,
//                         controller: _paymentController,
//                         onChanged: (value) {
//                           if (_paidByController.text == 'Partner' &&
//                               partnerMapping.containsKey(value!)) {
//                             setState(() {
//                               _parentLoanId = partnerMapping[value];
//                             });
//                           }
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               // --- Description ---
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               const Text(
//                 "Description",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               MultiLineTextField(
//                 hintText: 'description',
//                 controller: _descriptionController,
//                 icon: Icons.description,
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.09),
//               // --- Buttons ---
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Simply navigate back
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         try {
//                           // Update expense using Supabase; note that _dateController.text is already in yyyy-MM-dd
//                           final response = await Supabase.instance.client
//                               .from('expense')
//                               .update({
//                                 'amount':
//                                     double.tryParse(_amountController.text) ??
//                                     0.0,
//                                 'expenseName': _expenseNameController.text,
//                                 'category': _expenseCategoryController.text,
//                                 'type': _expenseTypeController.text,
//                                 'bankAccount':
//                                     _paidByController.text == "Partner"
//                                         ? null
//                                         : _paymentController.text,
//                                 'paidBy': _paidByController.text,
//                                 'description': _descriptionController.text,
//                                 'date': _dateController.text,
//                               })
//                               .eq('id', widget.expenseId);
//                           print(response);
//                           print("Expense updated successfully!");
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text("Expense updated successfully!"),
//                             ),
//                           );
//                           Navigator.pop(context);
//                         } catch (e) {
//                           print("Error updating expense: $e");
//                           ScaffoldMessenger.of(
//                             context,
//                           ).showSnackBar(SnackBar(content: Text("Error: $e")));
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       child: const Text(
//                         "Update Expense",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.09),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:chapasdk/domain/constants/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/expense-payment.selector.dart';
import 'package:flutter_application_1/ui/inputs/expensetype.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/testdate.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class EditExpense extends StatefulWidget {
  final Datamanager datamanager;
  final int expenseId;
  const EditExpense({
    super.key,
    required this.datamanager,
    required this.expenseId,
  });

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _amountController = TextEditingController();
  final _expenseNameController = TextEditingController();
  final _expenseTypeController = TextEditingController();
  final _expenseCategoryController = TextEditingController();
  final _paymentController = TextEditingController();
  final _paidByController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  late double _firstAmount;

  bool _isLoading = true;
  int? _parentLoanId;
  List<Expense> _expenseList = [];
  Future<List<dynamic>>? _dataFuture;
  bool isLoading = false;

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
    // 1️⃣ Load categories for autocomplete
    widget.datamanager
        .getExpense()
        .then((list) => setState(() => _expenseList = list))
        .catchError((e) => debugPrint("Error loading categories: $e"));

    // 2️⃣ Prepare the PaidBy future
    _updateFuture();

    // 3️⃣ Fetch the existing expense
    _fetchExpense();
  }

  void _updateFuture() {
    if (_paidByController.text == "Partner") {
      _dataFuture = widget.datamanager.getLoan();
    } else if (_paidByController.text == "Bank") {
      _dataFuture = widget.datamanager.getBanks();
    } else {
      _dataFuture = Future.value([]);
    }
  }

  Future<void> _fetchExpense() async {
    try {
      final resp =
          await Supabase.instance.client
              .from('expense')
              .select('*')
              .eq('id', widget.expenseId)
              .maybeSingle();
      if (resp != null && resp is Map<String, dynamic>) {
        // Populate controllers
        _amountController.text = (resp['amount'] ?? '').toString();
        _firstAmount = double.tryParse(_amountController.text) ?? 0.0;
        _expenseNameController.text = resp['expenseName'] ?? '';
        _expenseCategoryController.text = resp['category'] ?? '';
        _expenseTypeController.text = resp['type'] ?? '';
        _paidByController.text = resp['paidBy'] ?? '';
        _paymentController.text = resp['bankAccount'].toString() ?? '';
        _descriptionController.text = resp['description'] ?? '';

        // Date is stored as 'YYYY-MM-DD'
        final rawDate = resp['date'] as String? ?? '';
        _dateController.text =
            rawDate.isNotEmpty
                ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rawDate))
                : DateFormat('dd-MM-yyyy').format(DateTime.now());

        // After setting paidBy, update the future for specific-from
        _updateFuture();
      }
    } catch (e) {
      debugPrint("Error fetching expense: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String formatDate(String date) {
    final parts = date.split('-');
    if (parts.length != 3) {
      return DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
    return '${parts[2]}-${parts[1]}-${parts[0]}';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 25,
            color: const Color(0xff006045),
          ),
        ),
        title: const Text(
          "Edit Expense",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
          vertical: MediaQuery.of(context).size.height * .015,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xff27272A) : const Color(0xFFF4F4F5),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Amount
                  const Text(
                    "Amount",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                  TextFields(
                    hinttext: 'eg: 400',
                    whatIsInput: '0',
                    controller: _amountController,
                    prefixText: 'ETB',
                    func: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Amount is required';
                      }
                      final amt = double.tryParse(value);
                      if (amt == null || amt <= 0) {
                        return 'Enter a valid amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Expense Name
                  const Text(
                    "Expense Name",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                  TextFields(
                    hinttext: 'Lunch At Bole',
                    whatIsInput: '1',
                    controller: _expenseNameController,
                    func: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Expense name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Category + Date Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0025,
                            ),
                            _expenseList.isEmpty
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                : AutoCompleteText(
                                  isFromEdit: true,
                                  suggestions:
                                      _expenseList
                                          .map((e) => e.category)
                                          .toSet()
                                          .toList(),
                                  controller: _expenseCategoryController,
                                  hintText: "Search for a Category...",
                                  icon: Icons.search,
                                  suggestionBuilder:
                                      (text) => ListTile(
                                        title: Text(
                                          text,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a Category';
                                    }
                                    return null;
                                  },
                                ),
                          ],
                        ),
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width * .05),

                      // Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0025,
                            ),
                            DateSelector(
                              hintText: DateTime.now().toString(),
                              controller: _dateController,
                              icon: Icons.calendar_today,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: DateFormat(
                                'dd-MM-yyyy',
                              ).parse(_dateController.text),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Expense Type
                  ExpenseTypeSelector(controller: _expenseTypeController),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Paid By & Specific From
                  FutureBuilder(
                    future: _dataFuture,
                    builder: (context, snapshot) {
                      return PaidByAndSpecificFromInput(
                        paidByController: _paidByController,
                        specificFromController: _paymentController,
                        dataFuture: _dataFuture ?? Future.value([]),
                        onPaidByChanged: (newPaidBy) {
                          setState(_updateFuture);
                        },
                      );
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Description
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                  MultiLineTextField(
                    hintText: 'description',
                    controller: _descriptionController,
                    icon: Icons.description,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Reset to original and go back
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDark
                                    ? const Color(0xff27272A)
                                    : const Color(0xffD4D4D8),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 10),

                      ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : () async {
                                  // 1️⃣ Validate form
                                  if (!_formKey.currentState!.validate())
                                    return;

                                  setState(() => isLoading = true);

                                  final bankId = _paymentController.text;
                                  final expenseAmt =
                                      double.tryParse(_amountController.text) ??
                                      0.0;

                                  try {
                                    // 2️⃣ Fetch current bank balance
                                    final bankRes =
                                        await Supabase.instance.client
                                            .from('bank')
                                            .select('balance')
                                            .eq('id', bankId)
                                            .single();

                                    final currentBalance =
                                        (bankRes['balance'] as num).toDouble();

                                    if (_paidByController.text != "Partner") {
                                      if (currentBalance < expenseAmt) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Insufficient balance in selected bank account.',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        setState(() => isLoading = false);
                                        return;
                                      }

                                      final change = expenseAmt - _firstAmount;

                                      final newBalance =
                                          currentBalance - change;
                                      await Supabase.instance.client
                                          .from('bank')
                                          .update({'balance': newBalance})
                                          .eq('id', bankId);
                                    }

                                    await Supabase.instance.client
                                        .from('expense')
                                        .update({
                                          'amount': expenseAmt,
                                          'expenseName':
                                              _expenseNameController.text,
                                          'category':
                                              _expenseCategoryController.text,
                                          'type': _expenseTypeController.text,
                                          'bankAccount':
                                              _paidByController.text ==
                                                      "Partner"
                                                  ? null
                                                  : bankId,
                                          'paidBy': _paidByController.text,
                                          'description':
                                              _descriptionController.text,
                                          'date': formatDate(
                                            _dateController.text,
                                          ),
                                        })
                                        .eq('id', widget.expenseId);

                                    if (_paidByController.text == "Partner") {
                                      final specific = _paymentController.text;
                                      final loanLookup =
                                          await Supabase.instance.client
                                              .from('loan')
                                              .select('phonenumber')
                                              .eq('loanerName', specific)
                                              .single();

                                      await Supabase.instance.client
                                          .from('loan')
                                          .insert({
                                            'amount': expenseAmt,
                                            'type': "Payable",
                                            'date': formatDate(
                                              _dateController.text,
                                            ),
                                            'bank': "Expense",
                                            'loanerName': specific,
                                            'phoneNumber':
                                                loanLookup['phonenumber'],
                                            'userId': 1,
                                          });
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Expense updated successfully!",
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } catch (e) {
                                    // 7️⃣ Error handling
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error: $e")),
                                    );
                                  } finally {
                                    setState(() => isLoading = false);
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isLoading ? Colors.grey : const Color(0xff009966),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child:
                            isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(
                                  "Update Expense",
                                  style: TextStyle(color: Colors.white),
                                ),
                      ),
                      // Expanded(
                      //   flex: 3,
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       if (!_formKey.currentState!.validate()) return;

                      //       try {
                      //         await Supabase.instance.client
                      //             .from('expense')
                      //             .update({
                      //               'amount':
                      //                   double.tryParse(
                      //                     _amountController.text,
                      //                   ) ??
                      //                   0.0,
                      //               'expenseName': _expenseNameController.text,
                      //               'category': _expenseCategoryController.text,
                      //               'type': _expenseTypeController.text,
                      //               'bankAccount':
                      //                   _paidByController.text == "Partner"
                      //                       ? null
                      //                       : _paymentController.text,
                      //               'paidBy': _paidByController.text,
                      //               'description': _descriptionController.text,
                      //               'date': formatDate(_dateController.text),
                      //             })
                      //             .eq('id', widget.expenseId);

                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //             content: Text(
                      //               "Expense updated successfully!",
                      //             ),
                      //           ),
                      //         );
                      //         Navigator.pop(context);
                      //       } catch (e) {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(content: Text("Error: $e")),
                      //         );
                      //       }
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: const Color(0xff009966),
                      //       padding: const EdgeInsets.symmetric(vertical: 15),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //     ),
                      //     child: const Text(
                      //       "Update Expense",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
