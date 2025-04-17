import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/bankinput.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
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
          "Add Bank",
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
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
              border: Border.all(
                color: Color(0xff27272A), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(8),

              // Optional: rounded corners
            ),
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  "Account Owner",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                TextFields(
                  hinttext: 'eg: Abebe Tesfaye',
                  whatIsInput: '1',
                  controller: _accHolder,
                  // icon: Icons.attach_money,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  "Bank",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                AutoCompleteText(
                  suggestions: banks,
                  controller: _bank,
                  hintText: "Banks",
                  icon: Icons.search,
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

                const Text(
                  "AccountNumber",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFields(
                  hinttext: 'Branch',
                  whatIsInput: '1',
                  controller: _accNo,
                  // icon: Icons.attach_money,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  "Branch",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFields(
                  hinttext: 'Branch',
                  whatIsInput: '1',
                  controller: _branch,
                  // icon: Icons.attach_money,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                Text(
                  "Account type",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                CustomDropdown(
                  hintText: "Eg, Saving or Check",
                  // icon: Icons.local_mall,
                  items: ["Savings", "Check"],
                  controller: _type,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  "Balance",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFields(
                  hinttext: 'Balance',
                  whatIsInput: '0',
                  controller: _balance,
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
                          backgroundColor: Color(0xff27272A), // Gray background
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
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final response = await Supabase.instance.client
                                .from('bank')
                                .insert({
                                  'balance': _balance.text,
                                  'accountHolder': _accHolder.text,
                                  'accountNumber': _accNo.text,
                                  'accountBank': _bank.text,
                                  'branch': _branch.text,
                                  'userId': 1,
                                  'accountType': _type.text,
                                });

                            print(response);

                            print("Bank added successfully!");
                            final updatedBanks =
                                await Datamanager().fetchBanks();

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Bank added successfully!"),
                              ),
                            );

                            // Pass the updated loan data back before popping the screen
                            Navigator.pop(context, updatedBanks);
                          } catch (e) {
                            print("Error inserting expense: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")),
                            );
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(
                            0xff009966,
                          ), // Green background
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
