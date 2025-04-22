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
import 'package:flutter_application_1/services/streak.helper.dart';
import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class ProductivityHabitForm extends StatefulWidget {
  final FormInput? title;
  final FormInput? frequency;
  final FormInput? time;
  final FormInput? description;
  final int? productivity_id;
  const ProductivityHabitForm({
    super.key,
    this.description,
    this.frequency,
    this.time,
    this.title,
    this.productivity_id,
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

  // Sets to store the suggestions.
  Set<String> titlesSet = {};
  Set<String> frequencySet = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProductivityHabits();
  }

  Future<void> _fetchProductivityHabits() async {
    if (widget.productivity_id != null) {
      try {
        // Fetch the productivity habit names (and their habit lists) only once.
        final habits = await ProductivityHabitRepository()
            .getProductivityHabitsNames(widget.productivity_id!);
        setState(() {
          titlesSet = habits.map((e) => e.title).toSet();
          // For frequency suggestions, aggregate titles from each habit's habitList.
          for (var habit in habits) {
            if (habit.habitList != null) {
              frequencySet.addAll(habit.habitList!.map((hl) => hl.title));
            }
          }
          isLoading = false;
        });
      } catch (e) {
        print("Error fetching habits: $e");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Adds a new habit entry.
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
      // Expand the newly added item.
      _expandedIndex = _controller.length - 1;
    });
  }

  /// Adds a new pair entry inside an existing habit.
  void _addNewPair(int index) {
    setState(() {
      _controller[index]["pairs"].add(
        FormInputPair(
          key: FormInput(
            label: "New Frequency",
            hint: "Frequency",
            type: "0",
            controller: TextEditingController(),
          ),
          value: FormInput(
            label: "New Time",
            hint: "Time",
            type: "0",
            controller: TextEditingController(),
          ),
        ),
      );
    });
  }

  /// Called when a title suggestion is selected.
  void onTitleSelect(String value) {
    print("Title Selected: $value");
    setState(() {
      // Remove the selected title from the set.
      titlesSet.remove(value);
    });
  }

  /// Called when a frequency suggestion is selected.
  void onFrequencySelect(String value) {
    print("Frequency Selected: $value");
    setState(() {
      frequencySet.remove(value);
    });
  }

  /// Logs all the field values and saves the data.
  void _logFormValues() async {
    print("Logging all form values:");
    print(widget.title?.controller.text);
    print(widget.frequency?.controller.text);
    print(widget.time?.controller.text);
    print(widget.description?.controller.text);

    if (widget.productivity_id == null) {
      Productivity productivity = await ProductivityRepository()
          .createProductivity({
            'title': widget.title?.controller.text,
            'frequency': widget.frequency?.controller.text,
            'time': widget.time?.controller.text,
            'description': widget.description?.controller.text,
            'user_id': 1,
          });

      print(productivity.id);

      for (var habit in _controller) {
        String title = habit["title"].controller.text;
        var productivityHabit = await ProductivityHabitRepository()
            .createProductivityHabit({
              'title': title,
              'productivity_id': productivity.id,
            });
        print("Habit Title: $title");

        // for (var pair in habit["pairs"]) {
        //   String keyText = pair.key.controller.text;
        //   String valueText = pair.value.controller.text;
        //   print("   Pair -> Frequency: $keyText, Time: $valueText");
        //   await HabitListRepository().createHabitList({
        //     'title': keyText,
        //     'time': valueText,
        //     'productivity_habit_id': productivityHabit.id,
        //   });
        // }
        for (var pair in habit["pairs"]) {
          String frequencyValue = pair.key.controller.text;
          String timeValue = pair.value.controller.text;

          // Create the habit list record.
          final habitListRecord = await HabitListRepository().createHabitList({
            'title': frequencyValue,
            'time': timeValue,
            'productivity_habit_id': productivityHabit.id,
          });

          // Parse the habit date. You can adjust this logic if the date comes from input.
          DateTime habitDate = DateTime.now();

          // Use the frequency from either the habit or the productivity (if provided).
          // await updateOrCreateStreak(
          //   productivityHabitId: productivityHabit.id,
          //   habitDate: habitDate,
          //   frequency: widget.frequency?.controller.text ?? "daily",
          //   habitEntryId: habitListRecord.id,
          // );
        }
      }
    } else {
      for (var habit in _controller) {
        String title = habit["title"].controller.text;
        var productivityHabit = await ProductivityHabitRepository()
            .createProductivityHabit({
              'title': title,
              'productivity_id': widget.productivity_id,
            });
        print("Habit Title: $title");

        for (var pair in habit["pairs"]) {
          String frequencyValue = pair.key.controller.text;
          String timeValue = pair.value.controller.text;

          // Create the habit list record.
          final habitListRecord = await HabitListRepository().createHabitList({
            'title': frequencyValue,
            'time': timeValue,
            'productivity_habit_id': productivityHabit.id,
          });

          DateTime habitDate = DateTime.now();
          // await updateOrCreateStreak(
          //   productivityHabitId: productivityHabit.id,
          //   habitDate: habitDate,
          //   frequency: widget.frequency?.controller.text ?? "daily",
          //   habitEntryId: habitListRecord.id,
          // );
        }
      }
    }

    // } else {
    //   for (var habit in _controller) {
    //     String title = habit["title"].controller.text;
    //     var productivityHabit = await ProductivityHabitRepository()
    //         .createProductivityHabit({
    //           'title': title,
    //           'productivity_id': widget.productivity_id,
    //         });
    //     print("Habit Title: $title");

    //     for (var pair in habit["pairs"]) {
    //       String keyText = pair.key.controller.text;
    //       String valueText = pair.value.controller.text;
    //       print("   Pair -> Frequency: $keyText, Time: $valueText");
    //       await HabitListRepository().createHabitList({
    //         'title': keyText,
    //         'time': valueText,
    //         'productivity_habit_id': productivityHabit.id,
    //       });
    //     }
    //   }
    // }

    // Pop until we reach the productivity-home route.
    Navigator.popUntil(context, ModalRoute.withName('/productivity-home'));
  }

  @override
  Widget build(BuildContext context) {
    print("======================================");
    print(widget.productivity_id);
    print("======================================");

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
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
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
                        materialGapSize:
                            MediaQuery.of(context).size.width * 0.05,
                        children:
                            _controller.asMap().entries.map((entry) {
                              int index = entry.key;
                              var item = entry.value;
                              return ExpansionPanel(
                                backgroundColor: const Color(0xff2F2F2F),
                                canTapOnHeader: true,
                                headerBuilder: (context, isExpanded) {
                                  return MyExpansionPanelHeader(
                                    title:
                                        item["title"].controller.text.isEmpty
                                            ? item["title"].hint
                                            : item["title"].controller.text,
                                  );
                                },
                                body: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    // For the title field: if a productivity exists, use autocomplete.
                                    widget.productivity_id == null
                                        ? Padding(
                                          padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                          ),
                                          child: TextFields(
                                            hinttext: item['title'].hint,
                                            controller:
                                                item['title'].controller,
                                            whatIsInput: '0',
                                          ),
                                        )
                                        : Padding(
                                          padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                          ),
                                          child: AutoCompleteText(
                                            onSelect: onTitleSelect,
                                            suggestions: titlesSet.toList(),
                                            suggestionBuilder: (String text) {
                                              return ListTile(
                                                title: Text(
                                                  text,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                subtitle: const Text(
                                                  "Tap to select",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              );
                                            },
                                            hintText: "Enter your title",
                                            controller:
                                                item['title'].controller,
                                            icon: Icons.search,
                                          ),
                                        ),
                                    // Now for each pair (Frequency and Time)
                                    ...item['pairs']
                                        .map(
                                          (p) => Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.02,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      widget.productivity_id ==
                                                              null
                                                          ? TextFields(
                                                            hinttext:
                                                                p.key.hint,
                                                            whatIsInput:
                                                                p.key.type,
                                                            controller:
                                                                p
                                                                    .key
                                                                    .controller,
                                                          )
                                                          : AutoCompleteText(
                                                            onSelect:
                                                                onFrequencySelect,
                                                            suggestions:
                                                                frequencySet
                                                                    .toList(),
                                                            suggestionBuilder: (
                                                              String text,
                                                            ) {
                                                              return ListTile(
                                                                title: Text(
                                                                  text,
                                                                  style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                ),
                                                                subtitle: const Text(
                                                                  "Tap to select",
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        Colors
                                                                            .grey,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            hintText:
                                                                p.key.hint,
                                                            controller:
                                                                p
                                                                    .key
                                                                    .controller,
                                                            icon: Icons.search,
                                                          ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextFields(
                                                    hinttext: p.value.hint,
                                                    whatIsInput: p.value.type,
                                                    controller:
                                                        p.value.controller,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    const SizedBox(height: 10),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ), // adjust padding as needed
                                        child: ElevatedButton(
                                          onPressed:
                                              () => _addNewPair(entry.key),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                          ),
                                          child: const Text(
                                            "Add Pair",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
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
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: _addNewHabit,
                              style: ElevatedButton.styleFrom(
                                // backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
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
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  _logFormValues();
                                } catch (e) {
                                  print("Error saving habit: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: $e")),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff009966),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                "Save",
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
