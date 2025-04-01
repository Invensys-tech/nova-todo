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
  final TextEditingController taskTime;
  final TextEditingController taskEndTime;
  const TodoForm({
    super.key,
    required this.name,
    required this.time,
    required this.type,
    required this.date,
    required this.notifyMe,
    required this.description,
    required this.subTasks,
    required this.taskTime,
    required this.taskEndTime,
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

  setTaskTime(TimeOfDay startTime, TimeOfDay endTime) {
    // widget.time.controller.text = value;.
    setState(() {
      widget.taskTime.text = formatTimeOfDayToString(startTime);
      widget.taskEndTime.text = formatTimeOfDayToString(endTime);
    });
  }

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
          MyTimeSpanPicker(label: 'Task Time', onChange: setTaskTime),
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
