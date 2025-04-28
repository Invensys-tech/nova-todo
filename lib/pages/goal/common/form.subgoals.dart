import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/inputs/radio.input.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/helpers.dart';

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
  int _subGoalCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 1, color: Color(0xFF27272A)),
      //   borderRadius: BorderRadius.circular(10),
      //   color: const Color(0x00000000),
      // ),
      child: Column(
        spacing: MediaQuery.of(context).size.width * 0.04,
        children: [
          // Container(child: Text('Sub Goals')),
          // DateSelector(
          //   controller: widget.deadline.controller,
          //   hintText: widget.deadline.hint,
          //   icon: Icons.calendar_today,
          //   firstDate: DateTime(2000),
          //   lastDate: DateTime(2100),
          //   initialDate: DateTime.now(),
          // ),
          ...widget.subGoals.map((subGoal) {
            _subGoalCounter++;

            return Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.04,
                
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.withOpacity(.45)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                spacing: MediaQuery.of(context).size.width * 0.04,
                children: [
                  MyTextInput(
                    label: 'Sub Goal Name',
                    textFields: TextFields(
                      controller: subGoal.key.controller,
                      hinttext: subGoal.key.hint,
                      filled: true,
                      whatIsInput: subGoal.key.type,
                    ),
                  ),
                  MyRadioInput(
                    value: mapDeadlineToOption(subGoal.value.controller.text),
                    color: Color(0xFF09090B).withAlpha(30),
                    borderColor: Color(0xFF27272A),
                    label: 'Deadline Date',
                    groupKey: 'subgoal-name-$_subGoalCounter',
                    options: ['1 Week', '1 Month'],
                    onChanged: (value) {
                      final now = DateTime.now();
                      DateTime deadline;

                      if (value == '1 Week') {
                        deadline = now.add(const Duration(days: 7));
                      } else if (value == '1 Month') {
                        // add one month while preserving day
                        deadline = DateTime(now.year, now.month + 1, now.day);
                      } else {
                        // fallback: treat "N Week(s)" or "N Month(s)"
                        final parts = value.split(' ');
                        final amount = int.tryParse(parts[0]) ?? 0;
                        if (parts[1].toLowerCase().startsWith('week')) {
                          deadline = now.add(Duration(days: amount * 7));
                        } else {
                          deadline = DateTime(
                            now.year,
                            now.month + amount,
                            now.day,
                          );
                        }
                      }

                      // write the formatted date into your sub-goal's deadline field
                      subGoal.value.controller.text = formatDate(
                        deadline.toString(),
                      );
                    },
                  ),

                  // MyRadioInput(
                  //   color: Color(0xFF09090B).withAlpha(30),
                  //   borderColor: Color(0xFF27272A),
                  //   label: 'Deadline Date',
                  //   groupKey: 'subgoal-name-$_subGoalCounter',
                  //   options: ['1 Week', '1 Month'],
                  //   onChanged: (value) => subGoal.value.controller.text = value,
                  // ),
                  // Row(
                  //   spacing: MediaQuery.of(context).size.width * 0.04,
                  //   children: [
                  //     Expanded(
                  //       child: TextFields(
                  //         controller: subGoal.key.controller,
                  //         hinttext: subGoal.key.hint,
                  //         whatIsInput: subGoal.key.type,
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: DateSelector(
                  //         controller: subGoal.value.controller,
                  //         hintText: subGoal.value.hint,
                  //         icon: Icons.calendar_today,
                  //         firstDate: DateTime(2000),
                  //         lastDate: DateTime(2100),
                  //         initialDate: DateTime.now(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.addSubGoal();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Color(0xFF009966), width: 2),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFF009966).withAlpha(33),
                ),
                child: Text(
                  'Add Sub Goal',
                  style: TextStyle(color: Color(0xFF009966)),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     widget.addSubGoal();
          //   },
          //   child: const Text('Add Sub Goal'),
          // ),
        ],
      ),
    );
  }
}

String? mapDeadlineToOption(String savedDeadlineText) {
  if (savedDeadlineText.isEmpty) return null;

  try {
    final savedDeadline = DateTime.parse(savedDeadlineText);
    final now = DateTime.now();

    final difference = savedDeadline.difference(now).inDays;

    if ((difference - 7).abs() <= 1) {
      return '1 Week';
    } else if ((difference - 30).abs() <= 3) {
      return '1 Month';
    } else {
      return null; // no match
    }
  } catch (e) {
    return null; // invalid date format
  }
}
