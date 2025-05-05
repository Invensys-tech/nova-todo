import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MyPinPut extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const MyPinPut({super.key, required this.label, required this.controller});

  @override
  State<MyPinPut> createState() => _MyPinPutState();
}

class _MyPinPutState extends State<MyPinPut> {
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          Pinput(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            onChanged: (value) {
              debugPrint("value of pin $value");
            },
            onCompleted: (value) {
              print("completed with $value");
            },
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}
