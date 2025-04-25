import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/habit-list.dart';
import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
import 'package:flutter_application_1/repositories/habit-list.repositoty.dart';
import 'package:flutter_application_1/repositories/productivity-habit.repository.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class EditProductivityHabitForm extends StatefulWidget {
  /// The habit to edit, including its existing habitList entries.
  final ProductivityHabit habit;

  const EditProductivityHabitForm({Key? key, required this.habit})
    : super(key: key);

  @override
  _EditProductivityHabitFormState createState() =>
      _EditProductivityHabitFormState();
}

class _EditProductivityHabitFormState extends State<EditProductivityHabitForm> {
  // Each entry in _entries is a pair: { "id": int?, "title": controller, "time": controller }
  late List<Map<String, dynamic>> _entries;
  int _expandedIndex = -1;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Build controllers from existing habit.habitList
    _entries =
        widget.habit.habitList
            ?.map(
              (hl) => {
                "id": hl.id,
                "title": TextEditingController(text: hl.title),
                "time": TextEditingController(text: hl.time),
              },
            )
            .toList() ??
        [];

    // If no existing entries, add one empty row
    if (_entries.isEmpty) _addEmptyEntry();
  }

  void _addEmptyEntry() {
    setState(() {
      _entries.add({
        "id": null,
        "title": TextEditingController(),
        "time": TextEditingController(),
      });
      _expandedIndex = _entries.length - 1;
    });
  }

  Future<void> _saveChanges() async {
    setState(() => _saving = true);

    //  Update the habit title itself if you have one (omitted here)

    // For each entry: either update or create
    for (var entry in _entries) {
      final String title = entry["title"].text;
      final String time = entry["time"].text;
      final int? id = entry["id"];

      if (id != null) {
        // existing: update
        await HabitListRepository().updateHabitList(id, {
          'title': title,
          'time': time,
        });
      } else {
        // new: create
        await HabitListRepository().createHabitList({
          'title': title,
          'time': time,
          'productivity_habit_id': widget.habit.id,
        });
      }
    }

    //  Optionally delete any removed entries (not shown here)

    setState(() => _saving = false);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    print("kkkkkkkkkkkkkkkkkkkk");
    print(widget.habit);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Habit"),
        backgroundColor: const Color(0xff2F2F2F),
        leading: BackButton(color: Colors.white),
      ),
      body:
          _saving
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      panelIndex == _expandedIndex
                          ? _expandedIndex = -1
                          : _expandedIndex = panelIndex;
                    });
                  },
                  children:
                      _entries.asMap().entries.map((e) {
                        final idx = e.key;
                        final ctrls = e.value;
                        return ExpansionPanel(
                          headerBuilder:
                              (_, __) => MyExpansionPanelHeader(
                                title:
                                    ctrls["title"].text.isEmpty
                                        ? "New Frequency/Time"
                                        : ctrls["title"].text,
                              ),
                          body: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                TextFields(
                                  hinttext: "Frequency",
                                  whatIsInput: "0",
                                  controller: ctrls["title"],
                                ),
                                const SizedBox(height: 8),
                                TextFields(
                                  hinttext: "Time",
                                  whatIsInput: "0",
                                  controller: ctrls["time"],
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _entries.removeAt(idx);
                                        if (_expandedIndex == idx)
                                          _expandedIndex = -1;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isExpanded: _expandedIndex == idx,
                          canTapOnHeader: true,
                        );
                      }).toList(),
                ),
              ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "addPair",
            child: const Icon(Icons.add),
            onPressed: _addEmptyEntry,
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: "save",
            label: const Text("Save Changes"),
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/entities/habit-list.dart';
// import 'package:flutter_application_1/entities/productivity-habit-entity.dart';
// import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
// import 'package:flutter_application_1/pages/goal/common/types.dart';
// import 'package:flutter_application_1/repositories/productivity-habit.repository.dart';
// import 'package:flutter_application_1/ui/inputs/autocompletetext.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';
// import 'package:flutter_application_1/repositories/habit-list.repositoty.dart';

// class EditProductivityHabitForm extends StatefulWidget {
//   final ProductivityHabit habit;

//   const EditProductivityHabitForm({Key? key, required this.habit})
//     : super(key: key);

//   @override
//   _EditProductivityHabitFormState createState() =>
//       _EditProductivityHabitFormState();
// }

