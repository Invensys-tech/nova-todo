import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyRadioInput extends StatefulWidget {
  final String? label;
  final String? orientation;
  final String groupKey;
  final List<String> options;
  final void Function(dynamic value) onChanged;
  final Color? color;
  final Color? borderColor;
  final String? value;

  const MyRadioInput({
    super.key,
    this.label,
    this.orientation = 'horizontal',
    required this.groupKey,
    required this.options,
    required this.onChanged,
    this.color,
    this.borderColor,
    this.value,
  });

  @override
  State<MyRadioInput> createState() => MyRadioInputState();
}

class MyRadioInputState extends State<MyRadioInput> {
  String _selectedValue = '';

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      setState(() {
        _selectedValue = widget.value?? '' ;
        widget.onChanged(widget.value);
      });
    }
  }

  void selectValue(value) {
    setState(() {
      _selectedValue = value;
    });

    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label != null
              ? Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.label!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              )
              : Container(),
          widget.orientation == 'horizontal'
              ? Row(
                spacing: MediaQuery.of(context).size.width * 0.03,
                children:
                    widget.options
                        .map(
                          (option) => Expanded(
                            // child: ListTile(
                            //   // color: ,
                            //   leading: Radio(
                            //     activeColor: Color(0xFF009966),
                            //     overlayColor:
                            //         option == _selectedValue
                            //             ? MaterialStateProperty.all(
                            //               Colors.transparent,
                            //             )
                            //             : MaterialStateProperty.all(
                            //               Color(0xFF9F9FA9),
                            //             ),
                            //     value: option,
                            //     groupValue: _selectedValue,
                            //     onChanged: selectValue,
                            //   ),
                            //   title: Text(option, style: TextStyle(fontSize: 14)),
                            // ),
                            child: GestureDetector(
                              onTap: () => selectValue(option),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: widget.color,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        option == _selectedValue
                                            ? Color(0xFF00D492)
                                            : widget.borderColor ??
                                                Colors.grey.withOpacity(.5),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24 / widget.options.length,
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    spacing:
                                        MediaQuery.of(context).size.width * 0.02,
                                    children: [
                                      option == _selectedValue
                                          ? Icon(
                                            Icons.circle,
                                            color: Color(0xFF00D492),
                                            size: 18,
                                          )
                                          : Icon(
                                            Icons.circle_outlined,
                                            color: Color(0xFFE4E4E7),
                                            size: 18,
                                          ),
                                      Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 32 / widget.options.length,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                          (option) =>
                          // ListTile(
                          //   leading: Radio(
                          //     value: option,
                          //     groupValue: _selectedValue,
                          //     onChanged: selectValue,
                          //   ),
                          //   title: Text(option, style: TextStyle(fontSize: 12)),
                          // ),
                          GestureDetector(
                            onTap: () => selectValue(option),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:
                                      option == _selectedValue
                                          ? Color(0xFF00D492)
                                          : Color(0xFFE4E4E7),
                                ),
                              ),
                              child: Row(
                                children: [
                                  option == _selectedValue
                                      ? Icon(
                                        Icons.circle,
                                        color: Color(0xFF00D492),
                                        size: 12,
                                      )
                                      : Icon(
                                        Icons.circle_outlined,
                                        color: Color(0xFF00D492),
                                        size: 12,
                                      ),
                                  Text(option),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
        ],
      ),
    );
  }
}
