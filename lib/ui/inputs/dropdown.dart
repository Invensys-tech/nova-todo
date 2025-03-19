// import 'package:flutter/material.dart';

// class CustomDropdown extends StatefulWidget {
//   final String hintText;
//   final IconData icon;
//   final List<String> items;
//   final TextEditingController controller;

//   const CustomDropdown({
//     super.key,
//     required this.hintText,
//     required this.icon,
//     required this.items,
//     required this.controller,
//   });

//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   String? selectedValue; // Stores selected value

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: selectedValue,
//       onChanged: (newValue) {
//         setState(() {
//           selectedValue = newValue;
//           widget.controller.text = newValue!;
//         });
//       },
//       items:
//           widget.items.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value, style: const TextStyle(color: Colors.white)),
//             );
//           }).toList(),
//       decoration: InputDecoration(
//         prefixIcon: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             border: Border(
//               right: BorderSide(color: Colors.white54, width: 1.0),
//             ),
//           ),
//           child: Icon(widget.icon, color: Colors.white70),
//         ),
//         prefixIconConstraints: const BoxConstraints(
//           minWidth: 50,
//         ), // Ensure spacing
//         hintText: widget.hintText,
//         filled: true,
//         fillColor: Colors.black87.withOpacity(.3),
//         hintStyle: const TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.w200,
//           color: Colors.white60,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//           borderSide: const BorderSide(width: 2, color: Colors.green),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.green.withOpacity(.3),
//             width: 1.0,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.black38.withOpacity(.3),
//             width: 1.0,
//           ),
//         ),
//       ),
//       dropdownColor: Colors.black87,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final List<String> items;
  final TextEditingController controller;

  const CustomDropdown({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.items,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          widget.hintText,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w200,
            color: Colors.blue,
            // backgroundColor: Colors.amberAccent,
          ),
        ),
        items:
            widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.white60,
                    // backgroundColor: Colors.black12,
                  ),
                ),
              );
            }).toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String?;
            widget.controller.text = selectedValue ?? '';
          });
        },
        customButton: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.white54, width: 1.0),
                  ),
                ),
                child: Icon(widget.icon, color: Colors.white70),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    selectedValue ?? widget.hintText,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w200,
                      color: Colors.white60,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Color(0xff626262), // Set dropdown background to gray
            borderRadius: BorderRadius.circular(5),
          ),
          maxHeight: 200,
        ),
      ),
    );
  }
}
