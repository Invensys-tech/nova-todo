// import 'package:flutter/material.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

// class CustomDropdown extends StatefulWidget {
//   final String hintText;
//   final IconData icon;
//   final List<String> items;
//   final TextEditingController controller;
//   final void Function(String?)? onChanged; // Optional callback

//   const CustomDropdown({
//     Key? key,
//     required this.hintText,
//     required this.icon,
//     required this.items,
//     required this.controller,
//     this.onChanged,
//   }) : super(key: key);

//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   String? selectedValue;

//   @override
//   void didUpdateWidget(covariant CustomDropdown oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // If the selected value is no longer in the new items, clear it.
//     if (!widget.items.contains(selectedValue)) {
//       setState(() {
//         selectedValue = null;
//         widget.controller.text = '';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         hint: Text(
//           widget.hintText,
//           style: const TextStyle(
//             fontSize: 11,
//             fontWeight: FontWeight.w200,
//             color: Colors.blue,
//           ),
//         ),
//         items:
//             widget.items.map((String item) {
//               return DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   style: const TextStyle(color: Colors.white60),
//                 ),
//               );
//             }).toList(),
//         value: selectedValue,
//         onChanged: (value) {
//           setState(() {
//             selectedValue = value;
//             widget.controller.text = selectedValue ?? '';
//           });
//           // Call parent callback if provided.
//           if (widget.onChanged != null) {
//             widget.onChanged!(value);
//           }
//         },
//         customButton: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: Colors.black87.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(color: Colors.green, width: 2),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 50,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     right: BorderSide(color: Colors.white54, width: 1.0),
//                   ),
//                 ),
//                 child: Icon(widget.icon, color: Colors.white70),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     selectedValue ?? widget.hintText,
//                     style: const TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w200,
//                       color: Colors.white60,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//               const Icon(Icons.arrow_drop_down, color: Colors.white),
//             ],
//           ),
//         ),
//         dropdownStyleData: DropdownStyleData(
//           decoration: BoxDecoration(
//             color: const Color(0xff626262),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           maxHeight: 200,
//         ),
//       ),
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
  final void Function(String?)? onChanged; // Optional callback
  final String? selectedValue;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.icon,
    required this.items,
    required this.controller,
    this.onChanged,
    this.selectedValue,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    // print('------------selected value-----------------');
    // print(widget.selectedValue);
    super.initState();
    if (widget.selectedValue != null) {
      selectedValue = widget.selectedValue;
      widget.controller.text = widget.selectedValue!;
    }
    if (widget.controller.text.isNotEmpty &&
        widget.items.contains(widget.controller.text)) {
      selectedValue = widget.controller.text;
    }
  }

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller.text.isNotEmpty &&
        widget.items.contains(widget.controller.text) &&
        widget.controller.text != selectedValue) {
      setState(() {
        selectedValue = widget.controller.text;
      });
    } else if (!widget.items.contains(selectedValue)) {
      setState(() {
        selectedValue = null;
        widget.controller.text = '';
      });
    }
  }

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
          ),
        ),
        items:
            widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(color: Colors.white60),
                ),
              );
            }).toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            widget.controller.text = value ?? '';
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
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
            color: const Color(0xff626262),
            borderRadius: BorderRadius.circular(5),
          ),
          maxHeight: 200,
        ),
      ),
    );
  }
}