// class _EditProductivityHabitFormState extends State<EditProductivityHabitForm> {
//   int _expandedIndex = -1;
//   bool isLoading = false;

//   // mirror the Add form's _controller structure
//   late List<Map<String, dynamic>> _controller;
//   Set<String> titlesSet = {};
//   Set<String> frequencySet = {};

//   @override
//   void initState() {
//     super.initState();

//     // Build initial _controller from existing habit + its habitList
//     _controller = [
//       {
//         "title": FormInput(
//           label: "Title",
//           hint: "Enter your title",
//           type: "1",
//           controller: TextEditingController(text: widget.habit.title),
//         ),
//         "pairs":
//             widget.habit.habitList
//                 ?.map(
//                   (hl) => FormInputPair(
//                     key: FormInput(
//                       label: "Frequency",
//                       hint: "Frequency",
//                       type: "0",
//                       controller: TextEditingController(text: hl.title),
//                     ),
//                     value: FormInput(
//                       label: "Time",
//                       hint: "Time",
//                       type: "0",
//                       controller: TextEditingController(text: hl.time),
//                     ),
//                   ),
//                 )
//                 .toList() ??
//             [
//               FormInputPair(
//                 key: FormInput(
//                   label: "Frequency",
//                   hint: "Frequency",
//                   type: "0",
//                   controller: TextEditingController(),
//                 ),
//                 value: FormInput(
//                   label: "Time",
//                   hint: "Time",
//                   type: "0",
//                   controller: TextEditingController(),
//                 ),
//               ),
//             ],
//       },
//     ];

//     // Prepare suggestions sets from existing entries
//     for (var pair in (_controller.first["pairs"] as List<FormInputPair>)) {
//       if (pair.key.controller.text.isNotEmpty) {
//         frequencySet.add(pair.key.controller.text);
//       }
//     }
//     titlesSet.add(widget.habit.title);

//     // no fetch needed since we're editing an existing habit
//   }

//   /// Adds a new habit entry (one block with title + one pair)
//   void _addNewHabit() {
//     setState(() {
//       _controller.add({
//         "title": FormInput(
//           label: "Title",
//           hint: "Enter your title",
//           type: "1",
//           controller: TextEditingController(),
//         ),
//         "pairs": [
//           FormInputPair(
//             key: FormInput(
//               label: "Frequency",
//               hint: "Frequency",
//               type: "0",
//               controller: TextEditingController(),
//             ),
//             value: FormInput(
//               label: "Time",
//               hint: "Time",
//               type: "0",
//               controller: TextEditingController(),
//             ),
//           ),
//         ],
//       });
//       _expandedIndex = _controller.length - 1;
//     });
//   }

//   /// Adds a new frequency/time pair inside existing habit block
//   void _addNewPair(int index) {
//     setState(() {
//       (_controller[index]["pairs"] as List<FormInputPair>).add(
//         FormInputPair(
//           key: FormInput(
//             label: "Frequency",
//             hint: "Frequency",
//             type: "0",
//             controller: TextEditingController(),
//           ),
//           value: FormInput(
//             label: "Time",
//             hint: "Time",
//             type: "0",
//             controller: TextEditingController(),
//           ),
//         ),
//       );
//       _expandedIndex = index;
//     });
//   }

//   void onTitleSelect(String v) => setState(() => titlesSet.remove(v));
//   void onFrequencySelect(String v) => setState(() => frequencySet.remove(v));

//   Future<void> _saveChanges() async {
//     setState(() => isLoading = true);

//     // 1️⃣ Update the habit title itself
//     await ProductivityHabitRepository().updateProductivityHabit(
//       widget.habit.id,
//       {'title': _controller.first["title"].controller.text},
//     );

//     // 2️⃣ For each pair: update or create
//     for (var pair in (_controller.first["pairs"] as List<FormInputPair>)) {
//       final titleText = pair.key.controller.text;
//       final timeText = pair.value.controller.text;

//       // find existing HabitList by matching on id if you stored it;
//       // here we assume you have habit.habitList with ids aligned:
//       final existing = widget.habit.habitList?.firstWhere(
//         (hl) => hl.title == titleText && hl.time == timeText,
//         orElse:
//             () => HabitList(
//               id: null,
//               title: titleText,
//               time: timeText,
//               productivityHabitId: widget.habit.id,
//             ),
//       );

