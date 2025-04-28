import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/inputs/radio.input.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:intl/intl.dart';

class GoalForm extends StatefulWidget {
  final FormInput goalName;
  final FormInput goalTerms;
  final FormInput goalPriority;
  final FormInput goalStatus;
  final FormInput goalDescription;
  final FormInput deadline;

  const GoalForm({
    super.key,
    required this.goalName,
    required this.goalTerms,
    required this.goalStatus,
    required this.goalPriority,
    required this.goalDescription,
    required this.deadline,
  });

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*1,
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0x00000000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextInput(
            label: 'Goal Name',
            textFields: TextFields(
              hinttext: widget.goalName.hint,
              whatIsInput: widget.goalName.type,
              controller: widget.goalName.controller,
            ),
          ),

          MyRadioInput(
            value: widget.goalTerms.controller.text,
            label: 'Term',
            groupKey: 'term',
            options: ['short', 'long'],
            onChanged: (value) => widget.goalTerms.controller.text = value,
          ),
          MyRadioInput(
            value: widget.goalPriority.controller.text,
            label: 'Priority',
            groupKey: 'priority',
            options: ['High', 'Medium', 'Low'],
            onChanged: (value) => widget.goalPriority.controller.text = value,
          ),
          MyRadioInput(
            value: widget.goalStatus.controller.text,
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
                controller: widget.deadline.controller,

                // controller: TextEditingController(),
                hintText: 'Date',
                icon: Icons.calendar_today,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDate:
                    widget.deadline.controller.text.isNotEmpty
                        ? DateFormat(
                          'yyyy-MM-dd',
                        ).parse(widget.deadline.controller.text)
                        : DateTime.now(),
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
