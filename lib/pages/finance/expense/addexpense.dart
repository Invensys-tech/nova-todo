import 'package:chapasdk/domain/constants/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/repositories/expense.repository.dart';
import 'package:flutter_application_1/repositories/partner.repository.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/expense-payment.selector.dart';
import 'package:flutter_application_1/ui/inputs/expensetype.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/testdate.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
  final TextEditingController _bankId = TextEditingController();

  String? _paidBySelection;
  int? _parentLoanId;
  List<String> _expenseList = [];

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
  bool isLoading = false;

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
    _loadExpenseList();
    _paidByController.text = "Bank";
    _updateFuture();

    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _expenseTypeController.text = "Must";
  }

  void _loadExpenseList() async {
    _expenseList = await ExpenseRepository().getExpenseCategory();
  }

  void _updateFuture() {
    if (_paidByController.text == "Partner") {
      // PartnerRepository()
      //     .fetchPartners()
      //     .then(
      //       (p) => setState(() {
      //         _dataFuture = p as Future<List>?;
      //       }),
      //     )
      //     .catchError((e) => print("Error loading partners: $e"));
      _dataFuture = PartnerRepository().fetchPartners();
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
        title: Text(
          translate("Expense"),
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

                  Text(
                    translate("Amount"),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),

                  TextFields(
                    hinttext: 'eg: 400',
                    whatIsInput: '0',
                    controller: _amountController,
                    prefixText: translate('ETB'),
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
                  Text(
                    translate("Expense Name"),
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
                            Text(
                              translate("Category"),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0025,
                            ),
                            // _expenseList.
                            //     ? const Center(
                            //       child: CircularProgressIndicator(),
                            //     )
                            //     :
                            AutoCompleteText(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a Category';
                                }
                                return null;
                              },

                              suggestions: _expenseList,
                              //     .map((exp) => exp)
                              //     .toSet()
                              //     .toList()
                              //     .isNotEmpty
                              // ? _expenseList
                              //     .map((exp) => exp)
                              //     .toSet()
                              //     .toList()
                              // : [],
                              controller: _expenseCategoryController,
                              hintText: translate("Search for a Category..."),
                              icon: Icons.search,
                              suggestionBuilder: (String text) {
                                return ListTile(
                                  title: Text(
                                    text,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
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
                            Text(
                              translate("Date"),
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

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    translate("Paid by"),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),

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
                            bankController: _bankId,
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
                        ],
                      );
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    translate("Description"),
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
                          child: Text(translate("Cancel")),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed:
                              isLoading
                                  ? null
                                  : () async {
                                    if (!_formKey.currentState!.validate())
                                      return;

                                    setState(() => isLoading = true);

                                    final paidBy = _paidByController.text;

                                    print("+++++++++++++++++++++++++++++++++");

                                    print(_paymentController.text);
                                    final paymentValue =
                                        _paymentController.text;
                                    final expenseAmt =
                                        double.tryParse(
                                          _amountController.text,
                                        ) ??
                                        0.0;

                                    try {
                                      // 1) If paying by Bank, check & update bank balance first
                                      if (paidBy == 'Bank') {
                                        final bankRes =
                                            await Supabase.instance.client
                                                .from('bank')
                                                .select('balance')
                                                .eq('id', paymentValue)
                                                .single();
                                        final currentBalance =
                                            (bankRes['balance'] as num)
                                                .toDouble();

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

                                        // Deduct and save new balance
                                        final newBalance =
                                            currentBalance - expenseAmt;
                                        await Supabase.instance.client
                                            .from('bank')
                                            .update({'balance': newBalance})
                                            .eq('id', paymentValue);

                                        final expenseResponse = await Supabase
                                            .instance
                                            .client
                                            .from('expense')
                                            .insert({
                                              'amount': expenseAmt,
                                              'expenseName':
                                                  _expenseNameController.text,
                                              'category':
                                                  _expenseCategoryController
                                                      .text,
                                              'type':
                                                  _expenseTypeController.text,
                                              'bankAccount':
                                                  paidBy == 'Bank'
                                                      ? int.tryParse(
                                                        paymentValue,
                                                      )
                                                      : null,
                                              'paidBy': paidBy,
                                              'description':
                                                  _descriptionController.text,
                                              'date': formatDate(
                                                _dateController.text,
                                              ),
                                              'userid': userId,
                                            });
                                      }

                                      print("hhhhhhhhhhhhhh");

                                      print(_expenseCategoryController.text);

                                      // 2) Insert the expense

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Expense added successfully!',
                                          ),
                                        ),
                                      );

                                      if (paidBy == 'Partner') {
                                        String loanerIdOrName = paymentValue;
                                        int? partnerId;

                                        String? rawPhone;
                                        String? rawName;
                                        Map<String, dynamic>? existingPartner;

                                        if (loanerIdOrName.endsWith(
                                          '-addpartner',
                                        )) {
                                          final raw = loanerIdOrName.replaceAll(
                                            '-addpartner',
                                            '',
                                          );

                                          final parts = raw.split('–');
                                          rawName = parts.first.trim();

                                          rawPhone =
                                              parts.length > 1
                                                  ? parts[1]
                                                      .replaceAll(
                                                        RegExp(r'[\[\]]'),
                                                        '',
                                                      )
                                                      .trim()
                                                  : null;

                                          if (rawPhone != null &&
                                              rawPhone.isNotEmpty) {
                                            existingPartner =
                                                await Supabase.instance.client
                                                    .from('partners')
                                                    .select(
                                                      'id, name, phone_number',
                                                    )
                                                    .eq(
                                                      'phone_number',
                                                      rawPhone,
                                                    )
                                                    .maybeSingle();
                                          }

                                          if (existingPartner != null) {
                                            partnerId =
                                                existingPartner['id'] as int;
                                          } else {
                                            // 3) Insert the new partner
                                            final insertRes =
                                                await Supabase.instance.client
                                                    .from('partners')
                                                    .insert({
                                                      'name': rawName,
                                                      'phone_number': rawPhone,
                                                      'user_id': userId,
                                                    })
                                                    .select('id')
                                                    .maybeSingle();
                                            partnerId =
                                                insertRes?['id'] as int?;
                                          }
                                        } else {
                                          // 4) It was an existing partner, so paymentValue is the id
                                          partnerId = int.tryParse(
                                            paymentValue,
                                          );
                                        }

                                        if (partnerId == null) {
                                          throw Exception(
                                            'Unable to determine partner_id for $paymentValue',
                                          );
                                        }

                                        // Prepare for the loan insert
                                        final loanerName =
                                            (loanerIdOrName.endsWith(
                                                      '-addpartner',
                                                    ) &&
                                                    rawName != null)
                                                ? rawName
                                                : loanerIdOrName;
                                        final phoneNumForLoan =
                                            rawPhone != null
                                                ? int.tryParse(rawPhone)
                                                : null;

                                        // 5) Insert the loan row
                                        await Supabase.instance.client
                                            .from('loan')
                                            .insert({
                                              'amount': expenseAmt,
                                              'type': 'Payable',
                                              'date': formatDate(
                                                _dateController.text,
                                              ),
                                              'bank': 'Expense',
                                              'loanerName': loanerName,
                                              // if phoneNumForLoan is null, you may want to handle that case differently
                                              'phoneNumber':
                                                  phoneNumForLoan ?? 0,
                                              'userId': userId,
                                              'partner_id': partnerId,
                                            });

                                        final expenseResponse = await Supabase
                                            .instance
                                            .client
                                            .from('expense')
                                            .insert({
                                              'amount': expenseAmt,
                                              'expenseName':
                                                  _expenseNameController.text,
                                              'category':
                                                  _expenseCategoryController
                                                      .text,
                                              'type':
                                                  _expenseTypeController.text,
                                              'bankAccount':
                                                  paidBy == 'Bank'
                                                      ? int.tryParse(
                                                        paymentValue,
                                                      )
                                                      : null,
                                              'paidBy': paidBy,
                                              'description':
                                                  _descriptionController.text,
                                              'date': formatDate(
                                                _dateController.text,
                                              ),
                                              'userid': userId,
                                              'partner_id': partnerId,
                                            });
                                      }

                                      // if (paidBy == 'Partner') {
                                      //   final loanerIdOrName = paymentValue;

                                      //   final realPartners = await Supabase
                                      //       .instance
                                      //       .client
                                      //       .from('partners')
                                      //       .select()
                                      //       .eq("id", paymentValue);

                                      //   final partners = await Supabase
                                      //       .instance
                                      //       .client
                                      //       .from('loan')
                                      //       .select('phoneNumber')
                                      //       .eq('loanerName', loanerIdOrName);
                                      //   final phone =
                                      //       partners.isNotEmpty
                                      //           ? partners[0]['phoneNumber']
                                      //           : null;

                                      //   await Supabase.instance.client
                                      //       .from('loan')
                                      //       .insert({
                                      //         'amount': expenseAmt,
                                      //         'type': 'Payable',
                                      //         'date': formatDate(
                                      //           _dateController.text,
                                      //         ),
                                      //         'bank': 'Expense',
                                      //         'loanerName':
                                      //             realPartners[0]['name'],
                                      //         'phoneNumber': int.tryParse(
                                      //           realPartners[0]['phone_number'],
                                      //         ),
                                      //         'userId': userId,
                                      //         'partner_id': paymentValue,
                                      //       });
                                      // }

                                      Navigator.pop(context);
                                    } catch (e) {
                                      print("Error inserting expense: $e");
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text("Error: $e")),
                                      );
                                    } finally {
                                      setState(() => isLoading = false);
                                    }
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isLoading
                                    ? Colors.grey
                                    : const Color(0xff009966),
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
                                  : Text(
                                    translate("Add Expense"),
                                    style: TextStyle(color: Colors.white),
                                  ),
                        ),
                      ),

                      // Expanded(
                      //   flex: 3,
                      //   child: ElevatedButton(
                      //     onPressed:
                      //         isLoading
                      //             ? null
                      //             : () async {
                      //               if (_formKey.currentState!.validate()) {
                      //                 setState(() {
                      //                   isLoading = true;
                      //                 });

                      //                 print(_paymentController.text);
                      //                 print(_paidByController.text);
                      //                 print(_expenseNameController.text);
                      //                 print(_expenseCategoryController.text);
                      //                 print(_expenseTypeController.text);
                      //                 print(_descriptionController.text);
                      //                 print(_dateController.text);
                      //                 print(_amountController.text);

                      //                 final bankId = _paymentController.text;
                      //                 final expenseAmt =
                      //                     double.tryParse(
                      //                       _amountController.text,
                      //                     ) ??
                      //                     0.0;

                      //                 try {
                      //                   final bankRes =
                      //                       await Supabase.instance.client
                      //                           .from('bank')
                      //                           .select('balance')
                      //                           .eq('id', bankId)
                      //                           .single();

                      //                   print(bankRes);
                      //                   final currentBalance =
                      //                       (bankRes['balance'] as num)
                      //                           .toDouble();
                      //                   if (currentBalance >= expenseAmt) {
                      //                     final newBalance =
                      //                         currentBalance - expenseAmt;
                      //                     final upd = await Supabase
                      //                         .instance
                      //                         .client
                      //                         .from('bank')
                      //                         .update({'balance': newBalance})
                      //                         .eq('id', bankId);
                      //                     final expenseResponse = await Supabase
                      //                         .instance
                      //                         .client
                      //                         .from('expense')
                      //                         .insert({
                      //                           'amount':
                      //                               double.tryParse(
                      //                                 _amountController.text,
                      //                               ) ??
                      //                               0.0,
                      //                           'expenseName':
                      //                               _expenseNameController.text,
                      //                           'category':
                      //                               _expenseCategoryController
                      //                                   .text,
                      //                           'type':
                      //                               _expenseTypeController.text,
                      //                           'bankAccount':
                      //                               _paidByController.text ==
                      //                                       "Partner"
                      //                                   ? null
                      //                                   : _paymentController
                      //                                       .text,
                      //                           'paidBy':
                      //                               _paidByController.text,
                      //                           'description':
                      //                               _descriptionController.text,
                      //                           'date': formatDate(
                      //                             _dateController.text,
                      //                           ),
                      //                           'userid': 1,
                      //                         });
                      //                     print("Expense added successfully!");

                      //                     ScaffoldMessenger.of(
                      //                       context,
                      //                     ).showSnackBar(
                      //                       const SnackBar(
                      //                         content: Text(
                      //                           "Expense added successfully!",
                      //                         ),
                      //                       ),
                      //                     );
                      //                   } else {
                      //                     // Not enough funds
                      //                     ScaffoldMessenger.of(
                      //                       context,
                      //                     ).showSnackBar(
                      //                       const SnackBar(
                      //                         content: Text(
                      //                           'Insufficient balance in selected bank account.',
                      //                         ),
                      //                         backgroundColor: Colors.red,
                      //                       ),
                      //                     );
                      //                   }
                      //                   // Insert expense

                      //                   if (_paidByController.text ==
                      //                       "Partner") {
                      //                     var specific =
                      //                         _paymentController.text;
                      //                     print("Specific: $specific");
                      //                     print(specific.runtimeType);

                      //                     final x = await Supabase
                      //                         .instance
                      //                         .client
                      //                         .from('loan')
                      //                         .select("*")
                      //                         .eq("loanerName", specific);

                      //                     print(x);

                      //                     try {
                      //                       final singleLoanResponse =
                      //                           await Supabase.instance.client
                      //                               .from('loan')
                      //                               .insert({
                      //                                 'amount':
                      //                                     double.tryParse(
                      //                                       _amountController
                      //                                           .text,
                      //                                     ) ??
                      //                                     0.0,
                      //                                 'type': "Payable",

                      //                                 'date': formatDate(
                      //                                   _dateController.text,
                      //                                 ),
                      //                                 'bank': "Expense",
                      //                                 'loanerName': specific,
                      //                                 'phoneNumber':
                      //                                     x[0]['phoneNumber'],
                      //                                 'userId': 1,
                      //                               });
                      //                     } catch (e) {
                      //                       print("Error inserting loan: $e");
                      //                       ScaffoldMessenger.of(
                      //                         context,
                      //                       ).showSnackBar(
                      //                         SnackBar(
                      //                           content: Text("Error: $e"),
                      //                         ),
                      //                       );
                      //                     }
                      //                   }

                      //                   setState(() {
                      //                     isLoading = false;
                      //                   });

                      //                   Navigator.pop(context);
                      //                 } catch (e) {
                      //                   setState(() {
                      //                     isLoading = false;
                      //                   });
                      //                   print("Error inserting expense: $e");
                      //                   ScaffoldMessenger.of(
                      //                     context,
                      //                   ).showSnackBar(
                      //                     SnackBar(content: Text("Error: $e")),
                      //                   );
                      //                 }
                      //               }
                      //             },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor:
                      //           isLoading
                      //               ? Colors.grey
                      //               : const Color(0xff009966),
                      //       padding: const EdgeInsets.symmetric(vertical: 15),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //     ),
                      //     child:
                      //         isLoading
                      //             ? const SizedBox(
                      //               height: 20,
                      //               width: 20,
                      //               child: CircularProgressIndicator(
                      //                 color: Colors.white,
                      //                 strokeWidth: 2,
                      //               ),
                      //             )
                      //             : const Text(
                      //               "Add Expense",
                      //               style: TextStyle(color: Colors.white),
                      //             ),
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

String formatDate(String date) {
  List<String> parts = date.split('-'); // Split DD-MM-YYYY
  return '${parts[2]}-${parts[1]}-${parts[0]}'; // Convert to YYYY-MM-DD
}
