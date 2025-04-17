import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/goal/common/form.finance-impact.dart';
import 'package:flutter_application_1/pages/goal/common/form.goal.dart';
import 'package:flutter_application_1/pages/goal/common/form.motivation.dart';
import 'package:flutter_application_1/pages/goal/common/form.subgoals.dart';
import 'package:flutter_application_1/pages/goal/common/goalInformationAccordion.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/pages/goal/form.goal.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubGoalData {
  final TextEditingController goalController;
  final TextEditingController deadlineController;

  SubGoalData({required this.goalController, required this.deadlineController});
}

class IncomeData {
  final TextEditingController sourceController;
  final TextEditingController amountController;
  IncomeData({required this.amountController, required this.sourceController});
}

class AddGoal extends StatefulWidget {
  const AddGoal({super.key});

  @override
  State<AddGoal> createState() => _AccordionAxampleState();
}

class _AccordionAxampleState extends State<AddGoal> {
  // Goal Information Controllers
  final TextEditingController _goalName = TextEditingController();
  final TextEditingController _goalTerm = TextEditingController();
  final TextEditingController _goalPriority = TextEditingController();
  final TextEditingController _goalStatus = TextEditingController();
  final TextEditingController _goalDescription = TextEditingController();

  // Motivation controllers (first three are for static inputs)
  final List<TextEditingController> motivationControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  // Sub Goals list (one exists by default)
  final List<SubGoalData> subGoals = [
    SubGoalData(
      goalController: TextEditingController(),
      deadlineController: TextEditingController(),
    ),
  ];

  // Finance controllers
  final TextEditingController _totalMoney = TextEditingController();
  final TextEditingController _amountSaved = TextEditingController();
  final TextEditingController _timeSaved = TextEditingController();

  // Income list (one exists by default)
  final List<IncomeData> income = [
    IncomeData(
      sourceController: TextEditingController(),
      amountController: TextEditingController(),
    ),
  ];

  final TextEditingController _dateController = TextEditingController();

