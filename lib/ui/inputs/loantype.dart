import 'package:flutter/material.dart';

class TypeSelector extends StatefulWidget {
  final TextEditingController controller;

  const TypeSelector({super.key, required this.controller});

  @override
  State<TypeSelector> createState() => _TypeSelectorState();
}

class _TypeSelectorState extends State<TypeSelector> {
  String? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType =
        widget.controller.text.isNotEmpty ? widget.controller.text : "Payable";
    widget.controller.text = selectedType!;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        _buildOption("Payable", Colors.red),
        _buildOption("Receivable", Colors.green),
      ],
    );
  }

  Widget _buildOption(String type, Color activeColor) {
    final bool isSelected = selectedType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
          widget.controller.text = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isSelected ? activeColor : Theme.of(context).primaryColorLight,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color:
                  isSelected
                      ? activeColor
                      : Theme.of(context).primaryColorLight,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              type,
              style: TextStyle(
                color:
                    isSelected
                        ? activeColor
                        : Theme.of(context).primaryColorLight,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
