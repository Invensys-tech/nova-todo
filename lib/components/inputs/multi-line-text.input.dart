import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';

class MyMultiLineTextInput extends StatefulWidget {
  final String label;
  final MultiLineTextField textFields;

  const MyMultiLineTextInput({
    super.key,
    required this.label,
    required this.textFields,
  });

  @override
  State<MyMultiLineTextInput> createState() => _MyMultiLineTextInputState();
}

class _MyMultiLineTextInputState extends State<MyMultiLineTextInput> {
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
