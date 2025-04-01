import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';

class MyDateTimeInput extends StatefulWidget {
  final String label;
  final DateSelector dateFields;
  const MyDateTimeInput({
    super.key,
    required this.label,
    required this.dateFields,
  });

  @override
  State<MyDateTimeInput> createState() => _MyDateTimeInputState();
}

class _MyDateTimeInputState extends State<MyDateTimeInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        widget.dateFields,
      ],
    );
  }
}
