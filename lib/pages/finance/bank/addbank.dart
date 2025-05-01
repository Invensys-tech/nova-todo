import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/bankinput.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  final TextEditingController _accHolder = TextEditingController();
  final TextEditingController _accNo = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _balance = TextEditingController();
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
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
          translate("Add Bank"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                    translate("Account Owner"),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),

                  TextFields(
                    hinttext: 'eg: Abebe Tesfaye',
                    whatIsInput: '1',
                    controller: _accHolder,
                    func: (v) {
                      if (v!.isEmpty || v == null) {
                        return "Account holder name is required";
                      }
                    },
                    // icon: Icons.attach_money,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    translate("Bank"),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),

                  AutoCompleteText(
                    suggestions: banks,
                    controller: _bank,
                    hintText: "Banks",
                    icon: Icons.search,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a Bank';
                      }
                      return null;
                    },
                    suggestionBuilder: (String text) {
                      return ListTile(
                        title: Text(
                          text,
                          style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            // fontSize: 16,
                            // color: Colors.white,
                          ),
                        ),
                        // subtitle: const Text(
                        //   "Tap to select",
                        //   style: TextStyle(fontSize: 12, color: Colors.grey),
                        // ),
                      );
                    },
                  ),

                  // BankInput(bankController: _bank, valueController: _accNo),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  Text(
                    translate("AccountNumber"),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                  TextFields(
                    hinttext: 'Account Number',
                    whatIsInput: '1',
                    controller: _accNo,
                    func: (value) {
                      if (value == null || value.isEmpty)
                        return 'Account Number is required';
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0)
                        return 'Enter a valid amount';
                      return null;
                    },

                    // icon: Icons.attach_money,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    translate("Branch"),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                  TextFields(
                    hinttext: 'Branch',
                    whatIsInput: '1',
                    controller: _branch,
                    func: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Branch name is required';
                      }
                    },

                    // icon: Icons.attach_money,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  Text(
                    "Account type",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                  CustomDropdown(
                    hintText: "Eg, Saving or Check",
                    // icon: Icons.local_mall,
                    items: ["Savings", "Check"],
                    controller: _type,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    translate("Balance"),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                  TextFields(
                    hinttext: 'Balance',
                    whatIsInput: '0',
                    controller: _balance,
                    prefixText: 'ETB',
                    func: (value) {
                      if (value == null || value.isEmpty)
                        return 'Balance is required';
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0)
                        return 'Enter a valid amount';
                      return null;
                    },

                    // icon: Icons.attach_money,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            // Clear all input controllers
                            _accHolder.clear();
                            _bank.clear();
                            _balance.clear();
                            _accNo.clear();
                            _type.clear();
                            _branch.clear();
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
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      print("userid");
                                      print(userId);

                                      try {
                                        final response = await Supabase
                                            .instance
                                            .client
                                            .from('bank')
                                            .insert({
                                              'balance': _balance.text,
                                              'accountHolder': _accHolder.text,
                                              'accountNumber': _accNo.text,
                                              'accountBank': _bank.text,
                                              'branch': _branch.text,
                                              'userId': userId,
                                              'accountType': _type.text,
                                            });

                                        print(response);

                                        print("Bank added successfully!");
                                        final updatedBanks =
                                            await Datamanager().fetchBanks();

                                        // Show success message
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Bank added successfully!",
                                            ),
                                          ),
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });

                                        // Pass the updated loan data back before popping the screen
                                        Navigator.pop(context, updatedBanks);
                                      } catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        print("Error inserting expense: $e");
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text("Error: $e")),
                                        );
                                      }
                                    }
                                    ;
                                  },

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isLoading
                                    ? Colors.grey
                                    : Color(0xff009966), // Green background
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            translate("Save"),
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
        ),
      ),
    );
  }
}
