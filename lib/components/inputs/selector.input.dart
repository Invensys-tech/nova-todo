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
  String getSelectedLabel() {
    final match = widget.myDropdownItems.firstWhere(
          (item) => item['value'] == widget.currentValue,
      orElse: () => {'label': 'Select...'},
    );
    return match['label'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            child: Row(
              children: [
                widget.icon != null ? Icon(widget.icon, size: 32) : Container(),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height*.05,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(.3))
                    ),
                    child: DropdownMenu(
                      hintText: getSelectedLabel() == "10" ? "Before 10 min" : "nonebro",
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none, //
                        enabledBorder: InputBorder.none, //
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      width: MediaQuery.of(context).size.width * .91,
                      menuStyle: MenuStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero)
                      ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
