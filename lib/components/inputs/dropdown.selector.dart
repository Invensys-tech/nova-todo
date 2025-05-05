import "package:flutter/material.dart";

class MyDropDownMenu extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;
  final void Function(dynamic) onSelect;
  final dynamic selectedValue;
  final String label;

  const MyDropDownMenu({
    super.key,
    required this.label,
    required this.menuItems,
    required this.onSelect,
    required this.selectedValue,
  });

  @override
  State<MyDropDownMenu> createState() => _MyDropDownMenuState();
}

class _MyDropDownMenuState extends State<MyDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        DropdownButton(
          items:
              widget.menuItems
                  .map(
                    (menuItem) => DropdownMenuItem(
                      value: menuItem['value'],
                      child: Text(menuItem['label']),
                    ),
                  )
                  .toList(),
          onChanged: widget.onSelect,
          value: widget.selectedValue,
        ),
      ],
    );
  }
}
