import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/inputs/fixed-length-input.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/todopage/todo-view.dart';
import 'package:flutter_application_1/repositories/daily-task.repository.dart';
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
          backgroundColor: Color(0xff0d805e).withOpacity(.35),
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
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
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => {},
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => TodoViewPage(dailyTask: widget.dailyTask),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .05,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .05,
                      vertical: MediaQuery.of(context).size.height * .015,
                    ),
                    width: MediaQuery.of(context).size.width * .93,
                    decoration: BoxDecoration(
                      // color: Color(0xff0d805e).withOpacity(.35),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xFF27272A).withOpacity(.35),
                        width: 2.5,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: MediaQuery.of(context).size.width * .02,
                          children: [
                            Icon(
                              widget.dailyTask.completionPercentage == 100
                                  ? Icons.check
                                  : Icons.alarm,
                              size: 24,
                              color: getCompletionColor(),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.dailyTask.name,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFE4E4E7),
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
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .0125,
                        ),
                        Text(
                          widget.dailyTask.description,
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text(
                                //   "Status : ",
                                //   style: GoogleFonts.lato(
                                //     fontSize: 13,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                Text(
                                  // widget.dailyTask.isDone ? 'Done' : 'Waiting',
                                  getCompletionText(),
                                  style: GoogleFonts.lato(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: getCompletionColor(),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xFF009966),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * .02),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .02),
      ],
    );
  }
}
