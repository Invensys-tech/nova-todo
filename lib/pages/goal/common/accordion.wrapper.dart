import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class AccordionWrapper extends StatefulWidget {
  final String title;
  final Widget content;
  final TextEditingController goalName;
  final TextEditingController goalTerm;
  final TextEditingController goalPriority;
  final TextEditingController goalStatus;
  final TextEditingController goalDescription;

  const AccordionWrapper({
    super.key,
    required this.title,
    required this.content,
    required this.goalName,
    required this.goalTerm,
    required this.goalPriority,
    required this.goalStatus,
    required this.goalDescription,
  });

  @override
  State<AccordionWrapper> createState() => _AccordionWrapperState();
}

class _AccordionWrapperState extends State<AccordionWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                child: TextFields(
                  hinttext: 'Goal Name',
                  whatIsInput: '1',
                  controller: widget.goalName,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                child: TextFields(
                  hinttext: 'Terms of Goal',
                  whatIsInput: '1',
                  controller: widget.goalTerm,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                child: TextFields(
                  hinttext: 'Goal Priority',
                  whatIsInput: '1',
                  controller: widget.goalPriority,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                child: TextFields(
                  hinttext: 'Goal Status',
                  whatIsInput: '1',
                  controller: widget.goalStatus,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          MultiLineTextField(
            hintText: 'description',
            controller: widget.goalDescription,
            icon: Icons.description,
          ),

          ElevatedButton(onPressed: () {}, child: const Text('Submit')),
        ],
      ),
    );
  }
}
