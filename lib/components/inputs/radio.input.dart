import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyRadioInput extends StatefulWidget {
  final String? label;
  final String? orientation;
  final String groupKey;
  final List<String> options;
  final void Function(dynamic value) onChanged;
  const MyRadioInput({
    super.key,
    this.label,
    this.orientation = 'horizontal',
    required this.groupKey,
    required this.options,
    required this.onChanged,
  });

  @override
  State<MyRadioInput> createState() => MyRadioInputState();
}

class MyRadioInputState extends State<MyRadioInput> {
  String _selectedValue = '';

  void selectValue(value) {
    setState(() {
      _selectedValue = value;
    });

    widget.onChanged(value);
  }

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
        widget.orientation == 'horizontal'
            ? Row(
              children:
                  widget.options
                      .map(
                        (option) => Expanded(
                          child: ListTile(
                            title: Text(option),
                            leading: Radio(
                              value: option,
                              groupValue: _selectedValue,
                              onChanged: selectValue,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            )
            : Column(
              children:
                  widget.options
                      .map(
                        (option) => ListTile(
                          title: Text(option),
                          leading: Radio(
                            value: option,
                            groupValue: _selectedValue,
                            onChanged: selectValue,
                          ),
                        ),
                      )
                      .toList(),
            ),
      ],
    );
  }
}
