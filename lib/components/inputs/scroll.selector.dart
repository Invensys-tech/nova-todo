import 'package:flutter/material.dart';
import 'package:basic_selector/basic_selector.dart';

class MyScrollSelector extends StatefulWidget {
  final List<String> items;
  final String? label;
  final String selectedItem;
  final void Function(String value) onChange;

  const MyScrollSelector({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChange,
    this.label,
  });

  @override
  State<MyScrollSelector> createState() => MyScrollSelectorState();
}

class MyScrollSelectorState extends State<MyScrollSelector> {
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
        BasicSelector<String>(
          items: widget.items,
          value: widget.selectedItem,
          // textFormatter: (item) {
          //     return item;
          // },
          onChanged: (item) {
            setState(() {
              widget.onChange(item);
            });
          },
        ),
      ],
    );
  }
}
