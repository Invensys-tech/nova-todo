import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/partner-entity.dart';
import 'package:flutter_application_1/repositories/partner.repository.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/loandate.dart';
import 'package:flutter_application_1/ui/inputs/loantype.dart';
import 'package:flutter_application_1/ui/inputs/partner.selector.dart';
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
  List<Partner> _partnerList = [];

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());

    PartnerRepository()
        .fetchPartners()
        .then(
          (p) => setState(() {
            _partnerList = p;
            print("LOADED PARTNERS:");
            print(_partnerList);
          }),
        )
        .catchError((e) => print("Error loading partners: $e"));

    print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");

    print(_partnerList);

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

                  PartnerSelector(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a loaner';
                      }
                      return null;
                    },
                    suggestions:
                        _partnerList
                            .map((l) => {"label": l.name, "value": l.id})
                            .toList() ??
                        [],
                    onSelect: (selected) {
                      final partner = _partnerList.firstWhere(
                        (l) => l.id == selected,
                        orElse:
                            () => Partner(id: 0, phone_number: '', name: ''),
                      );
                      _phoneNumber.text = partner.phone_number ?? '';
                      setState(() {});
                    },
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
                                      final loanerInput =
                                          _loanerName.text.trim();

                                      final existing = _partnerList.firstWhere(
                                        (p) =>
                                            p.name.toString().toLowerCase() ==
                                            loanerInput.toLowerCase(),
                                        orElse:
                                            () => Partner(
                                              id: 0,
                                              name: "",
                                              phone_number: "",
                                            ),
                                      );

                                      late final int partnerId;
                                      if (existing.id != 0) {
                                        partnerId = existing.id;
                                        print(
                                          "Found existing partner with ID: $partnerId",
                                        );
                                      } else {
                                        final newPartner =
                                            await PartnerRepository()
                                                .createPartner({
                                                  "name": loanerInput,
                                                  "phone_number":
                                                      _phoneNumber.text.trim(),
                                                  "user_id": userId,
                                                });
                                        partnerId = newPartner.id;
                                        print(
                                          "Created new partner with ID: $partnerId",
                                        );
                                      }

                                      final accountHolder =
                                          _bank.text.split('-')[0];
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
                                          const SnackBar(
                                            content: Text(
                                              'Insufficient bank balance',
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      await Supabase.instance.client
                                          .from('bank')
                                          .update({
                                            'balance':
                                                _type.text == 'Receivable'
                                                    ? currentBalance + loanAmt
                                                    : currentBalance - loanAmt,
                                          })
                                          .eq('id', bankRec['id']);

                                      await Supabase.instance.client
                                          .from('loan')
                                          .insert({
                                            'amount': loanAmt,
                                            'loanerName':
                                                _loanerName.text.trim(),
                                            'type': _type.text,
                                            'bank': accountHolder,
                                            'phoneNumber':
                                                _phoneNumber.text.trim(),
                                            'userId': userId,
                                            'date': formatDate(
                                              _dateController.text,
                                            ),
                                            'partner_id': partnerId,
                                          });

                                      final updatedLoans =
                                          await Datamanager().getLoan();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
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
