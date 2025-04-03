import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class SubDailyTasksExpansion extends StatefulWidget {
  final String title;
  final int id;
  final List<dynamic> tasks;

  const SubDailyTasksExpansion({
    super.key,
    required this.title,
    required this.id,
    required this.tasks,
  });

  @override
  State<SubDailyTasksExpansion> createState() => _SubDailyTasksStateExpansion();
}

class _SubDailyTasksStateExpansion extends State<SubDailyTasksExpansion> {
  final _taskFormField = FormInput(
    controller: TextEditingController(),
    label: 'Sub-Task',
    hint: 'Sub-Task',
    type: "1",
  );

  addTask() {
    Task task = Task(
      name: _taskFormField.controller.text,
      status: false,
      subGoalId: widget.id,
    );
    // Task savedTask = await TaskRepository().createTask(task, widget.id);
    setState(() {
      widget.tasks.add(task);
      // _taskFormField.controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width) * 0.05,
      child: Column(
        children: [
          // Text(widget.title),
          ...widget.tasks.map(
            (task) => Row(
              children: [
                Checkbox(
                  value: task.status,
                  onChanged: (value) {
                    setState(() {
                      // TaskRepository().updateTask(task, value ?? false);
                      task.status = value!;
                    });
                  },
                ),
                Text(
                  style: TextStyle(
                    decoration:
                        task.status
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                  '${task.name}',
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFields(
                  hinttext: _taskFormField.hint,
                  whatIsInput: _taskFormField.type,
                  controller: _taskFormField.controller,
                ),
              ),
              IconButton(onPressed: addTask, icon: const Icon(Icons.add)),
            ],
          ),
        ],
      ),
    );
  }
}
