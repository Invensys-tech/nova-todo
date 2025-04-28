import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/pages/goal/form.goal.dart';
import 'package:flutter_application_1/utils/helpers.dart';
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

class EditGoal extends StatefulWidget {
  final Goal goal;
  const EditGoal({super.key, required this.goal});

  @override
  State<EditGoal> createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
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

  void _editGoal(int goalId) async {
    try {
      final goalResponse = await Supabase.instance.client
          .from('goal')
          .update({
            'name': _controllers["goals"]["name"].controller.text,
            'status': _controllers["goals"]["priority"].controller.text,
            'priority': _controllers["goals"]["priority"].controller.text,
            'description': _controllers["goals"]["description"].controller.text,
            'term': _controllers["goals"]["term"].controller.text,
            'userId': 1,
            'deadline': (formatDate(
              _controllers["subGoalsWithDeadline"]["deadline"].controller.text,
            )),
            'motivation': getMotivationJson(),
            // 'finance': {'totalMoney', 1000},
            'finance': getFinanceJson(),
          })
          .eq('id', goalId);

      // await updateSubGoals(goalId, subGoalId);
      print(goalResponse);
      print("Goal Updated successfully!");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Goal Updated successfully!")),
      );
      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> updateSubGoals(int goalId, int subGoalId) async {
    List<dynamic> subGoalsData = getSubGoalsJson(goalId);

    if (subGoalsData.isNotEmpty) {
      try {
        await Supabase.instance.client
            .from('sub_goal')
            .update(subGoalsData as Map)
            .eq('id', subGoalId);
      } catch (e) {
        print("Issue update in the sub goal");
        print(e);
      }
    }
  }

  void _printAllValues() async {
    print("-------- Goals ----------");
    print("Goal Name: ${_controllers["goals"]["name"].controller.text}");
    print("Goal Term: ${_controllers["goals"]["term"].controller.text}");
    print(
      "Goal Priority: ${_controllers["goals"]["priority"].controller.text}",
    );

    print("----- Motivations -----");
    for (int i = 0; i < _controllers["motivations"].length; i++) {
      print(
        "Motivation ${i + 1}: ${_controllers["motivations"][i].controller.text}",
      );
    }

    print("----------- Sub goals | DEADLINE -------------");
    print(
      "Deadline: ${_controllers["subGoalsWithDeadline"]["deadline"].controller.text}",
    );
    for (
      var i = 0;
      i < _controllers["subGoalsWithDeadline"]["subGoals"].length;
      i++
    ) {
      print(
        "Sub Goal ${i + 1}: ${_controllers["subGoalsWithDeadline"]["subGoals"][i].key.controller.text}, Deadline: ${_controllers["subGoalsWithDeadline"]["subGoals"][i].value.controller.text}",
      );
    }

    print("---------------------- FINANCE -----------------");
    print(_controllers["financeImpact"]["totalMoney"].controller.text);
    print(_controllers["financeImpact"]["amountSaved"].controller.text);
    print(_controllers["financeImpact"]["timeSaved"].controller.text);

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
      print("Goal INdex Checll");

      final goalIdIndex = goals.length - 1;
      // Fixing index to get the last inserted goal
      print(goals[goalIdIndex].id);
      print(goals[0].id);

      final goalId = goals[0].id;

      goals.forEach((goal) => print(goal.id));
      print("----------- Goal Id ------------");
      print(goalId);

      // // Now insert sub-goals
      await insertSubGoals(goalId);

      print(goalResponse);
      print("Goal added successfully!");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Goal added successfully!")));
      Navigator.pop(context);
    } catch (e) {
      print('llllllllllllllllllllllllllllll');
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

  getSubGoalsJson(num goalId) {
    // getSubGoalsJson() {
    try {
      print("kkkkkkkkkkkkkk");
      print(_controllers["subGoalsWithDeadline"]["subGoals"][0]);
      dynamic subGoalsData = _controllers["subGoalsWithDeadline"]["subGoals"]
          .map((subGoal) {
            Map<String, dynamic> subGoalData = {
              "goal": subGoal.key.controller.text,
              "deadline": formatDate(subGoal.value.controller.text),
              'goalId': goalId,
            };

            return subGoalData;
          });

      print("subGoalsData is true");
      print(subGoalsData == null);

      print(subGoalsData);

      return subGoalsData.toList();
    } catch (e) {
      print("Isus here");
      print(e);
    }
  }

  Future<void> insertSubGoals(int goalId) async {
    // List<Map<String, dynamic>> subGoalsData = getSubGoalsJson();
    List<dynamic> subGoalsData = getSubGoalsJson(goalId);
    // List<Map<String, dynamic>> subGoalsData =
    //     getSubGoalsJson() as List<Map<String, dynamic>>;

    if (subGoalsData.isNotEmpty) {
      try {
        await Supabase.instance.client.from('sub_goal').insert(subGoalsData);
      } catch (e) {
        print("Issue in the sub goal");
        print(e);
      }
    }
  }

  Map<String, dynamic> getFinanceJson() {
    try {
      final fin = _controllers["financeImpact"] as Map<String, dynamic>;

      return {
        "finance": {
          "total_money": fin["totalMoney"].controller.text,
          "amount_saved": fin["amountSaved"].controller.text,
          "time_saved": fin["timeSaved"].controller.text,
          // directly read the single controller:
          "income_source": fin["incomeSource"].controller.text,
        },
      };
    } catch (e) {
      print("Error inside finance");
      print(e);
      rethrow;
    }
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
    print("Edit Goal");
    print(widget.goal);
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
              child: const Text("Edit", style: TextStyle(color: Colors.white)),
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
          child: GoalStepperForm(
            controllers: _controllers,
            printAllValues: () => _editGoal(widget.goal.id),
            editData: widget.goal,
          ),
        ),
      ),
    );
  }
}
