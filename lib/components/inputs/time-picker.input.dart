import 'package:flutter/material.dart';

class MyTimePicker extends StatefulWidget {
  final void Function(TimeOfDay timeOfDay) onChange;
  final String label;

  const MyTimePicker({super.key, required this.label, required this.onChange});

  @override
  State<MyTimePicker> createState() => MyTimePickerState();
}

class MyTimePickerState extends State<MyTimePicker> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        widget.onChange(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: MediaQuery.of(context).size.width * 0.01,
      children: [
        Text(widget.label),
        ElevatedButton(
          onPressed: () => _selectTime(context),
          child: Text('${_selectedTime.hour}:${_selectedTime.minute}'),
        ),
      ],
    );
  }
}
