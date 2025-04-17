import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/common/form.finance-impact.dart';
import 'package:flutter_application_1/pages/goal/common/form.goal.dart';
import 'package:flutter_application_1/pages/goal/common/form.motivation.dart';
import 'package:flutter_application_1/pages/goal/common/form.subgoals.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';

class GoalStepperForm extends StatefulWidget {
  final Map<String, dynamic> controllers;
  const GoalStepperForm({super.key, required this.controllers});

  @override
  State<GoalStepperForm> createState() => _GoalStepperFormState();
}

class _GoalStepperFormState extends State<GoalStepperForm> {
  final Map<String, dynamic> _controllers = {
    "goals": {
      "name": FormInput(
        label: "Goal Name",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Goal Name",
      ),
      "term": FormInput(
        label: "Terms of Goal",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Terms of Goal",
      ),
      "priority": FormInput(
        label: "Goal Priority",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Goal Priority",
      ),
      "status": FormInput(
        label: "Goal Status",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Goal Status",
      ),
      "description": FormInput(
        label: "Goal Description",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Goal Description",
      ),
    },
    "motivations": [
      FormInput(
        label: "Why is this goal important to you",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter why this goal is important to you",
      ),
      FormInput(
        label: "What will happen after you achieve this goal",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter what will happen after you achieve this goal",
      ),
      FormInput(
        label: "How would you feel if you don’t achieve this goal",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter how would you feel if you don’t achieve this goal",
      ),
    ],
    "subGoalsWithDeadline": {
      "deadline": FormInput(
        label: "Deadline Of this current Vision Board",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Deadline Of this current Vision Board",
      ),
      "subGoals": [
        FormInputPair(
          key: FormInput(
            label: "Sub goal name",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Sub goal name",
          ),
          value: FormInput(
            label: "Subgoal Deadline",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Subgoal Deadline",
          ),
        ),
      ],
    },
    "financeImpact": {
      "totalMoney": FormInput(
        label: "How much do you think this Goal will cost?",
        controller: TextEditingController(),
        type: "0",
        hint: "Enter how much you think this Goal Will Cost",
      ),
      "amountSaved": FormInput(
        label: "How much do you think you are going to save?",
        controller: TextEditingController(),
        type: "0",
        hint: "Amount Of Money",
        span: 1.5,
      ),
      "timeSaved": FormInput(
        label: "Time Saved",
        controller: TextEditingController(),
        type: "0",
        hint: "Enter Time Saved",
        span: 1.5,
      ),
      "incomeSource": FormInput(
        label: "Income Source",
        controller: TextEditingController(),
        type: "0",
        hint: "Enter Time Saved",
        span: 1.5,
      ),
      // "incomeSource": [
      //   FormInputPair(
      //     key: FormInput(
      //       label: "Source",
      //       controller: TextEditingController(),
      //       type: "1",
      //       hint: "Enter Source",
      //     ),
      //     value: FormInput(
      //       label: "Amount",
      //       controller: TextEditingController(),
      //       type: "0",
      //       hint: "Enter Amount",
      //     ),
      //   ),
      // ],
    },
  };

  addMotivation() {
    setState(() {
      _controllers["motivations"].add(
        FormInput(
          label: "Additional Motivation",
          controller: TextEditingController(),
          type: "1",
          hint: "Enter Additional Motivation",
        ),
      );
    });
  }

  addSubGoals() {
    setState(() {
      _controllers["subGoalsWithDeadline"]["subGoals"].add(
        FormInputPair(
          key: FormInput(
            label: "Sub goal name",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Sub goal name",
          ),
          value: FormInput(
            label: "Subgoal Deadline",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Subgoal Deadline",
          ),
        ),
      );
    });
  }

  addIncomeSource() {
    setState(() {
      _controllers["financeImpact"]["incomeSource"].add(
        FormInputPair(
          key: FormInput(
            label: "Source",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Source",
          ),
          value: FormInput(
            label: "Amount",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Amount",
          ),
        ),
      );
    });
  }

