// import 'package:flutter/material.dart';

// class MultiTextFields extends StatelessWidget {
//   final List<TextFieldData> fields;

//   const MultiTextFields({super.key, required this.fields});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children:
//           fields.map((field) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: TextFormField(
//                 style: const TextStyle(color: Colors.white),
//                 controller: field.controller,
//                 keyboardType:
//                     field.isNumber ? TextInputType.number : TextInputType.text,
//                 decoration: InputDecoration(
//                   prefixIcon: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: const BoxDecoration(
//                       border: Border(
//                         right: BorderSide(color: Colors.white54, width: 1.0),
//                       ),
//                     ),
//                     child: Icon(field.icon, color: Colors.white70),
//                   ),
//                   prefixIconConstraints: const BoxConstraints(minWidth: 50),
//                   hintText: field.hintText,
//                   filled: true,
//                   fillColor: Colors.black87.withOpacity(.3),
//                   hintStyle: const TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w200,
//                     color: Colors.white60,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: const BorderSide(width: 2, color: Colors.green),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.green.withOpacity(.3),
//                       width: 1.0,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.black38.withOpacity(.3),
//                       width: 1.0,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//     );
//   }
// }

// class TextFieldData {
//   final String hintText;
//   final IconData icon;
//   final TextEditingController controller;
//   final bool isNumber;

//   TextFieldData({
//     required this.hintText,
//     required this.icon,
//     required this.controller,
//     this.isNumber = false,
//   });
// }

import 'package:flutter/material.dart';

class MultiLineTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;

  const MultiLineTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.08,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 3, // Allows multiple lines
        decoration: InputDecoration(
          // prefixIcon: Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   decoration: const BoxDecoration(
          //     border: Border(
          //       right: BorderSide(color: Colors.white54, width: 1.0),
          //     ),
          //   ),
          //   child: Icon(icon, color: Colors.white70),
          // ),
          prefixIconConstraints: const BoxConstraints(minWidth: 50),
          hintText: hintText,
          filled: true,
          fillColor: Colors.transparent,
          hintStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w200,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 2, color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green.withOpacity(.3),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.4),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
