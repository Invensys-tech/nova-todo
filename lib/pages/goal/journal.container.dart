import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/goal/common/quil.dart';
import 'package:flutter_quill/flutter_quill.dart';

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
  addJournal(Journal journal, int? id) {
    setState(() {
      widget.journals.add(journal);
    });
  }

  updateJournal(Journal journal, int? id) {
    if (id != null) {
      setState(() {
        widget.journals[id] = journal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xff353535),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  "Journals",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700 , color: Theme.of(context).disabledColor),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuilExample(
                              journal: '',
                              goalId: widget.goalId,
                              addJournal: addJournal,
                            ),
                      ),
                    );
                  },
                  child: const Text(
                    "Add Journal",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...widget.journals.map((journal) {
              List<dynamic> jsonList = jsonDecode(jsonDecode(journal.journal));

              // print("============= JSON =============");
              // print(jsonList);

              // Convert List<dynamic> to List<Map<String, dynamic>>
              List<dynamic> dataList =
                  jsonList.map((e) => e as dynamic).toList();
              Document quillData = Document.fromJson((dataList));
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => QuilExample(
                            journal: jsonDecode(journal.journal),
                            goalId: widget.goalId,
                            addJournal: updateJournal,
                            id: journal.id,
                          ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    
                    border: Border.all(color: Colors.grey.withOpacity(.3), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("12 - 02 -2025",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),),
                      SizedBox(height: MediaQuery.of(context).size.height*.0025,),
                      Text(quillData.toPlainText(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),
              );
            }),
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
                color: Theme.of(context).disabledColor,
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
                            journal: '',
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
                    "Add Journal",
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
