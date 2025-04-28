import 'package:flutter/material.dart';

class TermSelector extends StatefulWidget {
  final TextEditingController controller;

  const TermSelector({super.key, required this.controller});

  @override
  State<TermSelector> createState() => _TermSelectorState();
}

class _TermSelectorState extends State<TermSelector> {
  final List<String> _options = ["Daily", "Weekely", "Monthly"];
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption =
        widget.controller.text.isNotEmpty ? widget.controller.text : null;
  }

  Color _getColor(bool isSelected) {
    return isSelected ? Colors.green : Colors.grey.withOpacity(.5);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Term",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              _options.map((option) {
                final isSelected = _selectedOption == option;
                final color = _getColor(isSelected);

                return Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height*.04,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
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
