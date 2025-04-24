import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/goal/common/goal.expansion.panel.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/pages/goal/subgoal.expansion.dart';

class SubGoalsContainer extends StatefulWidget {
  final List<SubGoal> subGoals;
  final Function(List<double>) onDataChanged;
  const SubGoalsContainer({
    super.key,
    required this.subGoals,
    required this.onDataChanged,
  });

  @override
  State<SubGoalsContainer> createState() => _SubGoalsContainerState();
}

class _SubGoalsContainerState extends State<SubGoalsContainer> {
  int _expansionIndex = -1;

  List<double> percentageArr = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xff353535),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              children: const [
                // Icon(Icons.account_tree, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Sub-Goals",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ExpansionPanelList(
              materialGapSize: MediaQuery.of(context).size.width * 0.01,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _expansionIndex =
                      _expansionIndex == panelIndex ? -1 : panelIndex;
                });
              },
              children: [
                ...widget.subGoals.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final subGoal = entry.value;
                  final tasks = subGoal.tasks as List<Task>;

                  // calculate percentage
                  final total = tasks.length;
                  final completed = tasks.where((t) => t.status == true).length;
                  final percentage =
                      total > 0 ? (completed / total * 100) : 0.0;

                  percentageArr.add(percentage);
                  setState(() {
                    widget.onDataChanged(percentageArr);
                  });
                  print("llllllllllllllaaaaaaaaaaaaaaaaaaaa");
                  print(subGoal.toJson());
                  print(tasks);
                  print(percentage);

                  return ExpansionPanel(
                    headerBuilder:
                        (context, isExpanded) => GoalExpansionPanel(
                          title: subGoal.goal,
                          created_at: subGoal.created_at,
                          percentage: percentage,
                        ),
                    isExpanded: _expansionIndex == idx,
                    // backgroundColor: const Color(0xFF424242),
                    body: SubGoalExpansion(
                      title: subGoal.goal,
                      id: subGoal.id,
                      tasks: tasks,
                    ),
                  );
                }).toList(),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