  static const headerStyle = TextStyle(
    color: Color(0xffffffff),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // @override
  // void dispose() {
  //   _goalName.dispose();
  //   _goalTerm.dispose();
  //   _goalPriority.dispose();
  //   _goalStatus.dispose();
  //   _goalDescription.dispose();
  //   for (var controller in motivationControllers) {
  //     controller.dispose();
  //   }
  //   for (var subGoal in subGoals) {
  //     subGoal.goalController.dispose();
  //     subGoal.deadlineController.dispose();
  //   }
  //   _totalMoney.dispose();
  //   _amountSaved.dispose();
  //   _timeSaved.dispose();
  //   for (var inc in income) {
  //     inc.sourceController.dispose();
  //     inc.amountController.dispose();
  //   }
  //   _dateController.dispose();
  //   super.dispose();
  // }

  void _printAllValues() async {
    // print("-------- Goals ----------");
    // print("Goal Name: ${_controllers["goals"]["name"].controller.text}");
    // print("Goal Term: ${_controllers["goals"]["term"].controller.text}");
    // print(
    //   "Goal Priority: ${_controllers["goals"]["priority"].controller.text}",
    // );

    // print("----- Motivations -----");
    // for (int i = 0; i < _controllers["motivations"].length; i++) {
    //   print(
    //     "Motivation ${i + 1}: ${_controllers["motivations"][i].controller.text}",
    //   );
    // }

    // print("----------- Sub goals | DEADLINE -------------");
    // print(
    //   "Deadline: ${_controllers["subGoalsWithDeadline"]["deadline"].controller.text}",
    // );
    // for (
    //   var i = 0;
    //   i < _controllers["subGoalsWithDeadline"]["subGoals"].length;
    //   i++
    // ) {
    //   print(
    //     "Sub Goal ${i + 1}: ${_controllers["subGoalsWithDeadline"]["subGoals"][i].key.controller.text}, Deadline: ${_controllers["subGoalsWithDeadline"]["subGoals"][i].value.controller.text}",
    //   );
    // }

    // print("---------------------- FINANCE -----------------");
    // print(_controllers["financeImpact"]["totalMoney"].controller.text);
    // print(_controllers["financeImpact"]["amountSaved"].controller.text);
    // print(_controllers["financeImpact"]["timeSaved"].controller.text);

    try {
      final goalResponse = await Supabase.instance.client.from('goal').insert({
        'name': _controllers["goals"]["name"].controller.text,
        'status': _controllers["goals"]["priority"].controller.text,
        'priority': _controllers["goals"]["priority"].controller.text,
        'description': _controllers["goals"]["description"].controller.text,
        'term': _controllers["goals"]["term"].controller.text,
        'userId': 1,
        'deadline': formatDate(
          _controllers["subGoalsWithDeadline"]["deadline"].controller.text,
        ),
        'motivation': getMotivationJson(),
        // 'finance': {'totalMoney', 1000},
        'finance': getFinanceJson(),
      });

      final goals = await Datamanager().getGoals();
      final goalIdIndex =
          goals.length - 1; // Fixing index to get the last inserted goal
      final goalId = goals[goalIdIndex].id;

      // goals.forEach((goal) => print(goal.id));
      // print("----------- Goal Id ------------");
      // print(goalId);

      // // Now insert sub-goals
      await insertSubGoals(goalId);

      // print(goalResponse);
      print("Goal added successfully!");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Goal added successfully!")));
      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Map<String, dynamic> getMotivationJson() {
    return {
      "motivations":
          _controllers["motivations"]
              .map((motivation) => (motivation as FormInput).controller.text)
              .toList(),
    };
  }

  getSubGoalsJson() {
    // getSubGoalsJson() {
    dynamic subGoalsData =
        _controllers["subGoalsWithDeadline"]["subGoals"].map((subGoal) {
          Map<String, dynamic> subGoalData = {
            "goal": subGoal.key.controller.text,
            "deadline": formatDate(subGoal.value.controller.text),
          };

          return subGoalData;
        }).toList();

    return subGoalsData;
  }

  Future<void> insertSubGoals(int goalId) async {
    // List<Map<String, dynamic>> subGoalsData = getSubGoalsJson();
    List<dynamic> subGoalsData = getSubGoalsJson();
    // List<Map<String, dynamic>> subGoalsData =
    //     getSubGoalsJson() as List<Map<String, dynamic>>;

    if (subGoalsData.isNotEmpty) {
      await Supabase.instance.client.from('sub_goal').insert(subGoalsData);
    }
  }

  Map<String, dynamic> getFinanceJson() {
    return {
      "finance": {
        "total_money":
            _controllers["financeImpact"]["totalMoney"].controller.text,
        "amount_saved":
            _controllers["financeImpact"]["amountSaved"].controller.text,
        "time_saved":
            _controllers["financeImpact"]["timeSaved"].controller.text,
        "income_sources":
            _controllers["financeImpact"]["incomeSource"].map((incomeSource) {
              if (incomeSource is FormInputPair) {
                return {
                  "source": (incomeSource).key.controller.text,
                  "amount": (incomeSource).value.controller.text,
                };
              } else {
                print('\n\n\n Errorororrokr \n\n\n\n\n\n');
              }
            }).toList(),
      },
    };
  }

  int _expandedIndex = -1;

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
        label: "How much will this project",
        controller: TextEditingController(),
        type: "0",
        hint: "Enter how much you think this Goal Will Cost",
      ),
      "amountSaved": FormInput(
        label: "Amount Saved",
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
        label: "Time Saved",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _printAllValues,
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: GoalStepperForm(controllers: _controllers),
          // child: Container(
          // child: Container(
          // child: ExpansionPanelList(
          //   materialGapSize: MediaQuery.of(context).size.width * 0,
          //   children: [
          //     ExpansionPanel(
          //       headerBuilder: (context, isExpanded) {
          //         return MyExpansionPanelHeader(
          //           title: "Goal Information",
          //           icon: Icon(Icons.star),
          //         );
          //       },
          //       backgroundColor: const Color(0xff2F2F2F),
          //       canTapOnHeader: true,
          //       body: GoalForm(
          //         goalName: _controllers["goals"]["name"] as FormInput,
          //         goalTerms: _controllers["goals"]["term"] as FormInput,
          //         goalPriority: _controllers["goals"]["priority"] as FormInput,
          //         goalStatus: _controllers["goals"]["status"] as FormInput,
          //         goalDescription:
          //             _controllers["goals"]["description"] as FormInput,
          //       ),
          //       isExpanded: _expandedIndex == 0,
          //     ),
          //     ExpansionPanel(
          //       headerBuilder: (context, isExpanded) {
          //         return MyExpansionPanelHeader(
          //           title: "Motivation and Progress",
          //           icon: Icon(Icons.calendar_today),
          //         );
          //       },
          //       backgroundColor: const Color(0xff2F2F2F),
          //       canTapOnHeader: true,
          //       body: MotivationForm(
          //         motivations: _controllers["motivations"] as List<FormInput>,
          //         addMotivations: addMotivation,
          //       ),
          //       isExpanded: _expandedIndex == 1,
          //     ),
          //     ExpansionPanel(
          //       headerBuilder: (context, isExpanded) {
          //         return MyExpansionPanelHeader(
          //           title: "SubGoals And Deadlines",
          //           icon: Icon(Icons.wallet),
          //         );
          //       },
          //       backgroundColor: const Color(0xff2F2F2F),
          //       canTapOnHeader: true,
          //       body: SubGoalsForm(
          //         deadline:
          //             _controllers["subGoalsWithDeadline"]["deadline"]
          //                 as FormInput,
          //         subGoals:
          //             _controllers["subGoalsWithDeadline"]["subGoals"]
          //                 as List<FormInputPair>,
          //         addSubGoal: addSubGoals,
          //       ),
          //       isExpanded: _expandedIndex == 2,
          //     ),
          //     ExpansionPanel(
          //       headerBuilder: (context, isExpanded) {
          //         return MyExpansionPanelHeader(
          //           title: "Finance and Impact",
          //           icon: Icon(Icons.circle_outlined),
          //         );
          //       },
          //       backgroundColor: const Color(0xff2F2F2F),
          //       canTapOnHeader: true,
          //       body: Text('Finance Impact Form'),
          //       // body: FinanceImpactForm(
          //       //   totalMoney:
          //       //       _controllers["financeImpact"]["totalMoney"] as FormInput,
          //       //   amountSaved:
          //       //       _controllers["financeImpact"]["amountSaved"] as FormInput,
          //       //   timeSaved:
          //       //       _controllers["financeImpact"]["timeSaved"] as FormInput,
          //       //   incomeSources:
          //       //       _controllers["financeImpact"]["incomeSource"]
          //       //           as List<FormInputPair>,
          //       //   addIncomeSource: addIncomeSource,
          //       // ),
          //       isExpanded: _expandedIndex == 3,
          //     ),
          //   ],
          //   expansionCallback: (panelIndex, isExpanded) {
          //     setState(() {
          //       panelIndex == _expandedIndex
          //           ? _expandedIndex = -1
          //           : _expandedIndex = panelIndex;
          //     });
          //   },
          // ),
        ),
      ),
      // ),
      // ),
    );
  }
}
