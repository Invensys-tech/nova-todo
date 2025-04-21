// import 'package:flutter/material.dart';

// class TextFields extends StatelessWidget {
//   final String hinttext;
//   final String whatIsInput;
//   final TextEditingController controller;
//   final IconData? icon;
//   final String? Function(String?)? func;

//   const TextFields({
//     super.key,
//     required this.hinttext,
//     required this.whatIsInput,
//     required this.controller,
//     this.icon,
//     this.func,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       style: const TextStyle(color: Colors.white),
//       controller: controller,
//       keyboardType:
//           whatIsInput == "0" ? TextInputType.number : TextInputType.text,
//       decoration: InputDecoration(
//         prefixIcon:
//             icon != null
//                 ? Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       right: BorderSide(
//                         color: Colors.white54,
//                         width: 1.0,
//                       ), // Border between icon & input
//                     ),
//                   ),
//                   child: Icon(
//                     icon, // Display the icon
//                     color: Colors.white70, // Icon color
//                   ),
//                 )
//                 : null,
//         prefixIconConstraints: const BoxConstraints(
//           minWidth: 50,
//         ), // Ensure spacing
//         hintText: hinttext,
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
//       validator: func,
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../main.dart';

class TextFields extends StatelessWidget {
  final String hinttext;
  final String whatIsInput;
  final TextEditingController controller;
  final String? prefixText;
  final bool filled;
  final String? Function(String?)? func;

  const TextFields({
    super.key,
    required this.hinttext,
    required this.whatIsInput,
    required this.controller,
    this.prefixText,
    this.filled = false,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (prefixText != null)
          Container(
            height: MediaQuery.of(context).size.height*.046,
            width: MediaQuery.of(context).size.width*.1,
            decoration: BoxDecoration(

              color: isDark ?  Colors.grey.withOpacity(.4) : Color(0xffD4D4D8),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                prefixText!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

        // 📝 The actual input field
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height*.045,
            child: TextFormField(

              controller: controller,
              keyboardType:
                  whatIsInput == "0" ? TextInputType.number : TextInputType.text,
              // decoration: InputDecoration(
              //   hintText: hinttext,
              //   filled: true,
              //   fillColor: Colors.black87.withOpacity(.3),
              //   hintStyle: const TextStyle(
              //     fontSize: 11,
              //     fontWeight: FontWeight.w200,
              //     color: Colors.white60,
              //   ),
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.only(
              //       topRight: const Radius.circular(5),
              //       bottomRight: const Radius.circular(5),
              //       topLeft: Radius.circular(prefixText != null ? 0 : 5),
              //       bottomLeft: Radius.circular(prefixText != null ? 0 : 5),
              //     ),
              //     borderSide: const BorderSide(
              //       width: 2,
              //       color: Colors.transparent,
              //     ),
              //   ),
              //   focusedBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.only(
              //       topRight: const Radius.circular(5),
              //       bottomRight: const Radius.circular(5),
              //       topLeft: Radius.circular(prefixText != null ? 0 : 5),
              //       bottomLeft: Radius.circular(prefixText != null ? 0 : 5),
              //     ),
              //     borderSide: BorderSide(
              //       color: Colors.green.withOpacity(.3),
              //       width: 1.0,
              //     ),
              //   ),
              //   enabledBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.only(
              //       topRight: const Radius.circular(5),
              //       bottomRight: const Radius.circular(5),
              //       topLeft: Radius.circular(prefixText != null ? 0 : 5),
              //       bottomLeft: Radius.circular(prefixText != null ? 0 : 5),
              //     ),
              //     borderSide: BorderSide(
              //       color: Colors.black38.withOpacity(.3),
              //       width: 1.0,
              //     ),
              //   ),
              // ),
              decoration: InputDecoration(
                filled: filled,
                border: OutlineInputBorder(
                  borderRadius: prefixText!=null ?BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)) : BorderRadius.all(Radius.circular(5)),
                  borderSide:  BorderSide(color: Colors.grey.withOpacity(.4), width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:   prefixText!=null ?BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)) : BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(.4), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:  prefixText!=null ?BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)) : BorderRadius.all(Radius.circular(5)),
                  borderSide:  BorderSide(color: Colors.grey.withOpacity(.4), width: 1),
                ),
              ),
              validator: func,
            ),
          ),
        ),
      ],
    );
  }
}
