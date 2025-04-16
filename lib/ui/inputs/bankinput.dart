// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class BankInput extends StatefulWidget {
  final TextEditingController bankController;
  final TextEditingController valueController;

  const BankInput({
    Key? key,
    required this.bankController,
    required this.valueController,
  }) : super(key: key);

  @override
  State<BankInput> createState() => _BankInputState();
}

class _BankInputState extends State<BankInput> {
  String? selectedBank;

  final List<String> banks = const [
    "CBE",
    "Dashen",
    "Awash",
    "Abyssinia",
    "Nib",
    "Wegagen",
    "Zemen",
    "Abay",
    "Berhan",
    "Enat",
    "Oromia Coop",
    "Lion",
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the local state from the bankController if already set
    selectedBank =
        widget.bankController.text.isNotEmpty
            ? widget.bankController.text
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dropdown styled as a badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: Color(0xFF3A3643),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.black87,
              value: selectedBank,
              hint: const Text(
                "Bank",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white60),
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              items:
                  banks.map((bank) {
                    return DropdownMenuItem<String>(
                      value: bank,
                      child: Text(bank),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBank = value;
                });
                widget.bankController.text = value!;
              },
            ),
          ),
        ),

        // Input field
        Expanded(
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: widget.valueController,
            decoration: InputDecoration(
              hintText: 'eg: Account Number',
              filled: true,
              fillColor: Colors.black87.withOpacity(0.3),
              hintStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w200,
                color: Colors.white60,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                borderSide: BorderSide(
                  color: Colors.greenAccent.withOpacity(0.5),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                borderSide: BorderSide(
                  color: Colors.black38.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
