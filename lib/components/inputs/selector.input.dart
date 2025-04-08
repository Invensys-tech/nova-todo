import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MySelector extends StatefulWidget {
  final String label;
  final List<Map<String, dynamic>> myDropdownItems;
  final void Function(dynamic) onSelect;
  final String currentValue;
  final TextEditingController? controller;
  final IconData? icon;
  const MySelector({
    super.key,
    required this.myDropdownItems,
    required this.onSelect,
    required this.label,
    required this.currentValue,
    this.controller,
    this.icon,
  });

  @override
  State<MySelector> createState() => _MySelectorState();
}

class _MySelectorState extends State<MySelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        spacing: MediaQuery.of(context).size.width * 0.01,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            child: Row(
              spacing: MediaQuery.of(context).size.width * 0.02,
              children: [
                widget.icon != null ? Icon(widget.icon, size: 32) : Container(),
                DropdownMenu(
                  width: MediaQuery.of(context).size.width * 0.85,
                  menuStyle: MenuStyle(),
                  // initialSelection: widget.myDropdownItems[0]['value'],
                  // enableSearch: true,
                  // enableFilter: true,
                  controller: widget.controller,
                  onSelected: widget.onSelect,
                  dropdownMenuEntries:
                      widget.myDropdownItems
                          .map(
                            (e) => DropdownMenuEntry(
                              label: e['label'],
                              value: e['value'],
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
