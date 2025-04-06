import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class SubDailyTasksExpansion extends StatefulWidget {
  final String title;
  final List<dynamic> tasks;
  final void Function(DailySubTask subTask) addSubTask;

  const SubDailyTasksExpansion({
    super.key,
    required this.title,
    required this.tasks,
    required this.addSubTask,
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
    DailySubTask subTask = DailySubTask(
      text: _taskFormField.controller.text,
      isDone: false,
    );
    // Task savedTask = await TaskRepository().createTask(task, widget.id);
    // setState(() {
    widget.addSubTask(subTask);
    _taskFormField.controller.clear();
    // });
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
                  value: task.isDone,
                  onChanged: (value) {
                    setState(() {
                      // TaskRepository().updateTask(task, value ?? false);
                      task.isDone = value!;
                    });
                  },
                ),
                Text(
                  style: TextStyle(
                    decoration:
                        task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                  '${task.text}',
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
