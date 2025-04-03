import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class MyTextInput extends StatefulWidget {
  final String label;
  final TextFields textFields;
  const MyTextInput({super.key, required this.label, required this.textFields});

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        widget.textFields,
      ],
    );
  }
}
