import 'package:chapasdk/domain/constants/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/inputs/dropdown.selector.dart';
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
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

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
  final bool isEditing;
  final Map<String, bool> errors;

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
    required this.errors,
    this.isEditing = false,
  });

  static const List<Map<String, dynamic>> todoTypes = [
    {'label': 'High', 'value': 'High'},
    {'label': 'Medium', 'value': 'Medium'},
    {'label': 'Low', 'value': 'Low'},
  ];

  static const List<Map<String, dynamic>> notifyMeOptions = [
    {'label': 'None', 'value': 'none'},
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

    if (!widget.isEditing) {
      widget.type.controller.text = 'High';
      widget.date.controller.text = DateFormat(
        'dd-MM-yyyy',
      ).format(DateTime.now());
      widget.notifyMe.controller.text = 'none';
    } else {
      // print(widget.startTimeInput.key.controller.text);
      // print(widget.startTimeInput.value.controller.text);
      // print(widget.endTimeInput.key.controller.text);
      // print(widget.endTimeInput.value.controller.text);
      print(widget.notifyMe.controller.text);

      DateTime parsedTime = DateFormat("HH:mm").parse(
        widget.startTimeInput.key.controller.text +
            ':' +
            widget.startTimeInput.value.controller.text,
      );

      startTimeController.text = DateFormat("hh:mm a").format(parsedTime);

      parsedTime = DateFormat("HH:mm").parse(
        widget.endTimeInput.key.controller.text +
            ':' +
            widget.endTimeInput.value.controller.text,
      );

      endTimeController.text = DateFormat("hh:mm a").format(parsedTime);
    }
  }

  bool subTasksIsOpen = false;
  String notifyMeText = 'None';

  final TextStyle _taskTimesStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w200,
  );

  setTodoTypes(dynamic value) {
    widget.type.controller.text = value;
  }

  setNotifyMe(dynamic value) {
    notifyMeText =
        TodoForm.notifyMeOptions.firstWhere((option) {
          return option['value'] == value;
        })['label'] ??
        value;
    setState(() {
      widget.notifyMe.controller.text = value;
    });
  }

  // setTimePeriod(value) {
  //   if (value == 'am') {
  //
  //   }
  // }

  //---------------------------------------
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  // Store selected start time
  TimeOfDay? _startTime;

  // Store selected end time
  TimeOfDay? _endTime;

  // Function to show the time picker and set both start and end times
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _startTime = selectedTime;
        startTimeController.text = selectedTime.format(context);
        widget.startTimeInput.key.controller.text = getHourFromTimeOfDay(
          selectedTime,
        );
        widget.startTimeInput.value.controller.text = getMinuteFromTimeOfDay(
          selectedTime,
        );
      });
      // After selecting start time, automatically select end time
      _selectEndTime(context);
    }
  }

  // Function to show the time picker and set end time
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime:
          _startTime ??
          TimeOfDay.now(), // default to start time if not selected
    );

    if (selectedTime != null) {
      setState(() {
        _endTime = selectedTime;
        endTimeController.text = selectedTime.format(context);
        widget.endTimeInput.key.controller.text = getHourFromTimeOfDay(
          selectedTime,
        );
        widget.endTimeInput.value.controller.text = getMinuteFromTimeOfDay(
          selectedTime,
        );
      });
    }
  }

  final errorTextStyle = TextStyle(color: Colors.red.shade400, fontSize: 10);

  //--------------

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MyTimeSpanPicker(label: 'Task Time', onChange: setTaskTime),
          Column(
            spacing: MediaQuery.of(context).size.width * 0.0025,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate('Task Time'),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),

              // Row(
              //           Row(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Container(
              //                 width: MediaQuery.of(context).size.width*.3,
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       spacing: MediaQuery
              //                           .of(context)
              //                           .size
              //                           .width * 0.01,
              //                       children: [
              //                         Container(
              //                           width: MediaQuery.of(context).size.width*.125,
              //                           child: MyCustomTextInput(
              //                             maxLength: 2,
              //                             hintText: widget.startTimeInput.key.hint,
              //                             whatIsInput: TextInputType.numberWithOptions(
              //                               decimal: false,
              //                               signed: false,
              //                             ),
              //                             controller: widget.startTimeInput.key
              //                                 .controller,
              //                             hasError: widget.startTimeInput.key.hasError,
              //                             errorMessage:
              //                             widget.startTimeInput.key.errorMessage,
              //                             maxValue: 11,
              //                           ),
              //                         ),
              //                         Text(':'),
              //                         Container(
              //                           width: MediaQuery.of(context).size.width*.125,
              //                           child: MyCustomTextInput(
              //                             maxLength: 2,
              //                             hintText: widget.startTimeInput.value.hint,
              //                             whatIsInput: TextInputType.numberWithOptions(
              //                               decimal: false,
              //                               signed: false,
              //                             ),
              //                             controller: widget.startTimeInput.value
              //                                 .controller,
              //                             hasError: widget.startTimeInput.value.hasError,
              //                             errorMessage:
              //                             widget.startTimeInput.value.errorMessage,
              //                             maxValue: 59,
              //                           ),
              //                         ),
              //                         // startTimeInput
              //                       ],
              //                     ),
              //                     // ),
              //                     Text('Start-Time', style: _taskTimesStyle),
              //                   ],
              //                 ),
              //               ),
              //               Container(
              //                 width: MediaQuery.of(context).size.width*.3,
              //                 child: Column(
              //                   spacing: MediaQuery
              //                       .of(context)
              //                       .size
              //                       .width * 0.0025,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       spacing: MediaQuery
              //                           .of(context)
              //                           .size
              //                           .width * 0.01,
              //                       children: [
              //                         Container(
              // width: MediaQuery.of(context).size.width*.125,
              //                           child: MyCustomTextInput(
              //                             maxLength: 2,
              //                             hintText: widget.endTimeInput.key.hint,
              //                             whatIsInput: TextInputType.numberWithOptions(
              //                               decimal: false,
              //                               signed: false,
              //                             ),
              //                             controller: widget.endTimeInput.key.controller,
              //                             hasError: widget.endTimeInput.key.hasError,
              //                             errorMessage: widget.endTimeInput.key
              //                                 .errorMessage,
              //                             maxValue: 11,
              //                           ),
              //                         ),
              //                         Text(':'),
              //                         Container(
              // width: MediaQuery.of(context).size.width*.125,
              //                           child: MyCustomTextInput(
              //                             maxLength: 2,
              //                             hintText: widget.endTimeInput.value.hint,
              //                             whatIsInput: TextInputType.numberWithOptions(
              //                               decimal: false,
              //                               signed: false,
              //                             ),
              //                             controller: widget.endTimeInput.value
              //                                 .controller,
              //                             hasError: widget.endTimeInput.value.hasError,
              //                             errorMessage: widget.endTimeInput.value
              //                                 .errorMessage,
              //                             maxValue: 59,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     Text('End-Time', style: _taskTimesStyle),
              //                   ],
              //                 ),
              //               ),
              //               // Expanded(flex: 1,
              //               //     child: MySelector(myDropdownItems: [
              //               //       {'label': 'AM', 'value': 'am'},
              //               //       {'label': 'PM', 'value': 'pm'}
              //               //     ], onSelect: (value) {}, label: '', currentValue: ''))
              //             ],
              //           )
              Container(
                // height: MediaQuery.of(context).size.height * .05,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Start Time TextField
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .425,
                              height: MediaQuery.of(context).size.height * .045,
                              child: GestureDetector(
                                onTap: () {
                                  _selectStartTime(
                                    context,
                                  ); // Select start time
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: startTimeController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal: 10,
                                      ),
                                      hintText: translate('Start Time'),
                                      filled: true,
                                      fillColor:
                                          Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor,
                                      suffixIcon: Icon(
                                        Icons.access_time,
                                        color: Colors.grey.withOpacity(.7),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          width: 2,
                                          color: Colors.green,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.green.withOpacity(.3),
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(.3),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            widget.errors['startTime']!
                                ? Text(
                                  'Start time is required',
                                  style: errorTextStyle,
                                )
                                : Container(),
                          ],
                        ),
                        SizedBox(width: 16),

                        // End Time TextField
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .425,
                              height: MediaQuery.of(context).size.height * .045,
                              child: GestureDetector(
                                onTap: () {
                                  // If end time is not selected yet, use the start time as the initial time
                                  _selectEndTime(context);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: endTimeController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal: 10,
                                      ),
                                      hintText: translate('End Time'),
                                      filled: true,
                                      fillColor:
                                          Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor,
                                      // Color for end time
                                      suffixIcon: Icon(
                                        Icons.access_time,
                                        color: Colors.grey.withOpacity(.5),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          width: 2,
                                          color: Colors.green,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.green.withOpacity(.3),
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(.3),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            widget.errors['endTime']!
                                ? Text(
                                  'End time is required',
                                  style: errorTextStyle,
                                )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextInput(
                label: translate('Task Name'),
                textFields: TextFields(
                  hinttext: widget.name.hint,
                  whatIsInput: widget.name.type,
                  controller: widget.name.controller,
                  // icon: Icons.fingerprint,
                ),
              ),
              widget.errors['name']!
                  ? Text('Name is required', style: errorTextStyle)
                  : Container(),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.015),
          MyRadioInput(
            label: translate('Priority'),
            groupKey: 'todo-types',
            options:
                TodoForm.todoTypes
                    .map((option) => option['label'] as String)
                    .toList(),
            onChanged: setTodoTypes,
            value: 'High',
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.04),
          Container(
            child: MyDateTimeInput(
              label: translate('Date'),
              dateFields: DateSelector(
                controller: widget.date.controller,
                hintText: widget.date.hint,
                icon: Icons.calendar_today,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDate: DateTime.now(),
                // initialDate: DateTime.now().format('yyyy-MM-dd'),
                dateFormat: widget.isEditing ? DateFormat('yyyy-MM-dd') : null,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.04),
          Container(
            // child: MySelector(
            //   label: translate('Notify Me'),
            //   myDropdownItems: TodoForm.notifyMeOptions,
            //   onSelect: setNotifyMe,
            //   currentValue: "ghjkl",
            //   controller: widget.notifyMe.controller,
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Reminder",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                DropdownButton(
                  menuWidth: MediaQuery.of(context).size.width * .8,
                  items:
                      TodoForm.notifyMeOptions
                          .map(
                            (menuItem) => DropdownMenuItem(
                              value: menuItem['value'],
                              child: Text(menuItem['label']),
                            ),
                          )
                          .toList(),
                  onChanged: setNotifyMe,
                  value: widget.notifyMe.controller.text,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.04),
          MyMultiLineTextInput(
            label: translate('Description'),
            textFields: MultiLineTextField(
              hintText: widget.description.hint,
              controller: widget.description.controller,
              icon: Icons.note,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.04),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.withOpacity(.3)),
            ),
            child: ExpansionPanelList(
              elevation: 0,
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
                        title: translate('Sub tasks you got in mind'),
                      ),
                  isExpanded: subTasksIsOpen,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  // body: Text(subGoal.value.goal),
                  body: SubDailyTasksExpansion(
                    title: translate('Sub Tasks'),
                    tasks: widget.subTasks,
                    addSubTask: widget.addSubTask,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ! If time interval picket is needed later

// Expanded(
//   child:
// Expanded(
//   child: Row(
//     spacing: MediaQuery.of(context).size.width * 0.01,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
// TimeIntervalPicker(
//   // includeMidnight: false,
//   endLimit: null,
//   startLimit: null,
//   onChanged: (
//     DateTime? startTime,
//     DateTime? endTime,
//     bool isAllDay,
//   ) {
//     if (startTime != null) {
//       widget.startTimeInput.key.controller.text =
//           (startTime.hour < 10
//               ? '0${startTime.hour}'
//               : startTime.hour.toString());
//       widget.startTimeInput.value.controller.text =
//           (startTime.minute < 10
//               ? '0${startTime.minute}'
//               : startTime.minute.toString());
//     }
//
//     if (endTime != null) {
//       widget.endTimeInput.key.controller.text =
//           endTime.hour < 10
//               ? '0${endTime.hour}'
//               : endTime.hour.toString();
//       widget.endTimeInput.value.controller.text =
//           endTime.minute < 10
//               ? '0${endTime.minute}'
//               : endTime.minute.toString();
//     }
//   },
// ),
