import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart'; // For formatDate() if needed
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditSingleLoan extends StatefulWidget {
  final int singleLoanId;
  final int parentLoanId;
  const EditSingleLoan({
    super.key,
    required this.singleLoanId,
    required this.parentLoanId,
  });

  @override
  State<EditSingleLoan> createState() => _EditSingleLoanState();
}

class _EditSingleLoanState extends State<EditSingleLoan> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _paidFrom = TextEditingController();
  final TextEditingController _specificFrom = TextEditingController();
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

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSingleLoan();
  }

  Future<void> _fetchSingleLoan() async {
    try {
      // Fetch the single loan record by its id.
      final data =
          await Supabase.instance.client
              .from('single_loan')
              .select('*')
              .eq('id', widget.singleLoanId)
              .maybeSingle();

      if (data == null) {
        throw Exception("Loan not found");
      }

      // Set the controllers with the fetched data.
      setState(() {
        _amount.text = (data['amount'] ?? 0).toString();
        _type.text = data['type'] ?? '';
        // Assume the date is stored as a string; format it if necessary.
        _dateController.text =
            (data['date'] as String)
                .toString(); // or use toIso8601String() if needed
        _paidFrom.text = data['paidFrom'] ?? '';
        _specificFrom.text = data['specificFrom'] ?? '';
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching single loan: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching loan")));
      Navigator.pop(context);
    }
  }

  // You can use the same formatDate function from your add screen.
  String formatDate(String dateStr) {
    List<String> parts = dateStr.split('-'); // expects DD-MM-YYYY
    if (parts.length < 3) return dateStr;
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    // Determine items for Specific From dropdown based on _paidFrom value.
    List<String> specificItems = [];
    if (_paidFrom.text == "Partner") {
      specificItems = searchNames;
    } else if (_paidFrom.text == "Bank") {
      specificItems = banks;
    }

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
              "Edit Loan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
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
              "Edit Loan",
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
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Amount",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFields(
                    hinttext: '0.0',
                    whatIsInput: '0',
                    controller: _amount,
                    icon: Icons.attach_money,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Type",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomDropdown(
                    hintText: "Select an option",
                    icon: Icons.local_mall,
                    items: ["Payable", "Receivable"],
                    controller: _type,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  DateSelector(
                    hintText: "Select a date",
                    controller: _dateController,
                    icon: Icons.calendar_today,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Paid From",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomDropdown(
                    hintText: "Select an option",
                    icon: Icons.local_mall,
                    items: ["Partner", "Bank"],
                    controller: _paidFrom,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Specific From",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomDropdown(
                    hintText: "Select an option",
                    icon: Icons.account_balance,
                    items: specificItems,
                    controller: _specificFrom,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Clear all input controllers and pop.
                            _amount.clear();
                            _specificFrom.clear();
                            _dateController.clear();
                            _paidFrom.clear();
                            _type.clear();
                            // Note: Do not clear parentLoanId here.
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
                            // Build the update map.
                            Map<String, dynamic> updatedLoan = {
                              'amount': double.tryParse(_amount.text) ?? 0.0,
                              'type': _type.text,
                              'date': formatDate(_dateController.text),
                              'paidFrom': _paidFrom.text,
                              'specificFrom': _specificFrom.text,
                              'parentId': widget.parentLoanId,
                            };
                            try {
                              final response = await Supabase.instance.client
                                  .from('single_loan')
                                  .update(updatedLoan)
                                  .eq('id', widget.singleLoanId);
                              print(response);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Loan updated successfully!"),
                                ),
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              print("Error updating loan: $e");
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
                            "Update Loan",
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
        );
  }
}
