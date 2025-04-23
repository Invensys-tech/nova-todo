import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyOTPInput extends StatefulWidget {
  final int length;
  final String type;
  final void Function(String) onChange;
  const MyOTPInput({
    super.key,
    required this.length,
    required this.onChange,
    this.type = 'int',
  });

  @override
  State<MyOTPInput> createState() => _MyOTPInputState();
}

class _MyOTPInputState extends State<MyOTPInput> {
  late List<SizedBox> inputBoxes;
  late String inputValue;

  @override
  void initState() {
    super.initState();
    // value = "0" * widget.length;
    inputValue = List.filled(widget.length, "0").join();
    inputBoxes = List.generate(
        widget.length,
            (index) => SizedBox(
              height: 64,
              width: 64,
              child: TextField(
                onChanged: (value) {
                  if (value != null && value != '') {
                    List<String> chars = inputValue.split('');
                    chars[index] = value;
                    inputValue = chars.join();
                    widget.onChange(inputValue);
                  }

                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                // style:
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: inputBoxes,
      ),
    );
  }
}
