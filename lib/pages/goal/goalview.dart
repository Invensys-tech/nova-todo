import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/goal/journal.container.dart';
import 'package:flutter_application_1/pages/goal/subgoals.container.dart';
import 'package:flutter_application_1/repositories/goal.repository.dart';

/// Model for an individual task.
class Task {
  String text;
  bool isDone;
  Task({required this.text, this.isDone = false});
}

/// The reusable widget for a sub-goal task list.
class TaskAccordion extends StatefulWidget {
  final String title;
  const TaskAccordion({super.key, required this.title});

  @override
  State<TaskAccordion> createState() => _TaskAccordionState();
}

class _TaskAccordionState extends State<TaskAccordion> {
  List<Task> tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _toggleTask(int index, bool? value) {
    setState(() {
      tasks[index].isDone = value ?? false;
    });
  }

  void _addTask() {
    final text = _taskController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        tasks.add(Task(text: text));
        _taskController.clear();
      });
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Accordion(
      key: PageStorageKey(widget.title),
      headerBorderColor: const Color(0xff959595),
      contentBorderColor: const Color(0xff959595),
      headerBackgroundColor: const Color(0xff2F2F2F),
      headerPadding: const EdgeInsets.all(8.0),
      children: [
        AccordionSection(
          contentBorderColor: const Color(0xff959595),
          isOpen: true,
          leftIcon: const Icon(Icons.star_rounded, color: Colors.white),
          // contentVerticalPadding: 20,
          contentBackgroundColor: const Color(0xff2F2F2F),
          header: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            children: [
              // Display list of tasks
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (value) => _toggleTask(index, value),
                    ),
                    title: Text(
                      task.text,
                      style: TextStyle(
                        decoration:
                            task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              // Input to add a new task
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 1.0,
                  vertical: 1.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Add a task",
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: _addTask,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The main view that reuses the same sub-goal widget multiple times.
class GoalView extends StatefulWidget {
  final int id;

  const GoalView({super.key, required this.id});

  @override
  State<GoalView> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  late Future<Goal> goal;

  final motivationTitles = [
    "This goal important to you Because",
    "When you achieve this goal",
    "If you don’t achieve this goal",
  ];

  void initState() {
    super.initState();
    goal = GoalRepository().fetchView(widget.id);
  }

  State<GoalView> createState() => _GoalViewState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Back to Goals",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        child: FutureBuilder(
          future: goal,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var goal = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Other content above can be placed here.
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.009,
                      ),

                      Text(
                        goal.description,
                        style: TextStyle(color: Colors.white54),
                        softWrap: true,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.009),
                  Text(
                    'Remember This',
                    style: TextStyle(color: Color(0xff009966)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.009),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        ...List.generate(
                          goal.motivation["motivations"].length,
                          (index) {
                            final motivation =
                                goal.motivation["motivations"][index] as String;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  motivationTitles[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white30),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    motivation,
                                    style: TextStyle(color: Colors.white70),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xff353535),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              SubGoalsContainer(subGoals: goal.subGoals),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xff353535),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              JournalContainer(
                                journals: goal.journals,
                                goalId: goal.id,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                ],
              );
            } else {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
          },
        ),
      ),
    );
  }
}
