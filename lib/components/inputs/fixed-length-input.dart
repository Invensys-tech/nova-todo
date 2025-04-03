import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCustomTextInput extends StatelessWidget {
  final String hintText;
  final TextInputType whatIsInput;
  final TextEditingController controller;
  final int? maxLength;
  final String? label;
  final IconData? icon;
  final bool? hasError;
  final String? errorMessage;
  final String? Function(String?)? validator;

  const MyCustomTextInput({
    super.key,
    this.label,
    this.maxLength,
    this.hasError = false,
    this.errorMessage,
    required this.hintText,
    required this.whatIsInput,
    required this.controller,
    this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
              label!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )
            : Container(),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: controller,
          keyboardType: whatIsInput,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          buildCounter: (
            context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) {
            return hasError != null && hasError!
                ? Text(
                  '$errorMessage',
                  style: TextStyle(fontSize: 8, color: Colors.red.shade800),
                )
                : Container();
          },
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
          validator: validator,
        ),
      ],
    );
  }
}
