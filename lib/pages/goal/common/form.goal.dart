import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class GoalForm extends StatefulWidget {
  final FormInput goalName;
  final FormInput goalTerms;
  final FormInput goalPriority;
  final FormInput goalStatus;
  final FormInput goalDescription;

  const GoalForm({
    super.key,
    required this.goalName,
    required this.goalTerms,
    required this.goalStatus,
    required this.goalPriority,
    required this.goalDescription,
  });

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
      color: const Color(0x00000000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: MediaQuery.of(context).size.width * 0.04,
            children: [
              Expanded(
                child: TextFields(
                  hinttext: widget.goalName.hint,
                  whatIsInput: widget.goalName.type,
                  controller: widget.goalName.controller,
                ),
              ),
              Expanded(
                child: TextFields(
                  hinttext: widget.goalTerms.hint,
                  whatIsInput: widget.goalTerms.type,
                  controller: widget.goalTerms.controller,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.019),
          Row(
            spacing: MediaQuery.of(context).size.width * 0.04,
            children: [
              Expanded(
                child: TextFields(
                  hinttext: widget.goalPriority.hint,
                  whatIsInput: widget.goalPriority.type,
                  controller: widget.goalPriority.controller,
                ),
              ),
              Expanded(
                child: TextFields(
                  hinttext: widget.goalStatus.hint,
                  whatIsInput: widget.goalStatus.type,
                  controller: widget.goalStatus.controller,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.019),
          MultiLineTextField(
            hintText: widget.goalDescription.hint,
            controller: widget.goalDescription.controller,
            icon: Icons.description,
          ),
        ],
      ),
    );
  }
}
