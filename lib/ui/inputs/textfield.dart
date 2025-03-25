import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final String hinttext;
  final String whatIsInput;
  final TextEditingController controller;
  final IconData? icon;
  final String? Function(String?)? func;

  const TextFields({
    super.key,
    required this.hinttext,
    required this.whatIsInput,
    required this.controller,
    this.icon,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      keyboardType:
          whatIsInput == "0" ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon:
            icon != null
                ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white54,
                        width: 1.0,
                      ), // Border between icon & input
                    ),
                  ),
                  child: Icon(
                    icon, // Display the icon
                    color: Colors.white70, // Icon color
                  ),
                )
                : null,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 50,
        ), // Ensure spacing
        hintText: hinttext,
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
      validator: func,
    );
  }
}
