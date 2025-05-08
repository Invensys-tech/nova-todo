import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/pages/todopage/components/form.todo.dart';
import 'package:flutter_application_1/repositories/daily-task.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class AddTodoPage extends StatefulWidget {
  final void Function() refetchData;
  final bool isEditing;
  final DailyTask? dailyTask;

  const AddTodoPage({
    super.key,
    required this.refetchData,
    this.isEditing = false,
    this.dailyTask,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController taskTimeController = TextEditingController();
  TextEditingController taskEndTimeController = TextEditingController();

  // TextEditingController();
  FormInput name = FormInput(
    label: 'Task Name',
    hint: 'Enter Task Name',
    controller: TextEditingController(),
    errorMessage: 'Name is required',
    type: '1',
  );
  FormInput time = FormInput(
    label: 'Time',
    hint: 'Enter Time',
    controller: TextEditingController(),
    type: '1',
  );
  FormInput type = FormInput(
    label: 'type',
    hint: 'Enter Type',
    controller: TextEditingController(),
    type: '1',
  );
  FormInput date = FormInput(
    label: 'Date',
    hint: 'Enter Date',
    controller: TextEditingController(),
    type: '1',
  );
  FormInput notifyMe = FormInput(
    label: 'Notify Me',
    hint: 'Enter Notify Me',
    controller: TextEditingController(),
    type: '1',
  );
  FormInput description = FormInput(
    label: 'Description',
    hint: 'Add Description',
    controller: TextEditingController(),
    type: '1',
  );

  FormInputPair startTimeInput = FormInputPair(
    key: FormInput(
      label: 'Hours',
      hint: '00',
      type: "0",
      controller: TextEditingController(),
      errorMessage: 'Must be below 24',
    ),
    value: FormInput(
      label: 'Minutes',
      hint: '00',
      type: "0",
      controller: TextEditingController(),
      errorMessage: 'Must be below 60',
    ),
  );
  FormInputPair endTimeInput = FormInputPair(
    key: FormInput(
      label: 'Hours',
      hint: '00',
      type: "0",
      controller: TextEditingController(),
      errorMessage: 'Must be below 24',
    ),
    value: FormInput(
      label: 'Minutes',
      hint: '00',
      type: "0",
      controller: TextEditingController(),
      errorMessage: 'Must be below 60',
    ),
  );

  bool isSaving = false;

  final Map<String, bool> errors = {
    'name': false,
    'startTime': false,
    'endTime': false,
  };

  setErrors({bool name = false, bool startTime = false, bool endTime = false}) {
    setState(() {
      errors['name'] = name;
      errors['startTime'] = startTime;
      errors['endTime'] = endTime;
    });
  }

  clearForm() {
    name.controller.clear();
    time.controller.clear();
    type.controller.clear();
    date.controller.clear();
    notifyMe.controller.clear();
    taskTimeController.clear();
    taskEndTimeController.clear();
    description.controller.clear();
    startTimeInput.key.controller.clear();
    startTimeInput.value.controller.clear();
    endTimeInput.key.controller.clear();
    endTimeInput.value.controller.clear();
  }

  setValidationError(FormInput input) {
    setState(() {
      input.hasError = true;
    });
  }

  bool parseStartEndTime() {
    try {
      if (int.parse(startTimeInput.key.controller.text) > 23 ||
          int.parse(endTimeInput.key.controller.text) > 23 ||
          int.parse(startTimeInput.value.controller.text) > 60 ||
          int.parse(endTimeInput.value.controller.text) > 60) {
        if (int.parse(startTimeInput.key.controller.text) > 23) {
          setValidationError(startTimeInput.key);
        }
        if (int.parse(startTimeInput.value.controller.text) > 60) {
          setValidationError(startTimeInput.value);
        }
        if (int.parse(endTimeInput.key.controller.text) > 23) {
          setValidationError(endTimeInput.key);
        }
        if (int.parse(endTimeInput.value.controller.text) > 60) {
          setValidationError(endTimeInput.value);
        }
        return false;
      }
    } catch (e) {
      setState(() {
        setErrors(startTime: true, endTime: true);
      });
    }
    taskTimeController.text =
        '${startTimeInput.key.controller.text}:${startTimeInput.value.controller.text}';
    taskEndTimeController.text =
        '${endTimeInput.key.controller.text}:${endTimeInput.value.controller.text}';

    return true;
  }

  saveTodo() async {
    setState(() {
      setErrors();

      try {
        isSaving = true;

        if (name.controller.text == '') {
          setErrors(name: true);
          isSaving = false;
          return;
        }

        bool parsedCorrectly = parseStartEndTime();
        if (!parsedCorrectly) {
          setErrors(startTime: true, endTime: true);
          isSaving = false;
          return;
        }

        if (name.controller.text == '') {
          isSaving = false;
          return;
        }

        if (widget.isEditing && widget.dailyTask != null) {
          // final updatedData = {
          //   'name': name.controller.text,
          //   'type': type.controller.text,
          //   'description': description.controller.text,
          //   'date': date.controller.text,
          // };

          Map<String, dynamic> formData = {
            'name': name.controller.text,
            // 'time': formatDate(time.controller.text),
            'type': type.controller.text,
            'date': date.controller.text,
            'notifyMe': notifyMe.controller.text,
            'taskTime': taskTimeController.text,
            'taskEndTime': taskEndTimeController.text,
            'description': description.controller.text,
          };

          final updatedDailyTask = DailyTask.fromUserInputJson(formData);

          DailyTaskRepository()
              .updateDailyTask(updatedDailyTask, widget.dailyTask!.id!)
              .then((value) {
                if (value) {
                  clearForm();
                  widget.refetchData();
                  Navigator.pop(context);
                }
              });

          return;
        }

        Map<String, dynamic> formData = {
          'name': name.controller.text,
          // 'time': formatDate(time.controller.text),
          'type': type.controller.text,
          'date': formatDate(date.controller.text),
          'notifyMe': notifyMe.controller.text,
          'taskTime': taskTimeController.text,
          'taskEndTime': taskEndTimeController.text,
          'description': description.controller.text,
          'daily_sub_tasks': subTasks,
        };
        // clearForm();

        print(jsonEncode(formData));

        DailyTask dailyTaskData = DailyTask.fromUserInputJson(formData);
        // DailyTaskRepository().addDailyTaskFromJson(dailyTaskData);
        DailyTaskRepository()
            .addDailyTask(dailyTaskData)
            .then((value) {
              clearForm();
              setState(() {
                isSaving = false;
              });
              widget.refetchData();
              Navigator.pop(context);
            })
            .catchError((error) {
              setState(() {
                isSaving = false;
              });
            });
      } catch (e) {
        setState(() {
          isSaving = false;
        });
        rethrow;
      }
      // widget.saveTodo();
    });
  }

  List<dynamic> subTasks = [];

  addSubTask(subTask) {
    setState(() {
      subTasks.add(subTask);
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEditing && widget.dailyTask != null) {
      name.controller.text = widget.dailyTask!.name;
      type.controller.text = widget.dailyTask!.type;
      date.controller.text = widget.dailyTask!.date;

      final taskTime = getTimePartFromDateTimeString(
        widget.dailyTask!.taskTime,
      );
      final endTime = getTimePartFromDateTimeString(widget.dailyTask!.endTime);

      startTimeInput.key.controller.text = taskTime.split(':')[0];
      startTimeInput.value.controller.text = taskTime.split(':')[1];
      endTimeInput.key.controller.text = endTime.split(':')[0];
      endTimeInput.value.controller.text = endTime.split(':')[1];

      description.controller.text = widget.dailyTask!.description;
      notifyMe.controller.text = widget.dailyTask!.notifyMeText ?? 'none';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: Color(0xFF009966),
              ),
            ),
          ],
        ),
        title: const Text("Add New Todo"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .9,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              TodoForm(
                name: name,
                time: time,
                type: type,
                date: date,
                notifyMe: notifyMe,
                description: description,
                subTasks: subTasks,
                // taskTime: taskTimeController,
                // taskEndTime: taskEndTimeController,
                startTimeInput: startTimeInput,
                endTimeInput: endTimeInput,
                addSubTask: addSubTask,
                isEditing: widget.isEditing,
                errors: errors,
              ),
              Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (isSaving) {
                          return;
                        }

                        saveTodo();
                      },
                      child:
                          isSaving
                              ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.grey.shade300,
                                ),
                              )
                              : Text(
                                widget.isEditing ? "Edit" : "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
