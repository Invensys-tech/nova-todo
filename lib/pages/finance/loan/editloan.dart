import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/loan-entity.dart';
import 'package:flutter_application_1/pages/finance/loan/addloan.dart';
import 'package:flutter_application_1/repositories/loan.repository.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class EditLoan extends StatefulWidget {
  final int loanId;
  final Datamanager datamanager;

  const EditLoan({super.key, required this.loanId, required this.datamanager});

  @override
  State<EditLoan> createState() => _EditLoanState();
}

class _EditLoanState extends State<EditLoan> {
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

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLoan();
  }

  void _fetchLoan() async {
    try {
      final loan = await LoanRepository().getSingleLoan(widget.loanId);
      print(loan.loanerName);
      setState(() {
        _loanerName.text = loan.loanerName;
        _phoneNumber.text = loan.phoneNumber;
        _amount.text = loan.amount.toString();
        _type.text = loan.type;
        _dateController.text = loan.date.toIso8601String().split("T").first;

        _bank.text = loan.bank ?? '';
        _isLoading = false;
      });
    } catch (e) {
      print("Failed to fetch loan: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching loan")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2F2F2F),
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2F2F),
        title: const Text(
          "Edit Loan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: BackButton(color: Colors.white),
        centerTitle: true,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.045,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildLabel("Loaner Name"),
                      AutoCompleteText(
                        suggestions: searchItems,
                        controller: _loanerName,
                        hintText: "Loaner Name",
                        icon: Icons.shopping_bag_rounded,
                        suggestionBuilder: (String text) {
                          return ListTile(
                            title: Text(
                              text,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: const Text(
                              "Tap to select",
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        },
                      ),
                      _spacer(),
                      _buildLabel("Phone Number"),
                      TextFields(
                        controller: _phoneNumber,
                        icon: Icons.phone,
                        hinttext: "Phone",
                        whatIsInput: '0',
                      ),
                      _spacer(),
                      _buildLabel("Amount"),
                      TextFields(
                        controller: _amount,
                        icon: Icons.attach_money,
                        hinttext: "Amount",
                        whatIsInput: '0',
                      ),
                      _spacer(),
                      _buildLabel("Types"),
                      CustomDropdown(
                        items: ["Payable", "Receivable"],
                        controller: _type,
                        icon: Icons.category,
                        hintText: "Select a Type",
                      ),
                      _spacer(),
                      _buildLabel("Date"),
                      DateSelector(
                        controller: _dateController,
                        icon: Icons.calendar_today,
                        hintText: "Pick a date",
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ),
                      _spacer(),
                      _buildLabel("Bank"),
                      CustomDropdown(
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
                        icon: Icons.account_balance,
                        hintText: "Select a Bank",
                      ),
                      _spacer(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
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
                                  await supabaseClient
                                      .from('loan')
                                      .update({
                                        'loanerName': _loanerName.text,
                                        'phoneNumber': _phoneNumber.text,
                                        'amount': _amount.text,

                                        'type': _type.text,
                                        'date': _dateController.text,
                                        'bank': _bank.text,
                                      })
                                      .eq('id', widget.loanId);

                                  final updatedLoans =
                                      await widget.datamanager.fetchLoan();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Loan updated successfully!",
                                      ),
                                    ),
                                  );

                                  Navigator.pop(context, updatedLoans);
                                } catch (e) {
                                  print("Update error: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: $e")),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text(
                                "Update Loan",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      _spacer(height: 40),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.white70),
      ),
    );
  }

  Widget _spacer({double height = 20}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (height / 800),
    );
  }
}
