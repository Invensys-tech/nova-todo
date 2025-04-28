import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/bank-entity.dart';
import 'package:flutter_application_1/repositories/bank-repository.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/bankinput.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditBank extends StatefulWidget {
  final int bankId;
  final Datamanager datamanager;
  const EditBank({super.key, required this.bankId, required this.datamanager});

  @override
  State<EditBank> createState() => _EditBankState();
}

class _EditBankState extends State<EditBank> {
  final TextEditingController _accHolder = TextEditingController();
  final TextEditingController _accNo = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _balance = TextEditingController();

  final List<String> banksList = [
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

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBank();
  }

  Future<void> _fetchBank() async {
    try {
      final bankEntity = await BankRepository().getSinglrBank(widget.bankId);
      setState(() {
        _accHolder.text = bankEntity.accountHolder;
        _accNo.text = bankEntity.accountNumber.toString();
        _bank.text = bankEntity.accountBank;
        _branch.text = bankEntity.branch;
        _type.text = bankEntity.accountType;
        _balance.text = bankEntity.balance.toString();
        _isLoading = false;
      });
    } catch (e) {
      print("Failed to fetch bank: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching bank")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
          backgroundColor: const Color(0xff2F2F2F),
          appBar: AppBar(
            backgroundColor: const Color(0xff2F2F2F),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const Text(
              "Edit Bank",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // centerTitle: true,
          ),
          body: const Center(child: CircularProgressIndicator()),
        )
        : Scaffold(
          backgroundColor: const Color(0xff2F2F2F),
          appBar: AppBar(
            backgroundColor: const Color(0xff2F2F2F),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const Text(
              "Edit Bank",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
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
                      "Account holder name",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    TextFields(
                      hinttext: 'Account holder name',
                      whatIsInput: '1',
                      controller: _accHolder,
                      // icon: Icons.attach_money,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const Text(
                      "Bank Account",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    // BankInput(bankController: _bank, valueController: _accNo),
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
                      suggestions: banksList,
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
                    // TextFields(
                    //   hinttext: 'Account Number',
                    //   whatIsInput: '0',
                    //   controller: _accNo,
                    //   // icon: Icons.attach_money,
                    // ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    // const Text(
                    //   "Account Bank",
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w300,
                    //     color: Colors.white70,
                    //   ),
                    // ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    // AutoCompleteText(
                    //   suggestions: banksList,
                    //   controller: _bank,
                    //   hintText: "Account Bank",
                    //   icon: Icons.shopping_bag_rounded,
                    //   suggestionBuilder: (String text) {
                    //     return ListTile(
                    //       title: Text(
                    //         text,
                    //         style: const TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       subtitle: const Text(
                    //         "Tap to select",
                    //         style: TextStyle(fontSize: 12, color: Colors.grey),
                    //       ),
                    //     );
                    //   },
                    // ),
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
                    const Text(
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
                    const Text(
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
                          child: ElevatedButton(
                            onPressed: () {
                              // Clear all input controllers and pop
                              _accHolder.clear();
                              _accNo.clear();
                              _bank.clear();
                              _branch.clear();
                              _type.clear();
                              _balance.clear();
                              setState(() {});
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
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
                                // Update bank record using Supabase update
                                final response = await Supabase.instance.client
                                    .from('bank')
                                    .update({
                                      'accountHolder': _accHolder.text,
                                      'accountNumber': _accNo.text,
                                      'accountBank': _bank.text,
                                      'branch': _branch.text,
                                      'accountType': _type.text,
                                      'balance': _balance.text,
                                    })
                                    .eq('id', widget.bankId);
                                print(response);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Bank updated successfully!"),
                                  ),
                                );
                                // Optionally, fetch updated banks list and return it:
                                final updatedBanks =
                                    await Datamanager().fetchBanks();
                                Navigator.pop(context, updatedBanks);
                              } catch (e) {
                                print("Error updating bank: $e");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              "Update Bank",
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
