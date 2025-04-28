import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/inputs/radio.input.dart';
import 'package:flutter_application_1/components/inputs/selector.input.dart';
import 'package:flutter_application_1/components/inputs/scroll.selector.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class HabitForm extends StatefulWidget {
  final String? date;
  final Habit? habit;
  final bool isEditing;
  final void Function() refetchData;

  const HabitForm({
    super.key,
    required this.refetchData,
    this.date,
    this.habit,
    this.isEditing = false,
  });

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
  FormInput frequency = FormInput(
    label: 'Frequency',
    hint: 'Habit Frequency',
    controller: TextEditingController(),
    type: "0",
  );

  @override
  void initState() {
    super.initState();

    if (widget.isEditing && widget.habit != null) {
      name.controller.text = widget.habit!.name;
      repetition.controller.text = widget.habit!.type;
      frequency.controller.text = widget.habit!.frequency.toString();
      customRepetitionItems = Set.from(widget.habit!.repetitions);
    } else {
      repetition.controller.text = 'Daily';
      frequency.controller.text = '0';
    }
  }

  TextEditingController repetitionTypeController = TextEditingController();

  List<Map<String, dynamic>> repetitionItems = [
    {'label': 'Daily', 'value': 'Daily'},
    {'label': 'Weekly', 'value': 'Weekly'},
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

  static const days = [
    {'label': 'MON', 'value': 'Monday'},
    {'label': 'TUE', 'value': 'Tuesday'},
    {'label': 'WED', 'value': 'Wednesday'},
    {'label': 'THU', 'value': 'Thursday'},
    {'label': 'FRI', 'value': 'Friday'},
    {'label': 'SAT', 'value': 'Saturday'},
    {'label': 'SUN', 'value': 'Sunday'},
  ];

  selectRepetition(value) {
    setState(() {
      repetition.controller.text = value;
      customRepetitionItems.clear();
    });
  }

  selectRepetitionType(value) {
    setState(() {
      repetitionTypeController.text = value;
    });
  }

  selectFrequency(value) {
    setState(() {
      frequency.controller.text = value;
    });
  }

  navigateBack({BuildContext? buildContext}) {
    Navigator.pop(buildContext ?? context);
  }

  // printDays() {
  //   print(getDayFromDateTime(DateTime.now()));
  //   print(getDayFromDateTime(DateTime.now().add(Duration(days: 1))));
  //   print(getDayFromDateTime(DateTime.now().add(Duration(days: 2))));
  //   print(getDayFromDateTime(DateTime.now().add(Duration(days: 3))));
  //   print(getDayFromDateTime(DateTime.now().add(Duration(days: 4))));
  //   print(getDayFromDateTime(DateTime.now().add(Duration(days: 5))));
  //   print(getDayFromDateTime(DateTime.now().add(Duration(days: 6))));
  // }

  resetForm() {
    setState(() {
      name.controller.text = '';
      frequency.controller.text = '';
      repetition.controller.text = '';
      customRepetitionItems = {};
    });
  }

  saveHabit() {
    // Map<String, dynamic> jsonValue = {
    //   'name': name.controller.text,
    //   'type': repetition.controller.text,
    //   'date': widget.date ?? getDateOnly(DateTime.now()),
    //   'repetition_type': repetitionTypeController.text,
    //   'repetitions': customRepetitionItems.toList(),
    //   'is_done': false,
    // };

    // printDays();

    if (name.controller.text == '') {
      print('Name is required');
      return;
    }

    if (repetition.controller.text == 'Daily' ||
        repetition.controller.text == 'Monthly') {
      try {
        int frequencyValue = int.parse(frequency.controller.text);
        if (frequencyValue <= 0) {
          print('Frequency cannot be less than 0');
          return;
        }
      } catch (e) {
        print(
          'Frequency needs to be specified for ${repetition.controller.text} habits',
        );
        print(e);
        return;
      }
    } else if (repetition.controller.text == 'Weekly') {
      if (customRepetitionItems.length == 0) {
        print(
          'Repetition days must be specified for ${repetition.controller.text} habits',
        );
        return;
      }
    }

    // if () {

    // }

    Habit newHabit = Habit.fromJson({
      'name': name.controller.text,
      'type': repetition.controller.text,
      'date': widget.date ?? getDateOnly(DateTime.now()),
      'repetition_type': repetitionTypeController.text,
      'repetitions': customRepetitionItems.toList(),
      'is_done': false,
      'frequency': int.parse(
        frequency.controller.text == '' ? '0' : frequency.controller.text,
      ),
    });

    print(jsonEncode(newHabit));

    // HabitsRepository().fetchHabitsByDate(DateTime.now()).then((habits) {
    //   for (var habit in habits) {
    //     print(jsonEncode(habit.toJson()));
    //   }
    // });

    if (widget.isEditing && widget.habit != null) {
      HabitsRepository().updateById(newHabit, widget.habit!.id!).then((value) {
        if (value) {
          navigateBack(buildContext: context);
          widget.refetchData();
          resetForm();
        }
      });
    } else {
      HabitsRepository().createHabit(newHabit).then((value) {
        if (value) {
          navigateBack();
          widget.refetchData();
          resetForm();
        }
      });
    }
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
            MyRadioInput(
              label: 'Repetition',
              groupKey: 'repetition',
              onChanged: selectRepetition,
              options: ['Daily', 'Weekly', 'Monthly'],
              value: repetition.controller.text,
            ),
            repetition.controller.text == 'Weekly'
                ? Row(
                  // spacing: MediaQuery.of(context).size.width * 0.04,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      days
                          .map(
                            (e) => GestureDetector(
                              onTap: () => setRepetitionItem(e['value']),
                              child: Container(
                                width:
                                    repetition.controller.text == 'Weekly'
                                        ? 45.0
                                        : 70.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color:
                                      customRepetitionItems.contains(e['value'])
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
                                  child: Text(
                                    e['label']!,
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                )
                // : MyTextInput(
                //   label: 'Frequency',
                //   textFields: TextFields(
                //     hinttext: frequency.hint,
                //     whatIsInput: frequency.type,
                //     controller: frequency.controller,
                //   ),
                // ),
                // : MyScrollSelector(
                //   label: 'Frequency',
                //   items: List.generate(25, (index) => index.toString()),
                //   onChange: selectFrequency,
                //   selectedItem: frequency.controller.text,
                // ),
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: MediaQuery.of(context).size.height * 0.008,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Frequency',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Row(
                      spacing: MediaQuery.of(context).size.width * 0.01,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (int.parse(frequency.controller.text) > 1) {
                              setState(() {
                                frequency.controller.text =
                                    (int.parse(frequency.controller.text) - 1)
                                        .toString();
                              });
                            }
                          },
                          child: Text('-'),
                        ),
                        Text(frequency.controller.text),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              frequency.controller.text =
                                  (int.parse(frequency.controller.text) + 1)
                                      .toString();
                            });
                          },
                          child: Text('+'),
                        ),
                      ],
                    ),
                  ],
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
