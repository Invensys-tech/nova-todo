import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/inputs/radio.input.dart';
import 'package:flutter_application_1/components/inputs/selector.input.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class HabitForm extends StatefulWidget {
  final String? date;
  final void Function() refetchData;
  const HabitForm({super.key, required this.refetchData, this.date});

  @override
  State<HabitForm> createState() => _HabitFormState();
}

class _HabitFormState extends State<HabitForm> {
  FormInput name = FormInput(
    label: 'Title',
    hint: 'eg: Books and Music',
    controller: TextEditingController(),
    type: "1",
  );
  FormInput repetition = FormInput(
    label: 'Task Repetition',
    hint: 'Enter name',
    controller: TextEditingController(),
    type: "1",
  );

  @override
  void initState() {
    super.initState();
    repetition.controller.text = 'Daily';
  }

  TextEditingController repetitionTypeController = TextEditingController();

  List<Map<String, dynamic>> repetitionItems = [
    {'label': 'Daily', 'value': 'Daily'},
    {'label': 'Monthly', 'value': 'Monthly'},
  ];

  Set<String> customRepetitionItems = {};

  setRepetitionItem(value) {
    setState(() {
      if (customRepetitionItems.contains(value)) {
        customRepetitionItems.remove(value);
      } else {
        customRepetitionItems.add(value);
      }
    });
  }

  // handleSetRepetitionItem(value) {
  //   setState(() {
  //     return () => setRepetitionItem(value);
  //   });
  // }

  selectRepetition(value) {
    setState(() {
      repetition.controller.text = value;
      customRepetitionItems.clear();
      if (repetition.controller.text == 'Everyday') {
        customRepetitionItems = {
          'MON',
          'TUE',
          'WED',
          'THU',
          'FRI',
          'SAT',
          'SUN',
        };
      }
    });
  }

  selectRepetitionType(value) {
    setState(() {
      repetitionTypeController.text = value;
    });
  }

  navigateBack() {
    Navigator.pop(context);
  }

  saveHabit() {
    Habit newHabit = Habit.fromJson({
      'name': name.controller.text,
      'type': repetition.controller.text,
      'date': widget.date ?? getDateOnly(DateTime.now()),
      'repetition_type': repetitionTypeController.text,
      'repetitions': customRepetitionItems.toList(),
      'is_done': false,
    });
    // Map<String, dynamic> jsonValue = {
    //   'name': name.controller.text,
    //   'type': repetition.controller.text,
    //   'date': widget.date ?? getDateOnly(DateTime.now()),
    //   'repetition_type': repetitionTypeController.text,
    //   'repetitions': customRepetitionItems.toList(),
    //   'is_done': false,
    // };

    HabitsRepository().createHabit(newHabit).then((value) {
      if (value) {
        navigateBack();
        widget.refetchData();
      }
    });
  }

  // Widget buildHabitForm() {
  //   return Container();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Habit",
          style: TextStyle(
            color: Color(0xFFD4D4D8),
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: navigateBack,
              icon: const Icon(Icons.arrow_back, color: Colors.green),
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            MyTextInput(
              label: name.label,
              textFields: TextFields(
                // icon: Icons.fingerprint,
                hinttext: name.hint,
                whatIsInput: name.type,
                controller: name.controller,
              ),
            ),
            // MySelector(
            //   label: repetition.label,
            //   myDropdownItems: repetitionItems,
            //   onSelect: selectRepetition,
            //   icon: Icons.circle_notifications_sharp,
            //   currentValue: repetition.controller.text,
            //   controller: repetition.controller,
            // ),
            MyRadioInput(
              label: 'Frequency',
              groupKey: 'frequency',
              onChanged: selectRepetition,
              options: ['Everyday', 'Daily', 'Weekly'],
            ),
            // MyRadioInput(
            //   label: 'Specific',
            //   groupKey: 'repetition_type',
            //   options: ['Everyday', 'Once a week'],
            //   onChanged: selectRepetitionType,
            //   orientation: 'horizontal',
            // ),
            Row(
              // spacing: MediaQuery.of(context).size.width * 0.04,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  (repetition.controller.text == 'Daily' ||
                              repetition.controller.text == 'Everyday'
                          ? ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
                          : ['Week1', 'Week2', 'Week3', 'Week4'])
                      .map(
                        (e) => GestureDetector(
                          onTap: () => setRepetitionItem(e),
                          child: Container(
                            width:
                                repetition.controller.text == 'Daily' ||
                                        repetition.controller.text == 'Everyday'
                                    ? 45.0
                                    : 70.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color:
                                  repetition.controller.text == 'Everyday' ||
                                          customRepetitionItems.contains(e)
                                      ? Color(0xFF8B0836)
                                      : Color(0xFF27272A),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 2.0,
                                horizontal: 7.0,
                              ),
                              child: Text(e, style: TextStyle(fontSize: 11)),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.height * 0.005,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: MediaQuery.of(context).size.height * 0.02,
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF27272A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: navigateBack,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF009966),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: saveHabit,
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Outfit',
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
    );
  }
}
