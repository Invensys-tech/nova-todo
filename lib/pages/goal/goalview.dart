import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/common/quil.dart';
import 'package:flutter_application_1/pages/goal/common/quiltest.dart';

// void main() {
//   runApp(MaterialApp(home: GoalView()));
// }

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
class GoalView extends StatelessWidget {
  final int id;
  const GoalView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // For demonstration, we create three sub-goals with the same title.
    List<Widget> subGoalWidgets = List.generate(
      3,
      (index) => TaskAccordion(title: "Learn Flutter"),
    );

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Other content above can be placed here.
            SizedBox(height: MediaQuery.of(context).size.height * 0.009),
            Text(
              'We want you to remember this',
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.009),

            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.005,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Icon(Icons.arrow_right),
                  Expanded(
                    child: Text(
                      "Assume the taxi self and how happy you you are going to be in the community",
                      style: TextStyle(color: Colors.white70),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.005,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Icon(Icons.arrow_right),
                  Expanded(
                    child: Text(
                      "Assume the taxi self and how happy you you are going to be in the community",
                      style: TextStyle(color: Colors.white70),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.005,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Icon(Icons.arrow_right),
                  Expanded(
                    child: Text(
                      "Assume the taxi self and how happy you you are going to be in the community",
                      style: TextStyle(color: Colors.white70),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  // height: MediaQuery.of(context).size.height * 0.03,
                  color: Color(0xff444444),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "First Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Second Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  // height: MediaQuery.of(context).size.height * 0.03,
                  color: Color(0xff444444),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "First Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Second Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  // height: MediaQuery.of(context).size.height * 0.03,
                  color: Color(0xff444444),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "First Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Second Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  // height: MediaQuery.of(context).size.height * 0.03,
                  color: Color(0xff444444),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "First Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Second Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.009),

                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has beenthe industry's standard dummy text ever sincethe 1500s, ",
                  style: TextStyle(color: Colors.white54),
                  softWrap: true,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            const SizedBox(height: 20),
            // "Sub-Goals" title
            Container(
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
                    ...subGoalWidgets,
                    // Other content below can be placed here.
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
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
                    MaterialPageRoute(builder: (context) => QuilPage()),
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

            // QuilExample(),

            // QuillEditorExample(),
          ],
        ),
      ),
    );
  }
}
