import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCustomTextInput extends StatefulWidget {
  final String hintText;
  final TextInputType whatIsInput;
  final TextEditingController controller;
  final int? maxLength;
  final String? label;
  final IconData? icon;
  final bool? hasError;
  final String? errorMessage;
  final String? Function(String?)? validator;
  final int? maxValue;

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
    this.maxValue,
  });

  @override
  State<MyCustomTextInput> createState() => _MyCustomTextInputState();
}

class _MyCustomTextInputState extends State<MyCustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Text(
              widget.label!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )
            : Container(),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: widget.controller,
          keyboardType: widget.whatIsInput,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: (value) {
            if (widget.maxLength != null && value.length == widget.maxLength) {
              FocusScope.of(context).nextFocus();
              if (widget.maxValue != null && int.parse(value) > widget.maxValue!) {
                setState(() {
                  value = widget.maxValue!.toString();
                  widget.controller.text = widget.maxValue!.toString();
                });
              }
            }
          },
          buildCounter: (
            context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) {
            return widget.hasError != null && widget.hasError!
                ? Text(
                  '${widget.errorMessage}',
                  style: TextStyle(fontSize: 8, color: Colors.red.shade800),
                )
                : Container();
          },
          decoration: InputDecoration(
            prefixIcon:
                widget.icon != null
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
                        widget.icon, // Display the icon
                        color: Colors.white70, // Icon color
                      ),
                    )
                    : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 50,
            ), // Ensure spacing
            hintText: widget.hintText,
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
          validator: widget.validator,
        ),
      ],
    );
  }
}
