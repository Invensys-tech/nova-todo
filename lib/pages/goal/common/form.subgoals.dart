import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class SubGoalsForm extends StatefulWidget {
  final FormInput deadline;
  final List<FormInputPair> subGoals;
  final void Function() addSubGoal;

  const SubGoalsForm({
    super.key,
    required this.deadline,
    required this.subGoals,
    required this.addSubGoal,
  });

  @override
  State<SubGoalsForm> createState() => _SubGoalsFormState();
}

class _SubGoalsFormState extends State<SubGoalsForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFields(
          controller: widget.deadline.controller,
          hinttext: widget.deadline.hint,
          whatIsInput: widget.deadline.type,
        ),
        ...widget.subGoals.map(
          (subGoal) => Row(
            spacing: 3.2,
            children: [
              TextFields(
                controller: subGoal.key.controller,
                hinttext: subGoal.key.hint,
                whatIsInput: subGoal.key.type,
              ),
              TextFields(
                controller: subGoal.key.controller,
                hinttext: subGoal.key.hint,
                whatIsInput: subGoal.key.type,
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.addSubGoal();
          },
          child: const Text('Add Sub Goal'),
        ),
      ],
    );
  }
}
