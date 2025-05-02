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
            height: MediaQuery.of(context).size.height * .046,
            width: MediaQuery.of(context).size.width * .1,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.withOpacity(.4) : Color(0xffD4D4D8),
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
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),

        // 📝 The actual input field
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .045,
            child: TextFormField(
              controller: controller,
              keyboardType:
                  whatIsInput == "0"
                      ? TextInputType.number
                      : TextInputType.text,

              decoration: InputDecoration(
                hintText: hinttext,
                hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                filled: filled,
                border: OutlineInputBorder(
                  borderRadius:
                      prefixText != null
                          ? BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )
                          : BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(.4),
                    width: 1,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 20,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      prefixText != null
                          ? BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )
                          : BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(.4),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      prefixText != null
                          ? BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )
                          : BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(.4),
                    width: 1,
                  ),
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
