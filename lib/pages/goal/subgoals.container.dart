import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/pages/goal/subgoal.expansion.dart';

class SubGoalsContainer extends StatefulWidget {
  final List<dynamic> subGoals;
  const SubGoalsContainer({super.key, required this.subGoals});

  @override
  State<SubGoalsContainer> createState() => _SubGoalsContainerState();
}

class _SubGoalsContainerState extends State<SubGoalsContainer> {
  int _expansionIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff353535),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.account_tree, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Sub-Goals",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Multiple sub-goal widgets.
            ExpansionPanelList(
              materialGapSize: MediaQuery.of(context).size.width * 0.01,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _expansionIndex =
                      _expansionIndex == panelIndex ? -1 : panelIndex;
                });
              },
              children: [
                ...widget.subGoals.asMap().entries.map((subGoal) {
                  return ExpansionPanel(
                    headerBuilder:
                        (context, isExpanded) =>
                            MyExpansionPanelHeader(title: subGoal.value.goal),
                    isExpanded: _expansionIndex == subGoal.key,
                    backgroundColor: Color(0xff353535),
                    // body: Text(subGoal.value.goal),
                    body: SubGoalExpansion(
                      title: subGoal.value.goal,
                      id: subGoal.value.id,
                      tasks: subGoal.value.tasks,
                    ),
                  );
                }),
              ],
            ),
            // Other content below can be placed here.
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
