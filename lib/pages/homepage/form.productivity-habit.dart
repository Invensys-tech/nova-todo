import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/habit-list.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/habit-list.repositoty.dart';
import 'package:flutter_application_1/repositories/productivity-habit.repository.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class ProductivityHabitForm extends StatefulWidget {
  final FormInput title;
  final FormInput frequency;
  final FormInput time;
  final FormInput description;
  const ProductivityHabitForm({
    super.key,
    required this.description,
    required this.frequency,
    required this.time,
    required this.title,
  });

  @override
  State<ProductivityHabitForm> createState() => _ProductivityHabitFormState();
}

class _ProductivityHabitFormState extends State<ProductivityHabitForm> {
  int _expandedIndex = -1;

  final List<dynamic> _controller = [
    {
      "title": FormInput(
        label: "Title",
        hint: "Enter your title",
        type: "1",
        controller: TextEditingController(),
      ),
      "pairs": [
        FormInputPair(
          key: FormInput(
            label: "Frequency",
            hint: "Frequency",
            type: "0",
            controller: TextEditingController(),
          ),
          value: FormInput(
            label: "Time",
            hint: "Time",
            type: "0",
            controller: TextEditingController(),
          ),
        ),
      ],
    },
  ];

  /// Adds a new habit entry
  void _addNewHabit() {
    setState(() {
      _controller.add({
        "title": FormInput(
          label: "Title",
          hint: "Enter your title",
          type: "1",
          controller: TextEditingController(),
        ),
        "pairs": [
          FormInputPair(
            key: FormInput(
              label: "Frequency",
              hint: "Frequency",
              type: "0",
              controller: TextEditingController(),
            ),
            value: FormInput(
              label: "Time",
              hint: "Time",
              type: "0",
              controller: TextEditingController(),
            ),
          ),
        ],
      });

      // Expand the newly added item
      _expandedIndex = _controller.length - 1;
    });
  }

  /// Adds a new pair entry inside an existing habit
  void _addNewPair(int index) {
    setState(() {
      _controller[index]["pairs"].add(
        FormInputPair(
          key: FormInput(
            label: "New Key",
            hint: "Enter key",
            type: "0",
            controller: TextEditingController(),
          ),
          value: FormInput(
            label: "New Value",
            hint: "Enter value",
            type: "0",
            controller: TextEditingController(),
          ),
        ),
      );
    });
  }

  /// Logs all the field values held by the inputs
  void _logFormValues() async {
    print("Logging all form values:");

    print(widget.title.controller.text);
    print(widget.frequency.controller.text);
    print(widget.time.controller.text);
    print(widget.description.controller.text);

    Productivity productivity = await ProductivityRepository()
        .createProductivity({
          'title': widget.title.controller.text,
          'frequency': widget.frequency.controller.text,
          'time': (widget.time.controller.text),
          'description': widget.description.controller.text,
          'user_id': 1,
        });

    print(productivity.id);

    for (var habit in _controller) {
      String title = habit["title"].controller.text;

      ProductivityHabit productivityHabit = await ProductivityHabitRepository()
          .createProductivityHabit({
            'title': title,
            'productivity_id': productivity.id,
          });
      print("Habit Title: $title");

      for (var pair in habit["pairs"]) {
        String keyText = pair.key.controller.text;
        String valueText = pair.value.controller.text;
        print("   Pair -> Key: $keyText, Value: $valueText");
        HabitList habitList = await HabitListRepository().createHabitList({
          'title': keyText,
          'time': (valueText),
          'productivity_habit_id': productivityHabit.id,
        });
      }
    }
    Navigator.popUntil(context, ModalRoute.withName('/productivity-home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2F2F),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Add Productivity",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    panelIndex == _expandedIndex
                        ? _expandedIndex = -1
                        : _expandedIndex = panelIndex;
                  });
                },
                materialGapSize: MediaQuery.of(context).size.width * 0.05,
                children:
                    _controller.asMap().entries.map((entry) {
                      int index = entry.key;
                      var item = entry.value;
                      return ExpansionPanel(
                        backgroundColor: const Color(0xff2F2F2F),
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return MyExpansionPanelHeader(
                            title:
                                item["title"].controller.text.isEmpty
                                    ? item["title"].hint
                                    : item["title"].controller.text,
                          );
                        },
                        body: Column(
                          children: [
                            TextFields(
                              hinttext: item['title'].hint,
                              controller: item['title'].controller,
                              whatIsInput: '0',
                            ),
                            ...item['pairs']
                                .map(
                                  (p) => Row(
                                    children: [
                                      Expanded(
                                        child: TextFields(
                                          hinttext: p.key.hint,
                                          whatIsInput: p.key.type,
                                          controller: p.key.controller,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        // child: DateSelector(
                                        //   hintText: p.value.hint,
                                        //   controller: p.value.controller,
                                        //   icon: Icons.calendar_today,
                                        //   firstDate: DateTime(2000),
                                        //   lastDate: DateTime(2100),
                                        //   initialDate: DateTime.now(),
                                        // ),
                                        child: TextFields(
                                          hinttext: p.value.hint,
                                          whatIsInput: p.value.type,
                                          controller: p.value.controller,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => _addNewPair(entry.key),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                "Add Pair",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        isExpanded: _expandedIndex == index,
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _addNewHabit();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Add new Habit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          // Log all the input values
                          _logFormValues();

                          // Then navigate or perform any save operations here
                          // Navigator.pop(context);
                        } catch (e) {
                          print("Error saving habit: $e");
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Error: $e")));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Save and Next",
                        style: TextStyle(color: Colors.white),
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