  int _currentStep = 0;

  List<Step> steps() => [
    Step(
      title: Text(''),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: MediaQuery.of(context).size.height * 0.02,
        children: [
          Text('Goal Info', style: TextStyle(fontSize: 16)),
          GoalForm(
            goalName: widget.controllers["goals"]["name"] as FormInput,
            goalTerms: widget.controllers["goals"]["term"] as FormInput,
            goalPriority: widget.controllers["goals"]["priority"] as FormInput,
            goalStatus: widget.controllers["goals"]["status"] as FormInput,
            goalDescription:
                widget.controllers["goals"]["description"] as FormInput,
          ),
        ],
      ),
      isActive: _currentStep >= 0,
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
    ),
    Step(
      title: Text(''),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: MediaQuery.of(context).size.height * 0.02,
        children: [
          Text('Motivation and Purpose', style: TextStyle(fontSize: 16)),
          MotivationForm(
            motivations: widget.controllers["motivations"] as List<FormInput>,
            addMotivations: addMotivation,
          ),
        ],
      ),
      isActive: _currentStep >= 1,
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
    ),
    Step(
      title: Text(''),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: MediaQuery.of(context).size.height * 0.02,
        children: [
          Text('Finance and Impact', style: TextStyle(fontSize: 16)),
          FinanceImpactForm(
            totalMoney:
                widget.controllers["financeImpact"]["totalMoney"] as FormInput,
            amountSaved:
                widget.controllers["financeImpact"]["amountSaved"] as FormInput,
            timeSaved:
                widget.controllers["financeImpact"]["timeSaved"] as FormInput,
            incomeSource:
                widget.controllers["financeImpact"]["incomeSource"]
                    as FormInput,
            // incomeSources:
            //     widget.controllers["financeImpact"]["incomeSource"]
            //         as List<FormInputPair>,
            addIncomeSource: addIncomeSource,
          ),
        ],
      ),
      isActive: _currentStep >= 2,
      state: _currentStep <= 2 ? StepState.editing : StepState.complete,
    ),
    Step(
      title: Text(''),
      content: SubGoalsForm(
        deadline:
            widget.controllers["subGoalsWithDeadline"]["deadline"] as FormInput,
        subGoals:
            widget.controllers["subGoalsWithDeadline"]["subGoals"]
                as List<FormInputPair>,
        addSubGoal: addSubGoals,
      ),
      isActive: _currentStep >= 3,
      state: _currentStep <= 3 ? StepState.editing : StepState.complete,
    ),
  ];

  continueStep() {
    setState(() {
      if (_currentStep < 3) {
        _currentStep += 1;
      }
    });
  }

  cancelStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        steps: steps(),
        currentStep: _currentStep,
        type: StepperType.horizontal,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,

        // controlsBuilder: (context, details) {
        //   return Container(
        //     margin: EdgeInsets.only(top: 20),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       spacing: MediaQuery.of(context).size.height * 0.02,
        //       children: [
        //         Expanded(
        //           flex: 2,
        //           child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               backgroundColor: Color(0xFF27272A),
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(8),
        //                 side: BorderSide(color: Color(0xFF27272A), width: 2),
        //               ),
        //             ),
        //             onPressed: details.onStepCancel,
        //             child: Text(
        //               _currentStep == 0 ? "Cancel" : "Previous",
        //               style: TextStyle(color: Colors.white),
        //             ),
        //           ),
        //         ),
        //         Expanded(flex: 1, child: SizedBox()),
        //         Expanded(
        //           flex: 2,
        //           child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               backgroundColor: Color(0xFF27272A),
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(8),
        //                 side: BorderSide(color: Color(0xFF009966), width: 2),
        //               ),
        //             ),
        //             onPressed: details.onStepContinue,
        //             child: Text(
        //               _currentStep == 2 ? "Save" : "Next",
        //               style: TextStyle(color: Color(0xFF009966)),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   );
        // },
      ),
    );
  }
}
