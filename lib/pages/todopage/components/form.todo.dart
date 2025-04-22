import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/inputs/fixed-length-input.dart';
import 'package:flutter_application_1/components/inputs/radio.input.dart';
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
import 'package:flutter_application_1/components/inputs/scroll.selector.dart';
import 'package:intl/intl.dart';
import 'package:time_interval_picker/time_interval_picker.dart';

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
  final void Function(dynamic) addSubTask;

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
    required this.addSubTask,
  });

  static const List<Map<String, dynamic>> todoTypes = [
    {'label': 'High', 'value': 'High'},
    {'label': 'Medium', 'value': 'Medium'},
    {'label': 'Low', 'value': 'Low'},
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
  @override
  void initState() {
    super.initState();

    widget.date.controller.text = DateFormat(
      'dd-MM-yyyy',
    ).format(DateTime.now());
    widget.type.controller.text = 'High';
    // widget.type.controller.text = 'High';
  }

  bool subTasksIsOpen = false;

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
              // Row(
              Column(
                spacing: MediaQuery.of(context).size.width * 0.08,
                children: [
                  // Expanded(
                  //   child:
                  Column(
                    spacing: MediaQuery.of(context).size.width * 0.01,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeIntervalPicker(
                        // includeMidnight: false,
                        endLimit: null,
                        startLimit: null,
                        onChanged: (
                          DateTime? startTime,
                          DateTime? endTime,
                          bool isAllDay,
                        ) {
                          if (startTime != null) {
                            widget.startTimeInput.key.controller.text =
                                (startTime.hour < 10
                                    ? '0${startTime.hour}'
                                    : startTime.hour.toString());
                            widget.startTimeInput.value.controller.text =
                                (startTime.minute < 10
                                    ? '0${startTime.minute}'
                                    : startTime.minute.toString());
                          }

                          if (endTime != null) {
                            widget.endTimeInput.key.controller.text =
                                endTime.hour < 10
                                    ? '0${endTime.hour}'
                                    : endTime.hour.toString();
                            widget.endTimeInput.value.controller.text =
                                endTime.minute < 10
                                    ? '0${endTime.minute}'
                                    : endTime.minute.toString();
                          }
                        },
                      ),
                      // Row(
                      //   spacing: MediaQuery.of(context).size.width * 0.01,
                      //   children: [
                      //     Expanded(
                      // child: MyCustomTextInput(
                      //   maxLength: 2,
                      //   hintText: widget.startTimeInput.key.hint,
                      //   whatIsInput: TextInputType.numberWithOptions(
                      //     decimal: false,
                      //     signed: false,
                      //   ),
                      //   controller:
                      //       widget.startTimeInput.key.controller,
                      //   hasError: widget.startTimeInput.key.hasError,
                      //   errorMessage:
                      //       widget.startTimeInput.key.errorMessage,
                      // ),
                      //   child: MyScrollSelector(
                      //     items: List.generate(
                      //       24,
                      //       (index) =>
                      //           index < 10 ? '0$index' : index.toString(),
                      //     ),
                      //     onChange: (value) {
                      //       widget.startTimeInput.key.controller.text =
                      //           value;
                      //     },
                      //     selectedItem:
                      //         widget.startTimeInput.key.controller.text,
                      //   ),
                      // ),
                      // Text(':'),
                      // Expanded(
                      // child: MyCustomTextInput(
                      //   maxLength: 2,
                      //   hintText: widget.startTimeInput.value.hint,
                      //   whatIsInput: TextInputType.numberWithOptions(
                      //     decimal: false,
                      //     signed: false,
                      //   ),
                      //   controller:
                      //       widget.startTimeInput.value.controller,
                      //   hasError: widget.startTimeInput.value.hasError,
                      //   errorMessage:
                      //       widget.startTimeInput.value.errorMessage,
                      // ),
                      //       child: MyScrollSelector(
                      //         items: List.generate(
                      //           60,
                      //           (index) =>
                      //               index < 10 ? '0$index' : index.toString(),
                      //         ),
                      //         onChange: (value) {
                      //           widget.startTimeInput.value.controller.text =
                      //               value;
                      //         },
                      //         selectedItem:
                      //             widget.startTimeInput.value.controller.text,
                      //       ),
                      //     ),
                      //     // startTimeInput
                      //   ],
                      // ),
                      // Text('Start-Time', style: _taskTimesStyle),
                    ],
                  ),
                  // ),
                  // Expanded(
                  //   child:
                  // Column(
                  //   spacing: MediaQuery.of(context).size.width * 0.01,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     TimeIntervalPicker(
                  //       endLimit: null,
                  //       startLimit: null,
                  //       onChanged:
                  //           (
                  //             DateTime? startTime,
                  //             DateTime? endTime,
                  //             bool isAllDay,
                  //           ) {
                  //             widget.endTimeInput.key.controller.text = startTime.hour.toString();
                  //             widget.endTimeInput.value.controller.text = startTime.minute.toString();
                  //           },
                  //     ),
                  // Row(
                  //   spacing: MediaQuery.of(context).size.width * 0.01,
                  //   children: [
                  // Expanded(
                  // child: MyCustomTextInput(
                  //   maxLength: 2,
                  //   hintText: widget.endTimeInput.key.hint,
                  //   whatIsInput: TextInputType.numberWithOptions(
                  //     decimal: false,
                  //     signed: false,
                  //   ),
                  //   controller: widget.endTimeInput.key.controller,
                  //   hasError: widget.endTimeInput.key.hasError,
                  //   errorMessage:
                  //       widget.endTimeInput.key.errorMessage,
                  // ),
                  // child: MyScrollSelector(
                  //   items: List.generate(
                  //     24,
                  //     (index) =>
                  //         index < 10 ? '0$index' : index.toString(),
                  //   ),
                  //   onChange: (value) {
                  //     widget.endTimeInput.key.controller.text =
                  //         value;
                  //   },
                  //   selectedItem:
                  //       widget.endTimeInput.key.controller.text,
                  // ),
                  // ),
                  // Text(':'),
                  // Expanded(
                  // child: MyCustomTextInput(
                  //   maxLength: 2,
                  //   hintText: widget.endTimeInput.value.hint,
                  //   whatIsInput: TextInputType.numberWithOptions(
                  //     decimal: false,
                  //     signed: false,
                  //   ),
                  //   controller:
                  //       widget.endTimeInput.value.controller,
                  //   hasError: widget.endTimeInput.value.hasError,
                  //   errorMessage:
                  //       widget.endTimeInput.value.errorMessage,
                  // ),
                  //   child: MyScrollSelector(
                  //     items: List.generate(
                  //       60,
                  //       (index) =>
                  //           index < 10 ? '0$index' : index.toString(),
                  //     ),
                  //     onChange: (value) {
                  //       widget.endTimeInput.value.controller.text =
                  //           value;
                  //     },
                  //     selectedItem:
                  //         widget.endTimeInput.value.controller.text,
                  //   ),
                  // ),
                  // startTimeInput
                  //   ],
                  // ),
                  //     Text('End-Time', style: _taskTimesStyle),
                  //   ],
                  // ),
                  // ),
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
              // icon: Icons.fingerprint,
            ),
          ),
          // MySelector(
          //   label: 'Type',
          //   myDropdownItems: TodoForm.todoTypes,
          //   onSelect: setTodoTypes,
          //   currentValue: widget.type.controller.text,
          // ),
          MyRadioInput(
            label: 'Priority',
            groupKey: 'todo-types',
            options:
                TodoForm.todoTypes
                    .map((option) => option['label'] as String)
                    .toList(),
            onChanged: setTodoTypes,
            value: 'High',
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
          MySelector(
            label: 'Notify Me',
            myDropdownItems: TodoForm.notifyMeOptions,
            onSelect: setNotifyMe,
            currentValue: widget.notifyMe.controller.text,
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
                  tasks: widget.subTasks,
                  addSubTask: widget.addSubTask,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