//       if (existing != null && existing.id != null) {
//         await HabitListRepository().updateHabitList(existing.id!, {
//           'title': titleText,
//           'time': timeText,
//         });
//       } else {
//         await HabitListRepository().createHabitList({
//           'title': titleText,
//           'time': timeText,
//           'productivity_habit_id': widget.habit.id,
//         });
//       }
//     }

//     setState(() => isLoading = false);
//     Navigator.pop(context, true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Productivity Habit"),
//         backgroundColor: const Color(0xff2F2F2F),
//         leading: BackButton(color: Colors.white),
//         centerTitle: true,
//       ),
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: SingleChildScrollView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ExpansionPanelList(
//                         expansionCallback:
//                             (i, open) => setState(() {
//                               _expandedIndex = open ? -1 : i;
//                             }),
//                         materialGapSize:
//                             MediaQuery.of(context).size.width * .05,
//                         children:
//                             _controller.asMap().entries.map((entry) {
//                               final idx = entry.key;
//                               final block = entry.value;
//                               return ExpansionPanel(
//                                 backgroundColor: const Color(0xff2F2F2F),
//                                 canTapOnHeader: true,
//                                 headerBuilder:
//                                     (_, __) => MyExpansionPanelHeader(
//                                       title:
//                                           block["title"].controller.text.isEmpty
//                                               ? block["title"].hint
//                                               : block["title"].controller.text,
//                                     ),
//                                 body: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Title field
//                                     Padding(
//                                       padding: EdgeInsets.all(
//                                         MediaQuery.of(context).size.width * .02,
//                                       ),
//                                       child: AutoCompleteText(
//                                         onSelect: onTitleSelect,
//                                         suggestions: titlesSet.toList(),
//                                         suggestionBuilder:
//                                             (t) => ListTile(
//                                               title: Text(
//                                                 t,
//                                                 style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               subtitle: const Text(
//                                                 "Tap to select",
//                                                 style: TextStyle(
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             ),
//                                         hintText: block["title"].hint,
//                                         controller: block["title"].controller,
//                                         icon: Icons.search,
//                                       ),
//                                     ),

//                                     const SizedBox(height: 12),

//                                     // Frequency / Time pairs
//                                     ...(block["pairs"] as List<FormInputPair>)
//                                         .map((pair) {
//                                           return Padding(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal:
//                                                   MediaQuery.of(
//                                                     context,
//                                                   ).size.width *
//                                                   .02,
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 Expanded(
//                                                   flex: 2,
//                                                   child: AutoCompleteText(
//                                                     onSelect: onFrequencySelect,
//                                                     suggestions:
//                                                         frequencySet.toList(),
//                                                     suggestionBuilder:
//                                                         (t) => ListTile(
//                                                           title: Text(
//                                                             t,
//                                                             style:
//                                                                 const TextStyle(
//                                                                   color:
//                                                                       Colors
//                                                                           .white,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 ),
//                                                           ),
//                                                           subtitle: const Text(
//                                                             "Tap to select",
//                                                             style: TextStyle(
//                                                               color:
//                                                                   Colors.grey,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                     hintText: pair.key.hint,
//                                                     controller:
//                                                         pair.key.controller,
//                                                     icon: Icons.search,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(width: 10),
//                                                 Expanded(
//                                                   flex: 1,
//                                                   child: TextFields(
//                                                     hinttext: pair.value.hint,
//                                                     whatIsInput:
//                                                         pair.value.type,
//                                                     controller:
//                                                         pair.value.controller,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         })
//                                         .toList(),

//                                     const SizedBox(height: 10),

//                                     // Add Pair button
//                                     Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 16,
//                                         ),
//                                         child: ElevatedButton(
//                                           onPressed: () => _addNewPair(idx),
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.blue,
//                                           ),
//                                           child: const Text(
//                                             "Add Pair",
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 20),
//                                   ],
//                                 ),
//                                 isExpanded: _expandedIndex == idx,
//                               );
//                             }).toList(),
//                       ),

//                       const SizedBox(height: 20),

//                       // Bottom buttons
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: ElevatedButton(
//                               onPressed: _addNewHabit,
//                               style: ElevatedButton.styleFrom(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 15,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "Add new Habit",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             flex: 3,
//                             child: ElevatedButton(
//                               onPressed: _saveChanges,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xff009966),
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 15,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "Save Changes",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//     );
//   }
// }
