import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class MyTextInput extends StatefulWidget {
  final String? label;
  final TextFields textFields;
  const MyTextInput({super.key, this.label, required this.textFields});

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: MediaQuery.of(context).size.height * 0.008,
      children: [
        widget.label != null
            ? Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                widget.label!,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            )
            : Container(),
        widget.textFields,
      ],
    );
  }
}
