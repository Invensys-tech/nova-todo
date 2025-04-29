import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/daily-task.entity.dart';
import 'package:flutter_application_1/pages/todopage/add.todo.dart';
import 'package:flutter_application_1/repositories/daily-task.repository.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class TodoViewPage extends StatefulWidget {
  final DailyTask? dailyTask;
  final void Function(Map<String, dynamic>) addSubTask;
  final void Function() resetList;
  const TodoViewPage({
    super.key,
    this.dailyTask,
    required this.addSubTask,
    required this.resetList
  });

  @override
  State<TodoViewPage> createState() => _TodoViewPageState();
}

class _TodoViewPageState extends State<TodoViewPage> {
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

  addNewSubTask() {
    setState(() {
      widget.addSubTask({'text': subTaskTextController.text, 'is_done': false});
    });
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
                  final deleted = await DailyTaskRepository().deleteById(widget.dailyTask!.id!);
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
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Color(0xff0d805e),
            size: 30,
          ),
        ),
        title: Text(
         translate( "View Single Daily task"),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .01,
                ),
                width: MediaQuery.of(context).size.width * .95,
                height: MediaQuery.of(context).size.height * .11,
                child: Column(
                  children: [
                    Row(
                      spacing: MediaQuery.of(context).size.width * .005,
                      children: [
                        Text(
                          widget.dailyTask?.name ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
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
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 translate( "Task Time "),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white.withOpacity(.75),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // children: [
                              //   Text("Task Date ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(.75)),),
                              //   SizedBox(height: MediaQuery.of(context).size.height*.000,),
                              //   Text("12 - 03 - 2025 ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),),
                              // ],
                              children: [
                                Text(
                                 translate( "Task Date "),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white.withOpacity(.75),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .000,
                                ),
                                Text(
                                  widget.dailyTask?.date ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: MediaQuery.of(context).size.height * 0.02,
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF27272A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xFF27272A), width: 2),
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
                       translate( "Edit"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF27272A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xFFEC003F), width: 2),
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
              SizedBox(height: MediaQuery.of(context).size.height * .015),
              SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: MediaQuery.of(context).size.height * .005,
                  children: [
                    Text(
                     translate( "Sub Tasks"),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
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
                                      color:
                                          subTask['is_done']
                                              ? Color(0xFF004F3B)
                                              : Color(0xFFE4E4E7),
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
              SizedBox(height: MediaQuery.of(context).size.height * .025),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xFF27272A)),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * .95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: MediaQuery.of(context).size.height * .005,
                  children: [
                    Text(
                      translate("New Sub Task"),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: subTaskTextController,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
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
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFF27272A),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFF27272A),
                            width: 1,
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
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Color(0xFF009966).withAlpha(33),
                          ),
                          child: Text(
                            translate('Add'),
                            style: TextStyle(color: Color(0xFF009966)),
                          ),
                        ),
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
