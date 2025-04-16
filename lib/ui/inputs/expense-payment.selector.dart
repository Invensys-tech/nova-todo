import 'package:flutter/material.dart';

class PaymentInputRow extends StatefulWidget {
  final TextEditingController leftController;
  final TextEditingController rightController;
  final List<String> leftItems;
  final List<String> rightItems;

  const PaymentInputRow({
    Key? key,
    required this.leftController,
    required this.rightController,
    required this.leftItems,
    required this.rightItems,
  }) : super(key: key);

  @override
  _PaymentInputRowState createState() => _PaymentInputRowState();
}

class _PaymentInputRowState extends State<PaymentInputRow> {
  String? selectedLeft;
  String? selectedRight;

  @override
  void initState() {
    super.initState();
    // Initialize from the controllers if they already have a value.
    selectedLeft =
        widget.leftController.text.isNotEmpty
            ? widget.leftController.text
            : null;
    selectedRight =
        widget.rightController.text.isNotEmpty
            ? widget.rightController.text
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left dropdown – styled as a badge.
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
              value: selectedLeft,
              hint: const Text(
                "Paid By",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white60),
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              items:
                  widget.leftItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLeft = value;
                });
                widget.leftController.text = value ?? '';
              },
            ),
          ),
        ),
        // Right dropdown – for selecting an expense.
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black87.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(
                color: Colors.black38.withOpacity(0.3),
                width: 1.0,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.black87,
                value: selectedRight,
                hint: const Text(
                  "Specific Expense",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white60),
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                isExpanded: true,
                items:
                    widget.rightItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRight = value;
                  });
                  widget.rightController.text = value ?? '';
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
