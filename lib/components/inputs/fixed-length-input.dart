import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCustomTextInput extends StatefulWidget {
  final String hintText;
  final TextInputType whatIsInput;
  final TextEditingController controller;
  final int? maxLength;
 // final String? label;
  final IconData? icon;
  final bool? hasError;
  final String? errorMessage;
  final String? Function(String?)? validator;
  final int? maxValue;

  const MyCustomTextInput({
    super.key,
   // this.label,
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




  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Initialize the FocusNode
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Dispose of the FocusNode when the widget is disposed
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.whatIsInput,
        maxLength: widget.maxLength,
        focusNode: _focusNode,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        onChanged: (value) {
          if (value.isEmpty) {
            _focusNode.requestFocus();
          }
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

        onEditingComplete: () {
          // Request focus back after the editing is complete
          _focusNode.requestFocus();
        },
        decoration: InputDecoration(
          // Ensure spacing

          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          hintText: widget.hintText,
          filled: false,
          fillColor:Theme.of(context).scaffoldBackgroundColor,
          hintStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
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
    );
  }
}
