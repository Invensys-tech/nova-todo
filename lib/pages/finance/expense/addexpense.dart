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
  List<Expense> _expenseList = [];

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

  Future<List<dynamic>>? _dataFuture;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _updateFuture();

    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _expenseTypeController.text = "Must"; // or any default you want

    Datamanager()
        .getExpense()
        .then((expense) {
          setState(() {
            _expenseList = expense;
          });
        })
        .catchError((e) {
          print("Error loading expenses: $e");
        });
  }

  // void initState() {
  //   super.initState();
  //   _updateFuture();
  //   Datamanager()
  //       .getExpense()
  //       .then((expense) {
  //         setState(() {
  //           _expenseList = expense;
  //         });
  //       })
  //       .catchError((e) {
  //         print("Error loading loans: $e");
  //       });
  // }

  void _updateFuture() {
    if (_paidByController.text == "Partner") {
      _dataFuture = widget.datamanager.getLoan();
    } else if (_paidByController.text == "Bank") {
      _dataFuture = widget.datamanager.getBanks();
    } else {
      _dataFuture = Future.value([]);
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
          "Add Expense",
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

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
                      if (value == null || value.isEmpty)
                        return 'Amount is required';
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0)
                        return 'Enter a valid amount';
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                    },
                  ),

                  // --- Amount Field ---
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a Category';
                                    }
                                    return null;
                                  },
                                  suggestions:
                                      _expenseList
                                          .map((exp) => exp.category)
                                          .toSet()
                                          .toList(),
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
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0025,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .05,
                              child: DateSelector(
                                hintText: DateTime.now().toString(),
                                controller: _dateController,
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

                  ExpenseTypeSelector(controller: _expenseTypeController),

                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // CustomDateSelectorRow(
                  //   hintText: "Select a date",
                  //   controller: _dateController,
                  //   icon: Icons.calendar_today,
                  //   firstDate: DateTime(2000),
                  //   lastDate: DateTime(2100),
                  //   initialDate: DateTime.now(),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Paid By",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),

                  // Inside your AddExpense build method...
                  // Inside your AddExpense widget build method (or wherever you include the combined dropdown)
                  FutureBuilder(
                    future: _dataFuture,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0025,
                          ),
                          PaidByAndSpecificFromInput(
                            paidByController: _paidByController,
                            specificFromController: _paymentController,
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
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
                        flex: 1,
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
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                print(_dateController.text);
                                // Insert expense
                                final expenseResponse = await Supabase
                                    .instance
                                    .client
                                    .from('expense')
                                    .insert({
                                      'amount':
                                          double.tryParse(
                                            _amountController.text,
                                          ) ??
                                          0.0,
                                      'expenseName':
                                          _expenseNameController.text,
                                      'category':
                                          _expenseCategoryController.text,
                                      'type': _expenseTypeController.text,
                                      'bankAccount':
                                          _paidByController.text == "Partner"
                                              ? null
                                              : _paymentController.text,

                                      'paidBy': _paidByController.text,
                                      'description':
                                          _descriptionController.text,
                                      'date': formatDate(_dateController.text),
                                      'userid': 1,
                                    });
                                print(expenseResponse);
                                print("Expense added successfully!");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Expense added successfully!",
                                    ),
                                  ),
                                );

                                if (_paidByController.text == "Partner") {
                                  final singleLoanResponse = await Supabase
                                      .instance
                                      .client
                                      .from('single_loan')
                                      .insert({
                                        'amount':
                                            double.tryParse(
                                              _amountController.text,
                                            ) ??
                                            0.0,
                                        'type': "Payable",
                                        'paidFrom': "Partner",
                                        'specificFrom': _paymentController.text,
                                        'parentId': _parentLoanId,
                                        'date': (_dateController.text),
                                        'source': "Expense",
                                      });
                                  print(
                                    '-----------------------------------------',
                                  );
                                  print(singleLoanResponse);
                                  print(
                                    '-----------------------------------------',
                                  );
                                }
                                Navigator.pop(context);
                              } catch (e) {
                                print("Error inserting expense: $e");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              }
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

String formatDate(String date) {
  List<String> parts = date.split('-'); // Split DD-MM-YYYY
  return '${parts[2]}-${parts[1]}-${parts[0]}'; // Convert to YYYY-MM-DD
}
