import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/inputs/radio.input.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
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
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFF27272A)),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0x00000000),
      ),
      // color: const Color(0x00000000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: MediaQuery.of(context).size.height * 0.019,
        children: [
          MyTextInput(
            label: 'Goal Name',
            textFields: TextFields(
              hinttext: widget.goalName.hint,
              whatIsInput: widget.goalName.type,
              controller: widget.goalName.controller,
            ),
          ),
          MyTextInput(
            label: 'Term',
            textFields: TextFields(
              hinttext: widget.goalTerms.hint,
              whatIsInput: widget.goalTerms.type,
              controller: widget.goalTerms.controller,
            ),
          ),
          MyRadioInput(
            label: 'Priority',
            groupKey: 'priority',
            options: ['High', 'Medium', 'Low'],
            onChanged: (value) => widget.goalPriority.controller.text = value,
          ),
          MyRadioInput(
            label: 'Status',
            groupKey: 'status',
            options: ['New', 'Ongoing', 'Completed'],
            onChanged: (value) => widget.goalStatus.controller.text = value,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: MediaQuery.of(context).size.height * 0.008,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Date',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
              DateSelector(
                // controller: widget.deadline.controller,
                controller: TextEditingController(),
                hintText: 'Date',
                icon: Icons.calendar_today,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDate: DateTime.now(),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: MediaQuery.of(context).size.height * 0.008,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
              MultiLineTextField(
                hintText: widget.goalDescription.hint,
                controller: widget.goalDescription.controller,
                icon: Icons.description,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
