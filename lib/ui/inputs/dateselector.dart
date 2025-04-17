import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure to add intl package in your pubspec.yaml

class DateSelector extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final DateFormat dateFormat;

  // Removed "const" from the constructor to allow runtime DateFormat creation.
  DateSelector({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    DateFormat? dateFormat,
  }) : dateFormat = dateFormat ?? DateFormat('dd-MM-yyyy'),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true, // Prevents keyboard from showing
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.white54, width: 1.0),
            ),
          ),
          child: Icon(icon, color: Colors.white70),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
        hintText: hintText,
        filled: true,
        fillColor: Colors.black87.withOpacity(.3),
        hintStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w200,
          color: Colors.white60,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 2, color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green.withOpacity(.3),
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38.withOpacity(.3),
            width: 1.0,
          ),
        ),
      ),
      onTap: () async {
        DateTime initDate = initialDate ?? DateTime.now();
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: firstDate,
          lastDate: lastDate,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Colors.green, // header background color
                  onPrimary: Colors.white, // header text color
                  surface: Colors.black87, // background color
                  onSurface: Colors.white70, // body text color
                ),
                dialogBackgroundColor: Colors.black,
              ),
              child: child ?? const SizedBox(),
            );
          },
        );
        if (pickedDate != null) {
          controller.text = dateFormat.format(pickedDate);
        }
      },
    );
  }
}
