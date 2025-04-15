import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateOption { inOneWeek, inOneMonth }

class CustomLoanDateSelectorRow extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;

  const CustomLoanDateSelectorRow({
    super.key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
  });

  @override
  State<CustomLoanDateSelectorRow> createState() =>
      _CustomDateSelectorRowState();
}

class _CustomDateSelectorRowState extends State<CustomLoanDateSelectorRow> {
  DateOption? _selectedOption;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    widget.controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
  }

  void _handleRadioChange(DateOption option) {
    setState(() {
      _selectedOption = option;
      if (option == DateOption.inOneWeek) {
        _selectedDate = DateTime.now().add(const Duration(days: 7));
      } else if (option == DateOption.inOneMonth) {
        _selectedDate = DateTime.now().add(const Duration(days: 30));
      }
      widget.controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? widget.initialDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    if (picked != null) {
      setState(() {
        _selectedOption = null;
        _selectedDate = picked;
        widget.controller.text = DateFormat.yMd().format(picked);
      });
    }
  }

  Widget _buildRadio(DateOption option, String label) {
    bool isSelected = _selectedOption == option;
    Color borderColor = isSelected ? Colors.green : Colors.white30;
    Color textColor = isSelected ? Colors.green : Colors.white70;

    return Expanded(
      child: InkWell(
        onTap: () => _handleRadioChange(option),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<DateOption>(
                value: option,
                groupValue: _selectedOption,
                onChanged: (value) {
                  if (value != null) {
                    _handleRadioChange(value);
                  }
                },
                fillColor: MaterialStateProperty.all(borderColor),
              ),
              Text(label, style: TextStyle(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    bool isCustomSelected = _selectedOption == null;
    Color borderColor = isCustomSelected ? Colors.green : Colors.white30;
    Color textColor = isCustomSelected ? Colors.green : Colors.white70;

    return Expanded(
      child: InkWell(
        onTap: _selectDate,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: textColor, size: 18),
              const SizedBox(width: 8),
              Text(
                widget.controller.text.isNotEmpty
                    ? widget.controller.text
                    : widget.hintText,
                style: TextStyle(color: textColor, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildRadio(DateOption.inOneWeek, "In 1 Week"),
        _buildRadio(DateOption.inOneMonth, "In 1 Month"),
        _buildDatePicker(),
      ],
    );
  }
}
