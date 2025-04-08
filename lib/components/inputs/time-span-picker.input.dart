import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class MyTimeSpanPicker extends StatefulWidget {
  final void Function(TimeOfDay, TimeOfDay) onChange;
  final String label;

  const MyTimeSpanPicker({
    super.key,
    required this.label,
    required this.onChange,
  });

  @override
  State<MyTimeSpanPicker> createState() => MyTimeSpanPickerState();
}

class MyTimeSpanPickerState extends State<MyTimeSpanPicker> {
  late TimeOfDay _startTime = TimeOfDay.now();
  late TimeOfDay _endTime;
  late String formattedEndTime;
  late String formattedStartTime;

  @override
  void initState() {
    super.initState();
    int endMinute = _startTime.minute + 30;
    _endTime = TimeOfDay(
      hour: _startTime.hour + ((endMinute) ~/ 60),
      minute: endMinute % 60,
    );
    formattedStartTime = formatDoubleDigitTime(
      _startTime.hour,
      _startTime.minute,
    );
    formattedEndTime = formatDoubleDigitTime(_endTime.hour, _endTime.minute);
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
        widget.onChange(picked, _endTime);
        formattedStartTime = formatDoubleDigitTime(
          _startTime.hour,
          _startTime.minute,
        );
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
        widget.onChange(_startTime, picked);
        formattedEndTime = formatDoubleDigitTime(
          _endTime.hour,
          _endTime.minute,
        );
      });
    }
  }

  void _showAlertDialog(BuildContext context) {
    // Todo: capture state change on the dialog

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Round the corners
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _selectStartTime(context),
                  child: Text('Start Time $formattedStartTime'),
                ),
                ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  child: Text('End Time $formattedEndTime'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }

  handleShowAlertDialog() {
    _showAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: MediaQuery.of(context).size.width * 0.01,
      children: [
        Text(widget.label),
        ElevatedButton(
          onPressed: handleShowAlertDialog,
          child: Text('$formattedStartTime - $formattedEndTime'),
        ),
      ],
    );
  }
}
