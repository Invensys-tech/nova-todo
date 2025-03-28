import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Column(
      spacing: 3.2,
      children: [
        // ...widget.motivations.asMap().entries.map(
        // (entry) => TextFields(
        //   controller: entry.value.controller,
        //   hinttext: entry.value.hint,
        //   whatIsInput: entry.value.type,
        // ),
        // ),
        ...widget.motivations.map(
          (motivation) => TextFields(
            controller: motivation.controller,
            hinttext: motivation.hint,
            whatIsInput: motivation.type,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.addMotivations();
          },
          child: const Text('Add Motivation'),
        ),
      ],
    );
  }
}
