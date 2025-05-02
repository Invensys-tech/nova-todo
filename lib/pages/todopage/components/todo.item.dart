import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/inputs/fixed-length-input.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/todopage/todo-view.dart';
import 'package:flutter_application_1/repositories/daily-task.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoItem extends StatefulWidget {
  final DailyTask dailyTask;
  final void Function() setParentState;

  const TodoItem({
    super.key,
    required this.dailyTask,
    required this.setParentState,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  initState() {
    super.initState();
  }

  String getCompletionText() {
    if (widget.dailyTask.completionPercentage == 100) return 'Done';
    if (widget.dailyTask.completionPercentage == 0) return 'Not Yet';
    return widget.dailyTask.completionPercentage.toString();
  }

  Color getCompletionColor() {
    if (widget.dailyTask.completionPercentage != 100) return Color(0xFFF54900);
    return Color(0xFF009966);
  }

  Future<bool> updateDailyTaskPercentage(int completionPercentage) async {
    if (completionPercentage > 100 || completionPercentage < 0) {
      return false;
    }
    if (widget.dailyTask.id == null) {
      return false;
    }
    bool updated = await DailyTaskRepository()
        .updateDailyTaskCompletionPercentage(
          widget.dailyTask.id!,
          completionPercentage,
        );

    if (updated) {
      widget.setParentState();
    }
    return updated;
  }

  Future<bool> addSubTask(Map<String, dynamic> subTask) async {
    Map<String, dynamic> newSubTask = {
      ...subTask,
      'daily_task_id': widget.dailyTask.id,
    };
    final response = await DailyTaskRepository().addDailySubTask(newSubTask);
    if (response) {
      widget.dailyTask.subTasks.add(newSubTask);
      setState(() {
        widget.setParentState();
      });

      return true;
    }

    return false;
  }

  showCompletionPercentageUpdateDialog(BuildContext context) {
    TextEditingController percentageController = TextEditingController(
      text: widget.dailyTask.completionPercentage.toString(),
    );
    String errorMessage = 'Invalid Completion Percentage';
    bool hasError = false;
    showDialog(
      context: context,
      builder: (context) {
        closeDialog() {
          Navigator.of(context).pop();
        }

        handleUpdateCompletionPercentage() {
          if (percentageController.text.isEmpty) {
            return;
          }
          int completionPercentage = int.parse(percentageController.text);
          updateDailyTaskPercentage(completionPercentage).then((value) {
            if (value) {
              closeDialog();
              hasError = false;
            } else {
              setState(() {
                hasError = true;
              });
            }
          });
        }

        return AlertDialog(
          title: Text('Completion Percentage'),
          content: Container(
            height: MediaQuery.of(context).size.height * .1,
            child: MyCustomTextInput(
              hintText: 'Enter Completion Percentage',
              whatIsInput: TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              maxLength: 2,
              controller: percentageController,
              errorMessage: errorMessage,
              hasError: hasError,
            ),
          ),
          actions: [
            TextButton(onPressed: closeDialog, child: Text('Cancel')),
            TextButton(
              onPressed: handleUpdateCompletionPercentage,
              child: Text('Update'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.015),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: showCompletionPercentageUpdateDialog,
              backgroundColor: Colors.yellow.shade900,
              foregroundColor: Colors.white,
              icon: Icons.percent,
              label: 'Custom',
            ),
            SlidableAction(
              onPressed: (context) => updateDailyTaskPercentage(100),
              backgroundColor: Color(0xFF1D9402),
              foregroundColor: Colors.white,
              icon: Icons.sentiment_satisfied,
              label: 'Done',
              borderRadius: BorderRadius.only(topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // SlidableAction(
            //   onPressed: (context) => {},
            //   backgroundColor: Color(0xFFFE4A49),
            //   foregroundColor: Colors.white,
            //   icon: Icons.delete,
            //   label: 'Delete',
            // ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color:
                  widget.dailyTask.completionPercentage != null
                      ? Colors.grey.shade300
                      : Color(0xFFEC003F),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), topLeft: Radius.circular(7)),
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed:
                        () =>
                            widget.dailyTask.completionPercentage != null
                                ? updateDailyTaskPercentage(0)
                                : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF555B59),
                    ),
                    child: Text(
                      '😔 I didn\'t',
                      style: TextStyle(color: Color(0xFFF4F4F5)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => TodoViewPage(
                      dailyTask: widget.dailyTask,
                      addSubTask: addSubTask,
                      resetList: widget.setParentState,
                    ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .035,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05,
                    vertical: MediaQuery.of(context).size.height * .015,
                  ),
                  width: MediaQuery.of(context).size.width * .93,
                  decoration: BoxDecoration(
                    color:
                        widget.dailyTask.type == 'High'
                            ? Color(0xff0d805e)
                            : widget.dailyTask.type == 'Medium'
                            ? Color.fromARGB(255, 128, 120, 13)
                            : Color.fromARGB(255, 128, 13, 13),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            trimString(widget.dailyTask.name, length: 15),
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${widget.dailyTask.taskTime} - ${widget.dailyTask.endTime}',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(.75),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .0125,
                      ),
                      Text(
                        trimString(widget.dailyTask.description, length: 60),
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(.8),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.lock_clock, size: 20, color: Colors.white),
                          Row(
                            children: [
                              Text(
                                "Status : ",
                                style: GoogleFonts.lato(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                // widget.dailyTask.isDone ? 'Done' : 'Waiting',
                                widget.dailyTask.completionPercentage == 100
                                    ? 'Done'
                                    : 'Waiting',
                                style: GoogleFonts.lato(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
