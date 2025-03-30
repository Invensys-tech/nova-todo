import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/goal/common/quil.dart';

class JournalContainer extends StatefulWidget {
  final List<Journal> journals;
  final int goalId;

  const JournalContainer({
    super.key,
    required this.journals,
    required this.goalId,
  });

  @override
  State<JournalContainer> createState() => _JournalContainerState();
}

class _JournalContainerState extends State<JournalContainer> {
  addJournal(Journal journal) {
    setState(() {
      widget.journals.add(journal);
    });
  }

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
                  "Journals",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...widget.journals.map(
              (journal) => Container(
                padding: EdgeInsets.all(8.0),
                child: Text("journal id"),
              ),
            ),
            // Multiple sub-goal widgets.
            // ExpansionPanelList(
            //   materialGapSize: MediaQuery.of(context).size.width * 0.01,
            //   expansionCallback: (panelIndex, isExpanded) {
            //     setState(() {
            //       _expansionIndex =
            //           _expansionIndex == panelIndex ? -1 : panelIndex;
            //     });
            //   },
            //   children: [
            //     ...widget.subGoals.asMap().entries.map((subGoal) {
            //       return ExpansionPanel(
            //         headerBuilder:
            //             (context, isExpanded) =>
            //                 MyExpansionPanelHeader(title: subGoal.value.goal),
            //         isExpanded: _expansionIndex == subGoal.key,
            //         backgroundColor: Color(0xff353535),
            //         // body: Text(subGoal.value.goal),
            //         body: SubGoalExpansion(
            //           title: subGoal.value.goal,
            //           id: subGoal.value.id,
            //           tasks: subGoal.value.tasks,
            //         ),
            //       );
            //     }),
            //   ],
            // ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => QuilExample(
                            journal: 'pixel 6 hello',
                            goalId: widget.goalId,
                            addJournal: addJournal,
                          ),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center,
                  child: const Text(
                    "Open Quill Editor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Other content below can be placed here.
          ],
        ),
      ),
    );
  }
}
