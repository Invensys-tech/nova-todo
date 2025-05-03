import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/todopage/add.todo.dart';
import 'package:flutter_application_1/repositories/daily-task.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class TodoViewPage extends StatefulWidget {
  final DailyTask? dailyTask;
  final Future<bool> Function(Map<String, dynamic>) addSubTask;
  final void Function() resetList;

  const TodoViewPage({
    super.key,
    this.dailyTask,
    required this.addSubTask,
    required this.resetList,
  });

  @override
  State<TodoViewPage> createState() => _TodoViewPageState();
}

class _TodoViewPageState extends State<TodoViewPage> {
  bool isSaving = false;

  updateSubTask(int id, bool isDone) {
    DailyTaskRepository().updateSubTask(id, isDone);
  }

  handleUpdateSubTask(subTask, isDone) {
    // DailyTaskRepository().updateSubTask(subTask['id'], isDone).then((value) {
    //   if (value) {
    setState(() {
      print(isDone);
      subTask['is_done'] = isDone;
    });
    //   }
    // });
  }

  final subTaskTextController = TextEditingController();

  addNewSubTask() async {
    setState(() {
      isSaving = true;
    });

    final response = await widget.addSubTask({'text': subTaskTextController.text, 'is_done': false});

    if (response) {
      setState(() {
        subTaskTextController.text = '';
        isSaving = false;
      });
    }
  }

  _showAlertDialog(BuildContext pageContext) {
    showDialog(
      context: pageContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text("Would you like to delete this task?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Color(0xFFEC003F))),
              onPressed: () async {
                if (widget.dailyTask != null) {
                  final deleted = await DailyTaskRepository().deleteById(
                    widget.dailyTask!.id!,
                  );
                  if (deleted) {
                    widget.resetList();
                    Navigator.of(context).pop();
                    Navigator.of(pageContext).pop();
                  }
                } else {
                  Navigator.of(context).pop();
                  Navigator.of(pageContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Color(0xff0d805e),
            size: 30,
          ),
        ),
        title: Text(
          translate("View Single Daily task"),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          Icon(Icons.more_vert)
        ],
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.012),
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .01,
                ),
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Theme.of(context).disabledColor
                ),
                // height: MediaQuery.of(context).size.height * .11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: MediaQuery.of(context).size.width * .005,
                      children: [
                        Icon(Icons.circle,size: 25, color: widget.dailyTask?.type== "High"? Colors.green: Colors.red,),
                        Text(
                          widget.dailyTask?.name ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translate("Task Time "),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .000,
                                ),
                                Text(
                                  // "${(widget.dailyTask?.taskTime) ?? ''} - ${widget.dailyTask?.endTime ?? ''}",
                                  // "${getTimeFromDateTime(DateTime.parse(widget.dailyTask!.taskTime))} - ${getTimeFromDateTime(DateTime.parse(widget.dailyTask!.endTime))}",
                                  "${widget.dailyTask!.taskTime} - ${widget.dailyTask!.endTime}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.26,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translate("Remind Me "),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * .000,
                                ),
                                Text(
                                  // "${(widget.dailyTask?.taskTime) ?? ''} - ${widget.dailyTask?.endTime ?? ''}",
                                  // "${getTimeFromDateTime(DateTime.parse(widget.dailyTask!.taskTime))} - ${getTimeFromDateTime(DateTime.parse(widget.dailyTask!.endTime))}",
                                  "Before 10 Min",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.26,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // children: [
                              //   Text("Task Date ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(.75)),),
                              //   SizedBox(height: MediaQuery.of(context).size.height*.000,),
                              //   Text("12 - 03 - 2025 ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),),
                              // ],
                              children: [
                                Text(
                                  translate("Task Date "),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .000,
                                ),
                                Text(
                                  widget.dailyTask?.date ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                    //   child: Row(
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         spacing: 10,
                    //         children: [
                    //           // Column(
                    //           //   crossAxisAlignment: CrossAxisAlignment.start,
                    //           //   children: [
                    //           //     Text(
                    //           //       translate('Priority'),
                    //           //       style: TextStyle(
                    //           //         fontSize: 16,
                    //           //         fontWeight: FontWeight.w600,
                    //           //       ),
                    //           //     ),
                    //           //     Text(widget.dailyTask?.type ?? ''),
                    //           //   ],
                    //           // ),
                    //
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.015),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate('Description'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.dailyTask?.description ?? '',
                    softWrap: true,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .025),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black.withOpacity(.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * .95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: MediaQuery.of(context).size.height * .005,
                  children: [


                    SizedBox(
                      width: MediaQuery.of(context).size.width * .95,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: MediaQuery.of(context).size.height * .005,
                        children: [
                          Text(
                            translate("Sub Tasks"),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          ...(widget.dailyTask?.subTasks.map((subTask) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 12,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap:
                                        () => handleUpdateSubTask(
                                      subTask,
                                      !subTask['is_done'],
                                    ),
                                    child:
                                    subTask['is_done']
                                        ? Stack(
                                      children: [
                                        Icon(
                                          Icons.check_box,
                                          size: 32,
                                          color: Color(0xFF004F3B),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(3.2),
                                          child: Icon(
                                            Icons.check,
                                            size: 24,
                                            color: Color(0xFFF4F4F5),
                                          ),
                                        ),
                                      ],
                                    )
                                        : Icon(
                                      Icons.square_outlined,
                                      size: 32,
                                      color: Color(0xFF3F3F47),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Text.rich(
                                    TextSpan(
                                      text: subTask['text'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,

                                        decoration:
                                        subTask['is_done']
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        decorationColor: Color(0xFF004F3B),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList() ??
                              []),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * .015),
                    Container(
                      height: MediaQuery.of(context).size.height * .05,
                      child: TextField(
                        controller: subTaskTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xFF27272A),
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(
                              color: Color(0xFF27272A),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(
                              color: Color(0xFF27272A),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .005),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: addNewSubTask,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Color(0xFF009966),
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Color(0xFF009966).withOpacity(.4),
                          ),
                          child:
                              isSaving
                                  ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.grey.withOpacity(.4),
                                    ),
                                  )
                                  : Text(
                                    translate('Add SubTasks'),
                                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: MediaQuery.of(context).size.height * .035),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: MediaQuery.of(context).size.height * 0.02,
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xFF27272A), width: 1),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AddTodoPage(
                              refetchData: () {},
                              dailyTask: widget.dailyTask,
                              isEditing: true,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        translate("Edit"),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xFFEC003F), width: 1),
                        ),
                      ),
                      onPressed: () {
                        _showAlertDialog(context);
                      },
                      child: Text(
                        translate("Delete"),
                        style: TextStyle(color: Color(0xFFEC003F)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
