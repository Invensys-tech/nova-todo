import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
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
      spacing: MediaQuery.of(context).size.width * 0.04,
      children: [
        Container(child: Text('Sub Goals')),
        DateSelector(
          controller: widget.deadline.controller,
          hintText: widget.deadline.hint,
          icon: Icons.calendar_today,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        ),
        ...widget.subGoals.map(
          (subGoal) => Row(
            spacing: MediaQuery.of(context).size.width * 0.04,
            children: [
              Expanded(
                child: TextFields(
                  controller: subGoal.key.controller,
                  hinttext: subGoal.key.hint,
                  whatIsInput: subGoal.key.type,
                ),
              ),
              Expanded(
                child: DateSelector(
                  controller: subGoal.value.controller,
                  hintText: subGoal.value.hint,
                  icon: Icons.calendar_today,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                ),
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
