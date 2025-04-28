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
  final bool isEditing;

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
    this.isEditing = false,
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
    if (!widget.isEditing) {
      widget.type.controller.text = 'High';
    }
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

  // setTimePeriod(value) {
  //   if (value == 'am') {
  //
  //   }
  // }















  //---------------------------------------
  TextEditingController startController = TextEditingController();

  final TextEditingController endController = TextEditingController();

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
        startController.text = selectedTime.format(context);
      });
      // After selecting start time, automatically select end time
      _selectEndTime(context);
    }
  }

  // Function to show the time picker and set end time
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(), // default to start time if not selected
    );

    if (selectedTime != null) {
      setState(() {
        _endTime = selectedTime;
        endController.text = selectedTime.format(context);
      });
    }
  }




  //--------------

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery
          .of(context)
          .size
          .height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MyTimeSpanPicker(label: 'Task Time', onChange: setTaskTime),
          Column(
            spacing: MediaQuery
                .of(context)
                .size
                .width * 0.0025,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Time',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
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
                height: MediaQuery.of(context).size.height*.05,
                child: Column(

                  children: [

                    Row(
                      children: [
                        // Start Time TextField


                        Container(
                          width: MediaQuery.of(context).size.width*.425,
                          height: MediaQuery.of(context).size.height*.045,
                          child: GestureDetector(
                            onTap: () {
                              _selectStartTime(context); // Select start time
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: startController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                  hintText: 'Start Time',
                                  filled: true,
                                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                                  suffixIcon: Icon(Icons.access_time,color: Colors.grey.withOpacity(.7),),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(width: 2, color: Colors.green),
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
                        SizedBox(width: 16),

                        // End Time TextField
                        Container(
                          width: MediaQuery.of(context).size.width*.425,
                          height: MediaQuery.of(context).size.height*.045,
                          child: GestureDetector(
                            onTap: () {
                              // If end time is not selected yet, use the start time as the initial time
                              _selectEndTime(context);
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: endController,
                                readOnly: true,
                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                  hintText: 'End Time',
                                  filled: true,
                                  fillColor: Theme.of(context).scaffoldBackgroundColor,// Color for end time
                                  suffixIcon: Icon(Icons.access_time, color: Colors.grey.withOpacity(.5),),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(width: 2, color: Colors.green),
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
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .width * 0.04,),
          MyTextInput(
            label: 'Task Name',
            textFields: TextFields(
              hinttext: widget.name.hint,
              whatIsInput: widget.name.type,
              controller: widget.name.controller,
              // icon: Icons.fingerprint,
            ),
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .width * 0.015,),
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
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .width * 0.04,),
          Container(
            child: MyDateTimeInput(
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
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .width * 0.04,),
          Container(
            child: MySelector(
              label: 'Notify Me',
              myDropdownItems: TodoForm.notifyMeOptions,
              onSelect: setNotifyMe,
              currentValue: widget.notifyMe.controller.text,
            ),
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .width * 0.04,),
          MyMultiLineTextInput(
            label: 'Description',
            textFields: MultiLineTextField(
              hintText: widget.description.hint,
              controller: widget.description.controller,
              icon: Icons.note,
            ),
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .width * 0.04,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.withOpacity(.3)),
            ),
            child: ExpansionPanelList(
              elevation: 0,
              materialGapSize: MediaQuery
                  .of(context)
                  .size
                  .width * 0.01,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  subTasksIsOpen = !subTasksIsOpen;
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder:
                      (context, isExpanded) =>
                      MyExpansionPanelHeader(
                        title: 'Sub tasks you got in mind',
                      ),
                  isExpanded: subTasksIsOpen,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  // body: Text(subGoal.value.goal),
                  body: SubDailyTasksExpansion(
                    title: 'Sub Tasks',
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