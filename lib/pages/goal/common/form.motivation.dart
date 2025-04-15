import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class MotivationForm extends StatefulWidget {
  final List<FormInput> motivations;
  final void Function() addMotivations;

  const MotivationForm({
    super.key,
    required this.motivations,
    required this.addMotivations,
  });

  @override
  State<MotivationForm> createState() => MotivationFormState();
}

class MotivationFormState extends State<MotivationForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFF27272A)),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0x00000000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: MediaQuery.of(context).size.width * 0.04,
        children: [
          ...widget.motivations.map(
            (motivation) => MyTextInput(
              label: motivation.label,
              textFields: TextFields(
                controller: motivation.controller,
                hinttext: motivation.hint,
                whatIsInput: motivation.type,
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     widget.addMotivations();
          //   },
          //   child: const Text('Add Motivation'),
          // ),
        ],
      ),
    );
  }
}
