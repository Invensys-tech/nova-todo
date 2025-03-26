import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

/// Model for a single task.
class Task {
  String text;
  bool isDone;
  Task({required this.text, this.isDone = false});
}

/// Model for a sub-goal, which includes a title and a list of tasks.
class SubGoal {
  String title;
  List<Task> tasks;
  SubGoal({required this.title, required this.tasks});
}

/// Main widget that holds a list of sub-goals.
class GoalViewTest extends StatefulWidget {
  const GoalViewTest({super.key});

  @override
  State<GoalViewTest> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalViewTest> {
  // Example list of sub-goals.
  List<SubGoal> subGoals = [
    SubGoal(
      title: "Learn Flutter",
      tasks: [
        Task(text: "Complete Flutter tutorial"),
        Task(text: "Build a sample app"),
      ],
    ),
    SubGoal(
      title: "Improve Dart Skills",
      tasks: [
        Task(text: "Read Dart documentation"),
        Task(text: "Practice coding challenges"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back to Goals"),
        backgroundColor: const Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            color: const Color(0xff353535),
            padding: const EdgeInsets.all(9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.account_tree, color: Colors.white),
                    SizedBox(width: 8),
                    Text("Sub-Goals", style: TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 10),
                Accordion(
                  headerBorderColor: const Color(0xff959595),
                  contentBorderColor: const Color(0xff959595),
                  headerBackgroundColor: const Color(0xff2F2F2F),
                  headerPadding: const EdgeInsets.all(8.0),
                  // Map each sub-goal to an AccordionSection.
                  children:
                      subGoals.map((subGoal) {
                        return AccordionSection(
                          key: PageStorageKey(subGoal.title),
                          header: Text(
                            subGoal.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          isOpen: true,
                          content: SubGoalTaskList(subGoal: subGoal),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that handles the list of tasks for a given sub-goal.
class SubGoalTaskList extends StatefulWidget {
  final SubGoal subGoal;
  const SubGoalTaskList({super.key, required this.subGoal});

  @override
  State<SubGoalTaskList> createState() => _SubGoalTaskListState();
}

class _SubGoalTaskListState extends State<SubGoalTaskList> {
  late List<Task> tasks;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    tasks = widget.subGoal.tasks;
  }

  void _toggleTask(int index, bool? value) {
    setState(() {
      tasks[index].isDone = value ?? false;
    });
  }

  void _addTask() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        tasks.add(Task(text: text));
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // List of tasks with checkboxes.
        ListView.builder(
          itemCount: tasks.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
        // Input field to add new tasks.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
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
    );
  }
}
