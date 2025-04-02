import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/inputs/selector.input.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
// import 'package:flutter_application_1/components/inputs/time-picker.input.dart';
import 'package:flutter_application_1/components/inputs/time-span-picker.input.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/components/inputs/multi-line-text.input.dart';
import 'package:flutter_application_1/components/inputs/date.input.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/pages/todopage/components/sub-tasks.expansion.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class TodoForm extends StatefulWidget {
  final FormInput name;
  final FormInput time;
  final FormInput type;
  final FormInput date;
  final FormInput notifyMe;
  final FormInput description;
  final List<dynamic> subTasks;
  // final TextEditingController taskTime;
  // final TextEditingController taskEndTime;
  final FormInputPair startTimeInput;
  final FormInputPair endTimeInput;

  const TodoForm({
    super.key,
    required this.name,
    required this.time,
    required this.type,
    required this.date,
    required this.notifyMe,
    required this.description,
    required this.subTasks,
    // required this.taskTime,
    // required this.taskEndTime,
    required this.startTimeInput,
    required this.endTimeInput,
  });

  static const List<Map<String, dynamic>> todoTypes = [
    {'label': 'Essential', 'value': 'Essential'},
    {'label': 'Considered', 'value': 'Considered'},
    {'label': 'Unnecessary', 'value': 'Unnecessary'},
  ];

  static const List<Map<String, dynamic>> notifyMeOptions = [
    {'label': 'Before 2 Min', 'value': '2'},
    {'label': 'Before 5 Min', 'value': '5'},
    {'label': 'Before 10 Min', 'value': '10'},
    {'label': 'Before 15 Min', 'value': '15'},
  ];

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  bool subTasksIsOpen = false;

  // FormInputPair startTimeInput = FormInputPair(
  //   key: FormInput(
  //     label: 'Hours',
  //     hint: '00',
  //     type: "0",
  //     controller: TextEditingController(),
  //   ),
  //   value: FormInput(
  //     label: 'Minutes',
  //     hint: '00',
  //     type: "0",
  //     controller: TextEditingController(),
  //   ),
  // );

  // FormInputPair endTimeInput = FormInputPair(
  //   key: FormInput(
  //     label: 'Hours',
  //     hint: '00',
  //     type: "0",
  //     controller: TextEditingController(),
  //   ),
  //   value: FormInput(
  //     label: 'Minutes',
  //     hint: '00',
  //     type: "0",
  //     controller: TextEditingController(),
  //   ),
  // );

  // setTaskTime(TimeOfDay startTime, TimeOfDay endTime) {
  //   // widget.time.controller.text = value;.
  //   setState(() {
  //     widget.taskTime.text = formatTimeOfDayToString(startTime);
  //     widget.taskEndTime.text = formatTimeOfDayToString(endTime);
  //   });
  // }

  final TextStyle _taskTimesStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w200,
  );

  setTodoTypes(dynamic value) {
    widget.type.controller.text = value;
  }

  setNotifyMe(dynamic value) {
    widget.notifyMe.controller.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      color: const Color(0x00000000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: MediaQuery.of(context).size.width * 0.04,
        children: [
          // MyTimeSpanPicker(label: 'Task Time', onChange: setTaskTime),
          Column(
            spacing: MediaQuery.of(context).size.width * 0.04,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Time'),
              Row(
                spacing: MediaQuery.of(context).size.width * 0.08,
                children: [
                  Expanded(
                    child: Column(
                      spacing: MediaQuery.of(context).size.width * 0.01,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: MediaQuery.of(context).size.width * 0.01,
                          children: [
                            Expanded(
                              child: TextFields(
                                hinttext: widget.startTimeInput.key.hint,
                                whatIsInput: widget.startTimeInput.key.type,
                                controller:
                                    widget.startTimeInput.key.controller,
                              ),
                            ),
                            Text(':'),
                            Expanded(
                              child: TextFields(
                                hinttext: widget.startTimeInput.value.hint,
                                whatIsInput: widget.startTimeInput.value.type,
                                controller:
                                    widget.startTimeInput.value.controller,
                              ),
                            ),
                            // startTimeInput
                          ],
                        ),
                        Text('Start-Time', style: _taskTimesStyle),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: MediaQuery.of(context).size.width * 0.01,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: MediaQuery.of(context).size.width * 0.01,
                          children: [
                            Expanded(
                              child: TextFields(
                                hinttext: widget.endTimeInput.key.hint,
                                whatIsInput: widget.endTimeInput.key.type,
                                controller: widget.endTimeInput.key.controller,
                              ),
                            ),
                            Text(':'),
                            Expanded(
                              child: TextFields(
                                hinttext: widget.endTimeInput.value.hint,
                                whatIsInput: widget.endTimeInput.value.type,
                                controller:
                                    widget.endTimeInput.value.controller,
                              ),
                            ),
                            // startTimeInput
                          ],
                        ),
                        Text('End-Time', style: _taskTimesStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          MyTextInput(
            label: 'Task Name',
            textFields: TextFields(
              hinttext: widget.name.hint,
              whatIsInput: widget.name.type,
              controller: widget.name.controller,
              icon: Icons.fingerprint,
            ),
          ),
          MySelector(
            label: 'Type',
            myDropdownItems: TodoForm.todoTypes,
            onSelect: setTodoTypes,
          ),
          MyDateTimeInput(
            label: 'Date',
            dateFields: DateSelector(
              controller: widget.date.controller,
              hintText: widget.date.hint,
              icon: Icons.calendar_today,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              initialDate: DateTime.now(),
            ),
          ),
          // MyDateTimeInput(
          //   label: 'Notify Me',
          //   dateFields: DateSelector(
          //     controller: widget.notifyMe.controller,
          //     hintText: widget.notifyMe.hint,
          //     icon: Icons.calendar_today,
          //     firstDate: DateTime(2000),
          //     lastDate: DateTime(2100),
          //     initialDate: DateTime.now(),
          //   ),
          // ),
          MySelector(
            label: 'Notify Me',
            myDropdownItems: TodoForm.notifyMeOptions,
            onSelect: setNotifyMe,
          ),
          MyMultiLineTextInput(
            label: 'Description',
            textFields: MultiLineTextField(
              hintText: widget.description.hint,
              controller: widget.description.controller,
              icon: Icons.note,
            ),
          ),
          ExpansionPanelList(
            materialGapSize: MediaQuery.of(context).size.width * 0.01,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                subTasksIsOpen = !subTasksIsOpen;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder:
                    (context, isExpanded) => MyExpansionPanelHeader(
                      title: 'Sub tasks you got in mind',
                    ),
                isExpanded: subTasksIsOpen,
                backgroundColor: Color(0xff353535),
                // body: Text(subGoal.value.goal),
                body: SubDailyTasksExpansion(
                  title: 'Sub Tasks',
                  id: 1,
                  tasks: widget.subTasks,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
