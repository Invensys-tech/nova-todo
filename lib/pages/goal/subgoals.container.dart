// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
// import 'package:flutter_application_1/pages/goal/subgoal.expansion.dart';

// class SubGoalsContainer extends StatefulWidget {
//   final List<dynamic> subGoals;
//   const SubGoalsContainer({super.key, required this.subGoals});

//   @override
//   State<SubGoalsContainer> createState() => _SubGoalsContainerState();
// }

// class _SubGoalsContainerState extends State<SubGoalsContainer> {
//   int _expansionIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
//     print(widget.subGoals[0]);
//     return Container(
//       color: Color(0xff353535),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               children: const [
//                 Icon(Icons.account_tree, color: Colors.white),
//                 SizedBox(width: 8),
//                 Text(
//                   "Sub-Goals",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             // Multiple sub-goal widgets.
//             ExpansionPanelList(
//               materialGapSize: MediaQuery.of(context).size.width * 0.01,
//               expansionCallback: (panelIndex, isExpanded) {
//                 setState(() {
//                   _expansionIndex =
//                       _expansionIndex == panelIndex ? -1 : panelIndex;
//                 });
//               },
//               children: [
//                 ...widget.subGoals.asMap().entries.map((subGoal) {
//                   return ExpansionPanel(
//                     headerBuilder:
//                         (context, isExpanded) => MyExpansionPanelHeader(
//                           title: subGoal.value.goal,
//                           created_at: subGoal.value.created_at,
//                           percentage: 0.0,
//                         ),
//                     isExpanded: _expansionIndex == subGoal.key,
//                     backgroundColor: Color(0xff353535),
//                     // body: Text(subGoal.value.goal),
//                     body: SubGoalExpansion(
//                       title: subGoal.value.goal,
//                       id: subGoal.value.id,
//                       tasks: subGoal.value.tasks,
//                     ),
//                   );
//                 }),
//               ],
//             ),
//             // Other content below can be placed here.
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/pages/goal/subgoal.expansion.dart';

class SubGoalsContainer extends StatefulWidget {
  final List<SubGoal> subGoals;
  const SubGoalsContainer({super.key, required this.subGoals});

  @override
  State<SubGoalsContainer> createState() => _SubGoalsContainerState();
}

class _SubGoalsContainerState extends State<SubGoalsContainer> {
  int _expansionIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff353535),
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
                  print("llllllllllllllaaaaaaaaaaaaaaaaaaaa");
                  print(subGoal.toJson());
                  print(tasks);
                  print(percentage);

                  return ExpansionPanel(
                    headerBuilder:
                        (context, isExpanded) => MyExpansionPanelHeader(
                          title: subGoal.goal,
                          created_at: subGoal.created_at,
                          percentage: percentage,
                        ),
                    isExpanded: _expansionIndex == idx,
                    backgroundColor: const Color(0xff353535),
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
