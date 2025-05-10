// import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';

// class ExpenseTypeSelector extends StatefulWidget {
//   final TextEditingController controller;

//   const ExpenseTypeSelector({super.key, required this.controller});

//   @override
//   State<ExpenseTypeSelector> createState() => _ExpenseTypeSelectorState();
// }

// class _ExpenseTypeSelectorState extends State<ExpenseTypeSelector> {
//   final List<String> _options = ["Must", "Maybe", "Unwanted"];
//   String? _selectedOption;

//   @override
//   void initState() {
//     super.initState();
//     _selectedOption =
//         widget.controller.text.isNotEmpty ? widget.controller.text : "Must";
//   }

//   Color _getColor(String option) {
//     switch (option) {
//       case "Must":
//         return Colors.green;
//       case "Maybe":
//         return Colors.orange;
//       case "Unwanted":
//         return Colors.red;
//       default:
//         return Colors.white30;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//          Text(
//          translate( "Types of Expenses"),
//           style: TextStyle(
//             fontSize: 13,fontWeight: FontWeight.w300
//           ),
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children:
//               _options.map((option) {
//                 final isSelected = _selectedOption == option;
//                 final color = isSelected ? _getColor(option) : Colors.grey.withOpacity(.5);

//                 return Expanded(
//                   child: Container(
//                     height: MediaQuery.of(context).size.height*.045,
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 0,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: color),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           _selectedOption = option;
//                           widget.controller.text = option;
//                         });
//                       },
//                       child: Row(
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width*.085,
//                             child: Radio<String>(
//                               value: option,
//                               groupValue: _selectedOption,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedOption = value!;
//                                   widget.controller.text = value;
//                                 });
//                               },
//                               fillColor: MaterialStateProperty.all(color),
//                             ),
//                           ),
//                           Text(option, style: TextStyle(color: color)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ExpenseTypeSelector extends StatefulWidget {
  final TextEditingController controller;

  const ExpenseTypeSelector({super.key, required this.controller});

  @override
  State<ExpenseTypeSelector> createState() => _ExpenseTypeSelectorState();
}

class _ExpenseTypeSelectorState extends State<ExpenseTypeSelector> {
  final List<_Option> _options = [
    _Option(label: translate("Must"), value: "Must"),
    _Option(label: translate("Maybe"), value: "Maybe"),
    _Option(label: translate("Unwanted"), value: "Unwanted"),
  ];

  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue =
        widget.controller.text.isNotEmpty
            ? widget.controller.text
            : _options.first.value;
  }

  Color _getColor(String value) {
    switch (value) {
      case "must":
        return Colors.green;
      case "maybe":
        return Colors.orange;
      case "unwanted":
        return Colors.red;
      default:
        return Colors.white30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate("Types of Expenses"),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              _options.map((opt) {
                final isSelected = _selectedValue == opt.value;
                final color =
                    isSelected
                        ? _getColor(opt.value)
                        : Colors.grey.withOpacity(.5);

                return Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedValue = opt.value;
                          widget.controller.text = opt.value;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .085,
                            child: Radio<String>(
                              value: opt.value,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  widget.controller.text = value!;
                                });
                              },
                              fillColor: MaterialStateProperty.all(color),
                            ),
                          ),
                          Text(
                            translate(opt.label),
                            style: TextStyle(color: color),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class _Option {
  final String label;
  final String value;
  const _Option({required this.label, required this.value});
}
