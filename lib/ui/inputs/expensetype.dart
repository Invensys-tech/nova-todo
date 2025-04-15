import 'package:flutter/material.dart';

class ExpenseTypeSelector extends StatefulWidget {
  final TextEditingController controller;

  const ExpenseTypeSelector({super.key, required this.controller});

  @override
  State<ExpenseTypeSelector> createState() => _ExpenseTypeSelectorState();
}

class _ExpenseTypeSelectorState extends State<ExpenseTypeSelector> {
  final List<String> _options = ["Must", "Maybe", "Unwanted"];
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption =
        widget.controller.text.isNotEmpty ? widget.controller.text : null;
  }

  Color _getColor(String option) {
    switch (option) {
      case "Must":
        return Colors.green;
      case "Maybe":
        return Colors.yellow;
      case "Unwanted":
        return Colors.red;
      default:
        return Colors.white30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Types of Expenses",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              _options.map((option) {
                final isSelected = _selectedOption == option;
                final color = isSelected ? _getColor(option) : Colors.white30;

                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedOption = option;
                          widget.controller.text = option;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<String>(
                            value: option,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                                widget.controller.text = value;
                              });
                            },
                            fillColor: MaterialStateProperty.all(color),
                          ),
                          Text(option, style: TextStyle(color: color)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
