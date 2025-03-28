// import 'package:accordion/accordion.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/ui/inputs/mutitext.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';

// class AccordionAxample extends StatefulWidget {
//   const AccordionAxample({super.key});

//   @override
//   State<AccordionAxample> createState() => _AccordionAxampleState();
// }

// class _AccordionAxampleState extends State<AccordionAxample> {
//   final TextEditingController _goal = TextEditingController();
//   static const headerStyle = TextStyle(
//     color: Color(0xffffffff),
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   );
//   static const contentStyle = TextStyle(
//     color: Color(0xff999999),
//     fontSize: 14,
//     fontWeight: FontWeight.normal,
//   );
//   static const loremIpsum =
//       '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Accordion(
//             headerBorderColor: Color(0xff959595),
//             contentBorderColor: Color(0xff959595),

//             headerBackgroundColor: Color(0xff2F2F2F),
//             headerPadding: EdgeInsets.all(8.0),
//             children: [
//               AccordionSection(
//                 contentBorderColor: Color(0xff959595),
//                 isOpen: true,
//                 leftIcon: const Icon(
//                   Icons.ads_click_rounded,
//                   color: Colors.white,
//                 ),
//                 header: const Text('Goal Information', style: headerStyle),
//                 contentVerticalPadding: 20,
//                 content: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Goal Name',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),

//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Terms of Goal',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Goal Priority',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),

//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Goal Status',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     MultiLineTextField(
//                       hintText: 'description',
//                       controller: _goal,
//                       icon: Icons.description,
//                     ),
//                   ],
//                 ),
//                 contentBackgroundColor: Color(0xff2F2F2F),
//               ),
//               AccordionSection(
//                 contentBorderColor: Color(0xff959595),
//                 isOpen: true,
//                 leftIcon: const Icon(
//                   Icons.ads_click_rounded,
//                   color: Colors.white,
//                 ),
//                 header: const Text('Motivation', style: headerStyle),
//                 contentVerticalPadding: 20,
//                 contentBackgroundColor: Color(0xff2F2F2F),

//                 content: Column(
//                   children: [
//                     TextFields(
//                       hinttext: 'Why is this goal important to you ',
//                       whatIsInput: '1',
//                       controller: _goal,
//                     ),

//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.019,
//                     ),

//                     TextFields(
//                       hinttext: 'What will happen after u achieve this goal',
//                       whatIsInput: '1',
//                       controller: _goal,
//                     ),

//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.019,
//                     ),

//                     TextFields(
//                       hinttext: 'How Would u feel if u dont Achieve this goal',
//                       whatIsInput: '1',
//                       controller: _goal,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyInputForm
//     extends
//         StatelessWidget //__
//         {
//   const MyInputForm({super.key});

//   @override
//   Widget build(context) //__
//   {
//     return Column(
//       children: [
//         TextFormField(
//           decoration: InputDecoration(
//             label: const Text('Some text goes here ...'),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//         ElevatedButton(onPressed: () {}, child: const Text('Submit')),
//       ],
//     );
//   }
// }

// import 'package:accordion/accordion.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/ui/inputs/dateselector.dart';
// import 'package:flutter_application_1/ui/inputs/mutitext.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';

// class AccordionAxample extends StatefulWidget {
//   const AccordionAxample({super.key});

//   @override
//   State<AccordionAxample> createState() => _AccordionAxampleState();
// }

// class _AccordionAxampleState extends State<AccordionAxample> {
//   final TextEditingController _goal = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();

//   // List to store controllers for all motivation inputs.
//   // The first three are for the static inputs.
//   final List<TextEditingController> motivationControllers = [
//     TextEditingController(), // "Why is this goal important to you"
//     TextEditingController(), // "What will happen after you achieve this goal"
//     TextEditingController(), // "How would you feel if you don’t achieve this goal"
//   ];

//   static const headerStyle = TextStyle(
//     color: Color(0xffffffff),
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   );

//   @override
//   void dispose() {
//     _goal.dispose();
//     for (var controller in motivationControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Accordion(
//             headerBorderColor: const Color(0xff959595),
//             contentBorderColor: const Color(0xff959595),
//             headerBackgroundColor: const Color(0xff2F2F2F),
//             headerPadding: const EdgeInsets.all(8.0),
//             children: [
//               // Goal Information section remains the same.
//               AccordionSection(
//                 contentBorderColor: const Color(0xff959595),
//                 isOpen: true,
//                 leftIcon: const Icon(Icons.star_rounded, color: Colors.white),
//                 header: const Text('Goal Information', style: headerStyle),
//                 contentVerticalPadding: 20,
//                 contentBackgroundColor: const Color(0xff2F2F2F),
//                 content: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Goal Name',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Terms of Goal',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Goal Priority',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Goal Status',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     MultiLineTextField(
//                       hintText: 'description',
//                       controller: _goal,
//                       icon: Icons.description,
//                     ),
//                   ],
//                 ),
//               ),
//               // Motivation section now uses the motivationControllers list
//               AccordionSection(
//                 contentBorderColor: const Color(0xff959595),
//                 isOpen: true,
//                 leftIcon: const Icon(
//                   Icons.ads_click_rounded,
//                   color: Colors.white,
//                 ),
//                 header: const Text('Motivation', style: headerStyle),
//                 contentVerticalPadding: 20,
//                 contentBackgroundColor: const Color(0xff2F2F2F),
//                 content: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Three static motivation inputs using the first three controllers
//                     TextFields(
//                       hinttext: 'Why is this goal important to you',
//                       whatIsInput: '1',
//                       controller: motivationControllers[0],
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.019,
//                     ),
//                     TextFields(
//                       hinttext: 'What will happen after you achieve this goal',
//                       whatIsInput: '1',
//                       controller: motivationControllers[1],
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.019,
//                     ),
//                     TextFields(
//                       hinttext:
//                           'How would you feel if you don’t achieve this goal',
//                       whatIsInput: '1',
//                       controller: motivationControllers[2],
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.019,
//                     ),
//                     // Additional dynamic motivation inputs (if any)
//                     ...motivationControllers.sublist(3).asMap().entries.map((
//                       entry,
//                     ) {
//                       int index = entry.key;
//                       TextEditingController controller = entry.value;
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: TextFields(
//                           hinttext: 'Additional Motivation ${index + 1}',
//                           whatIsInput: '1',
//                           controller: controller,
//                         ),
//                       );
//                     }).toList(),
//                     // "Add Motivation" button
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             motivationControllers.add(TextEditingController());
//                           });
//                         },
//                         child: const Text('Add Motivation'),
//                       ),
//                     ),
//                     // "Print Motivations" button that prints all motivation inputs
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           for (
//                             int i = 0;
//                             i < motivationControllers.length;
//                             i++
//                           ) {
//                             print(
//                               "Motivation ${i + 1}: ${motivationControllers[i].text}",
//                             );
//                           }
//                         },
//                         child: const Text('Print Motivations'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               AccordionSection(
//                 contentBorderColor: const Color(0xff959595),
//                 isOpen: true,
//                 leftIcon: const Icon(
//                   Icons.ads_click_rounded,
//                   color: Colors.white,
//                 ),
//                 header: const Text(
//                   'Sub Goals and deadline',
//                   style: headerStyle,
//                 ),
//                 contentVerticalPadding: 20,
//                 contentBackgroundColor: const Color(0xff2F2F2F),
//                 content: Column(
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.019,
//                     ),
//                     DateSelector(
//                       hintText: "Dead Line Of this current Vision Board",
//                       controller: _dateController,
//                       icon: Icons.calendar_today,
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                       initialDate: DateTime.now(),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: TextFields(
//                             hinttext: 'Sub goal name',
//                             whatIsInput: '1',
//                             controller: _goal,
//                           ),
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           child: DateSelector(
//                             hintText: "Subgoal Deadline",
//                             controller: _dateController,
//                             icon: Icons.calendar_today,
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2100),
//                             initialDate: DateTime.now(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:accordion/accordion.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/ui/inputs/dateselector.dart';
// import 'package:flutter_application_1/ui/inputs/mutitext.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';

// class SubGoalData {
//   final TextEditingController goalController;
//   final TextEditingController deadlineController;

//   SubGoalData({required this.goalController, required this.deadlineController});
// }

// class IncomeData {
//   final TextEditingController sourceController;
//   final TextEditingController amountController;
//   IncomeData({required this.amountController, required this.sourceController});
// }

// class AccordionAxample extends StatefulWidget {
//   const AccordionAxample({super.key});

//   @override
//   State<AccordionAxample> createState() => _AccordionAxampleState();
// }

// class _AccordionAxampleState extends State<AccordionAxample> {
//   final List<TextEditingController> motivationControllers = [
//     TextEditingController(),
//     TextEditingController(),
//     TextEditingController(),
//   ];

//   final List<SubGoalData> subGoals = [
//     SubGoalData(
//       goalController: TextEditingController(),
//       deadlineController: TextEditingController(),
//     ),
//   ];

//   final List<IncomeData> income = [
//     IncomeData(
//       amountController: TextEditingController(),
//       sourceController: TextEditingController(),
//     ),
//   ];

//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _totalMoney = TextEditingController();
//   final TextEditingController _amountSaved = TextEditingController();
//   final TextEditingController _timeSaved = TextEditingController();

//   // 1st

//   final TextEditingController _goalName = TextEditingController();
//   final TextEditingController _goalPriority = TextEditingController();
//   final TextEditingController _goalTerm = TextEditingController();
//   final TextEditingController _goalStatus = TextEditingController();
//   final TextEditingController _goalDescription = TextEditingController();

//   // 2nd

//   static const headerStyle = TextStyle(
//     color: Color(0xffffffff),
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   );

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {},
//               child: const Text("Save", style: TextStyle(color: Colors.white)),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.045,
//         ),
//         child: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               Accordion(
//                 headerBorderColor: const Color(0xff959595),
//                 contentBorderColor: const Color(0xff959595),
//                 headerBackgroundColor: const Color(0xff2F2F2F),
//                 headerPadding: const EdgeInsets.all(8.0),

//                 children: [
//                   // Goal Information Section (remains unchanged)
//                   AccordionSection(
//                     contentBorderColor: const Color(0xff959595),
//                     isOpen: true,
//                     leftIcon: const Icon(
//                       Icons.star_rounded,
//                       color: Colors.white,
//                     ),
//                     header: const Text('Goal Information', style: headerStyle),
//                     contentVerticalPadding: 20,
//                     contentBackgroundColor: const Color(0xff2F2F2F),
//                     content: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.40,
//                               child: TextFields(
//                                 hinttext: 'Goal Name',
//                                 whatIsInput: '1',
//                                 controller: _goalName,
//                               ),
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.40,
//                               child: TextFields(
//                                 hinttext: 'Terms of Goal',
//                                 whatIsInput: '1',
//                                 controller: _goalTerm,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.40,
//                               child: TextFields(
//                                 hinttext: 'Goal Priority',
//                                 whatIsInput: '1',
//                                 controller: _goalPriority,
//                               ),
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.40,
//                               child: TextFields(
//                                 hinttext: 'Goal Status',
//                                 whatIsInput: '1',
//                                 controller: _goalStatus,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),
//                         MultiLineTextField(
//                           hintText: 'description',
//                           controller: _goalDescription,
//                           icon: Icons.description,
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Motivation Section (remains unchanged)
//                   AccordionSection(
//                     contentBorderColor: const Color(0xff959595),

//                     isOpen: true,
//                     leftIcon: const Icon(
//                       Icons.ads_click_rounded,
//                       color: Colors.white,
//                     ),
//                     header: const Text('Motivation', style: headerStyle),
//                     contentVerticalPadding: 20,
//                     contentBackgroundColor: const Color(0xff2F2F2F),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextFields(
//                           hinttext: 'Why is this goal important to you',
//                           whatIsInput: '1',
//                           controller: motivationControllers[0],
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.019,
//                         ),
//                         TextFields(
//                           hinttext:
//                               'What will happen after you achieve this goal',
//                           whatIsInput: '1',
//                           controller: motivationControllers[1],
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.019,
//                         ),
//                         TextFields(
//                           hinttext:
//                               'How would you feel if you don’t achieve this goal',
//                           whatIsInput: '1',
//                           controller: motivationControllers[2],
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.019,
//                         ),
//                         ...motivationControllers.sublist(3).asMap().entries.map(
//                           (entry) {
//                             int index = entry.key;
//                             TextEditingController controller = entry.value;
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 8.0,
//                               ),
//                               child: TextFields(
//                                 hinttext: 'Additional Motivation ${index + 1}',
//                                 whatIsInput: '1',
//                                 controller: controller,
//                               ),
//                             );
//                           },
//                         ).toList(),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 motivationControllers.add(
//                                   TextEditingController(),
//                                 );
//                               });
//                             },
//                             child: const Text('Add Motivation'),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               for (
//                                 int i = 0;
//                                 i < motivationControllers.length;
//                                 i++
//                               ) {
//                                 print(
//                                   "Motivation ${i + 1}: ${motivationControllers[i].text}",
//                                 );
//                               }
//                             },
//                             child: const Text('Print Motivations'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Sub Goals and Deadline Section
//                   AccordionSection(
//                     contentBorderColor: const Color(0xff959595),
//                     isOpen: true,
//                     leftIcon: const Icon(
//                       Icons.ads_click_rounded,
//                       color: Colors.white,
//                     ),
//                     header: const Text(
//                       'Sub Goals and Deadline',
//                       style: headerStyle,
//                     ),
//                     contentVerticalPadding: 20,
//                     contentBackgroundColor: const Color(0xff2F2F2F),
//                     content: Column(
//                       children: [
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.019,
//                         ),
//                         DateSelector(
//                           hintText: "Dead Line Of this current Vision Board",
//                           controller: _dateController,
//                           icon: Icons.calendar_today,
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2100),
//                           initialDate: DateTime.now(),
//                         ),
//                         // Display each sub-goal as a row with its name and deadline
//                         ...subGoals.asMap().entries.map((entry) {
//                           int index = entry.key;
//                           SubGoalData subGoal = entry.value;
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.40,
//                                   child: TextFields(
//                                     hinttext: 'Sub goal name',
//                                     whatIsInput: '1',
//                                     controller: subGoal.goalController,
//                                   ),
//                                 ),
//                                 Container(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.40,
//                                   child: DateSelector(
//                                     hintText: "Subgoal Deadline",
//                                     controller: subGoal.deadlineController,
//                                     icon: Icons.calendar_today,
//                                     firstDate: DateTime(2000),
//                                     lastDate: DateTime(2100),
//                                     initialDate: DateTime.now(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),
//                         // "Add Sub Goal" button
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 subGoals.add(
//                                   SubGoalData(
//                                     goalController: TextEditingController(),
//                                     deadlineController: TextEditingController(),
//                                   ),
//                                 );
//                               });
//                             },
//                             child: const Text('Add Sub Goal'),
//                           ),
//                         ),
//                         // "Print Sub Goals" button
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               for (int i = 0; i < subGoals.length; i++) {
//                                 print(
//                                   "Sub Goal ${i + 1}: ${subGoals[i].goalController.text}, Deadline: ${subGoals[i].deadlineController.text}",
//                                 );
//                               }
//                             },
//                             child: const Text('Print Sub Goals'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   AccordionSection(
//                     contentBorderColor: const Color(0xff959595),
//                     isOpen: true,
//                     leftIcon: const Icon(
//                       Icons.monetization_on,
//                       color: Colors.white,
//                     ),
//                     header: const Text(
//                       'Finance and Impact',
//                       style: headerStyle,
//                     ),
//                     contentVerticalPadding: 20,
//                     contentBackgroundColor: const Color(0xff2F2F2F),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.019,
//                         ),

//                         TextFields(
//                           hinttext: "How much will this project ",
//                           whatIsInput: '1',
//                           controller: _totalMoney,
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),

//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "How much do you think you are going to save",
//                             style: TextStyle(
//                               backgroundColor: Colors.black87.withOpacity(.3),
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.019,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.40,
//                               child: TextFields(
//                                 hinttext: 'Amount Saved',
//                                 whatIsInput: '0',
//                                 controller: _amountSaved,
//                               ),
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.40,
//                               child: TextFields(
//                                 hinttext: 'Time Saved',
//                                 whatIsInput: '0',
//                                 controller: _timeSaved,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),

//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Where do you think to get the income",
//                             style: TextStyle(
//                               backgroundColor: Colors.black87.withOpacity(.3),
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.019,
//                         ),

//                         ...income.asMap().entries.map((entry) {
//                           int index = entry.key;
//                           IncomeData subIncome = entry.value;
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.40,
//                                   child: TextFields(
//                                     hinttext: 'Source',
//                                     whatIsInput: '1',
//                                     controller: subIncome.sourceController,
//                                   ),
//                                 ),
//                                 Container(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.40,
//                                   child: TextFields(
//                                     hinttext: 'Amount',
//                                     whatIsInput: '1',
//                                     controller: subIncome.amountController,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),
//                         Align(
//                           alignment: Alignment.center,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 income.add(
//                                   IncomeData(
//                                     sourceController: TextEditingController(),
//                                     amountController: TextEditingController(),
//                                   ),
//                                 );
//                               });
//                             },
//                             child: const Text('Add Source'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/goal/common/form.finance-impact.dart';
import 'package:flutter_application_1/pages/goal/common/form.goal.dart';
import 'package:flutter_application_1/pages/goal/common/form.motivation.dart';
import 'package:flutter_application_1/pages/goal/common/form.subgoals.dart';
import 'package:flutter_application_1/pages/goal/common/goalInformationAccordion.dart';
import 'package:flutter_application_1/pages/goal/common/header.expansion-panel.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubGoalData {
  final TextEditingController goalController;
  final TextEditingController deadlineController;

  SubGoalData({required this.goalController, required this.deadlineController});
}

class IncomeData {
  final TextEditingController sourceController;
  final TextEditingController amountController;
  IncomeData({required this.amountController, required this.sourceController});
}

class AddGoal extends StatefulWidget {
  const AddGoal({super.key});

  @override
  State<AddGoal> createState() => _AccordionAxampleState();
}

class _AccordionAxampleState extends State<AddGoal> {
  // Goal Information Controllers
  final TextEditingController _goalName = TextEditingController();
  final TextEditingController _goalTerm = TextEditingController();
  final TextEditingController _goalPriority = TextEditingController();
  final TextEditingController _goalStatus = TextEditingController();
  final TextEditingController _goalDescription = TextEditingController();

  // Motivation controllers (first three are for static inputs)
  final List<TextEditingController> motivationControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  // Sub Goals list (one exists by default)
  final List<SubGoalData> subGoals = [
    SubGoalData(
      goalController: TextEditingController(),
      deadlineController: TextEditingController(),
    ),
  ];

  // Finance controllers
  final TextEditingController _totalMoney = TextEditingController();
  final TextEditingController _amountSaved = TextEditingController();
  final TextEditingController _timeSaved = TextEditingController();

  // Income list (one exists by default)
  final List<IncomeData> income = [
    IncomeData(
      sourceController: TextEditingController(),
      amountController: TextEditingController(),
    ),
  ];

  final TextEditingController _dateController = TextEditingController();

  static const headerStyle = TextStyle(
    color: Color(0xffffffff),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  void dispose() {
    _goalName.dispose();
    _goalTerm.dispose();
    _goalPriority.dispose();
    _goalStatus.dispose();
    _goalDescription.dispose();
    for (var controller in motivationControllers) {
      controller.dispose();
    }
    for (var subGoal in subGoals) {
      subGoal.goalController.dispose();
      subGoal.deadlineController.dispose();
    }
    _totalMoney.dispose();
    _amountSaved.dispose();
    _timeSaved.dispose();
    for (var inc in income) {
      inc.sourceController.dispose();
      inc.amountController.dispose();
    }
    _dateController.dispose();
    super.dispose();
  }

  void _printAllValues() async {
    // print("----- Goal Information -----");
    // print("Goal Name: ${_goalName.text}");
    // print("Terms of Goal: ${_goalTerm.text}");
    // print("Goal Priority: ${_goalPriority.text}");
    // print("Goal Status: ${_goalStatus.text}");
    // print("Description: ${_goalDescription.text}");
    print("-------- Goals ----------");
    print("Goal Name: ${_controllers["goals"]["name"].controller.text}");
    print("Goal Term: ${_controllers["goals"]["term"].controller.text}");
    print(
      "Goal Priority: ${_controllers["goals"]["priority"].controller.text}",
    );

    print("----- Motivations -----");
    for (int i = 0; i < _controllers["motivations"].length; i++) {
      print(
        "Motivation ${i + 1}: ${_controllers["motivations"][i].controller.text}",
      );
    }

    print("----------- Sub goals | DEADLINE -------------");
    print(
      "Deadline: ${_controllers["subGoalsWithDeadline"]["deadline"].controller.text}",
    );
    for (
      var i = 0;
      i < _controllers["subGoalsWithDeadline"]["subGoals"].length;
      i++
    ) {
      print(
        "Sub Goal ${i + 1}: ${_controllers["subGoalsWithDeadline"]["subGoals"][i].key.controller.text}, Deadline: ${_controllers["subGoalsWithDeadline"]["subGoals"][i].value.controller.text}",
      );
    }

    print("---------------------- FINANCE -----------------");
    print(_controllers["financeImpact"]["totalMoney"].controller.text);
    print(_controllers["financeImpact"]["amountSaved"].controller.text);
    print(_controllers["financeImpact"]["timeSaved"].controller.text);

    for (
      var i = 0;
      i < _controllers["financeImpact"]["incomeSource"].length;
      i++
    ) {
      print(
        "Source ${i + 1}: ${_controllers["financeImpact"]["incomeSource"][i].key.controller.text}",
      );
      print(
        "Source ${i + 1}: ${_controllers["financeImpact"]["incomeSource"][i].value.controller.text}",
      );
    }

    // return;

    // Map<String, dynamic> data = {
    //   ...getMotivationJson(),
    //   ...getSubGoalsJson(),
    //   ...getFinanceJson(),
    // };

    // print(jsonEncode(data));

    try {
      final goalResponse = await Supabase.instance.client.from('goal').insert({
        'name': _controllers["goals"]["name"].controller.text,
        'status': _controllers["goals"]["priority"].controller.text,
        'priority': _controllers["goals"]["priority"].controller.text,
        'description': _controllers["goals"]["description"].controller.text,
        'term': _controllers["goals"]["term"].controller.text,
        'userId': 1,
        'deadline':
            _controllers["subGoalsWithDeadline"]["deadline"].controller.text,
        'motivation': getMotivationJson(),
        'finance': getFinanceJson(),
      });
      final goals = await Datamanager().getGoals();
      final goalIdIndex =
          goals.length - 1; // Fixing index to get the last inserted goal
      final goalId = goals[goalIdIndex].id;

      // Now insert sub-goals
      await insertSubGoals(goalId);

      print(goalResponse);
      print("Goal added successfully!");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Goal added successfully!")));
      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Map<String, dynamic> getMotivationJson() {
    return {
      "motivations":
          _controllers["motivations"]
              .map((motivation) => (motivation as FormInput).controller.text)
              .toList(),
    };
  }

  List<Map<String, dynamic>> getSubGoalsJson() {
    return _controllers["subGoalsWithDeadline"]["subGoals"]
        .map(
          (subGoal) => {
            "goal": (subGoal as FormInputPair).key.controller.text,
            "deadline": formatDate(subGoal.value.controller.text),
          },
        )
        .toList();
  }

  Future<void> insertSubGoals(int goalId) async {
    List<Map<String, dynamic>> subGoalsData = getSubGoalsJson();

    if (subGoalsData.isNotEmpty) {
      await Supabase.instance.client.from('sub_goal').insert(subGoalsData);
    }
  }

  Map<String, dynamic> getFinanceJson() {
    return {
      "finance": {
        "total_money":
            _controllers["financeImpact"]["totalMoney"].controller.text,
        "amount_saved":
            _controllers["financeImpact"]["amountSaved"].controller.text,
        "time_saved":
            _controllers["financeImpact"]["timeSaved"].controller.text,
        "income_sources":
            _controllers["financeImpact"]["incomeSource"]
                .map(
                  (incomeSource) => {
                    "source":
                        (incomeSource as FormInputPair).key.controller.text,
                    "amount": (incomeSource).value.controller.text,
                  },
                )
                .toList(),
      },
    };
  }

  // final ExpansionPanelHeaderBuilder headerBuilder = (context, isExpanded) {
  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     color: const Color(0xff2F2F2F),
  //     child: const Text('Goal Information', style: headerStyle),
  //   );
  // };

  int _expandedIndex = -1;
<<<<<<< HEAD

=======
  final List _expansions = [
    "goals Goals",
    "motivations Motivations",
    "subGoalsWithDeadline SubGoals",
    "financeImpact Finance",
  ];
>>>>>>> fc3dab18e58da96c50ba6b184ed9fa0cb8e61797
  final Map<String, dynamic> _controllers = {
    "goals": {
      "name": FormInput(
        label: "Goal Name",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Goal Name",
      ),
      "term": FormInput(
        label: "Terms of Goal",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Terms of Goal",
      ),
      "priority": FormInput(
        label: "Goal Priority",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Goal Priority",
      ),
      "status": FormInput(
        label: "Goal Status",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Goal Status",
      ),
<<<<<<< HEAD
      "description": FormInput(
        label: "Description",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Description",
      ),
=======
>>>>>>> fc3dab18e58da96c50ba6b184ed9fa0cb8e61797
    },
    "motivations": [
      FormInput(
        label: "Why is this goal important to you",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter why this goal is important to you",
      ),
      FormInput(
        label: "What will happen after you achieve this goal",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter what will happen after you achieve this goal",
      ),
      FormInput(
        label: "How would you feel if you don’t achieve this goal",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter how would you feel if you don’t achieve this goal",
      ),
    ],
    "subGoalsWithDeadline": {
      "deadline": FormInput(
        label: "Deadline Of this current Vision Board",
        controller: TextEditingController(),
        type: "1",
        hint: "Enter Deadline Of this current Vision Board",
      ),
      "subGoals": [
        FormInputPair(
          key: FormInput(
            label: "Sub goal name",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Sub goal name",
          ),
          value: FormInput(
            label: "Subgoal Deadline",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Subgoal Deadline",
          ),
        ),
      ],
    },
    "financeImpact": {
      "totalMoney": FormInput(
        label: "How much will this project",
        controller: TextEditingController(),
        type: "0",
        hint: "Enter how much you think this Goal Will Cost",
      ),
      "amountSaved": FormInput(
        label: "Amount Saved",
        controller: TextEditingController(),
        type: "0",
        hint: "Amount Of Money",
        span: 1.5,
      ),
      "timeSaved": FormInput(
        label: "Time Saved",
        controller: TextEditingController(),
        type: "0",
        hint: "Enter Time Saved",
        span: 1.5,
      ),
      "incomeSource": [
        FormInputPair(
          key: FormInput(
            label: "Source",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Source",
          ),
          value: FormInput(
            label: "Amount",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Amount",
          ),
        ),
      ],
    },
  };

  addMotivation() {
    setState(() {
      _controllers["motivations"].add(
        FormInput(
          label: "Additional Motivation",
          controller: TextEditingController(),
          type: "1",
          hint: "Enter Additional Motivation",
        ),
      );
    });
  }

  addIncomeSource() {
    setState(() {
      _controllers["financeImpact"]["incomeSource"].add(
        FormInputPair(
          key: FormInput(
            label: "Source",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Source",
          ),
          value: FormInput(
            label: "Amount",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Amount",
          ),
        ),
      );
    });
  }

  addSubGoals() {
    setState(() {
      _controllers["subGoalsWithDeadline"]["subGoals"].add(
        FormInputPair(
          key: FormInput(
            label: "Sub goal name",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Sub goal name",
          ),
          value: FormInput(
            label: "Subgoal Deadline",
            controller: TextEditingController(),
            type: "1",
            hint: "Enter Subgoal Deadline",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _printAllValues,
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          // child: Container(
          // child: Container(
          child: ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return MyExpansionPanelHeader(title: "Goal Information");
                },
                body: GoalForm(
                  goalName: _controllers["goals"]["name"] as FormInput,
                  goalTerms: _controllers["goals"]["term"] as FormInput,
                  goalPriority: _controllers["goals"]["priority"] as FormInput,
                  goalStatus: _controllers["goals"]["status"] as FormInput,
<<<<<<< HEAD
                  goalDescription:
                      _controllers["goals"]["description"] as FormInput,
=======
>>>>>>> fc3dab18e58da96c50ba6b184ed9fa0cb8e61797
                ),
                isExpanded: _expandedIndex == 0,
              ),
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return MyExpansionPanelHeader(title: "Motivations");
                },
                body: MotivationForm(
                  motivations: _controllers["motivations"] as List<FormInput>,
                  addMotivations: addMotivation,
                ),
                isExpanded: _expandedIndex == 1,
              ),
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return MyExpansionPanelHeader(title: "SubGoals");
                },
                body: SubGoalsForm(
                  deadline:
                      _controllers["subGoalsWithDeadline"]["deadline"]
                          as FormInput,
                  subGoals:
                      _controllers["subGoalsWithDeadline"]["subGoals"]
                          as List<FormInputPair>,
                  addSubGoal: addSubGoals,
                ),
                isExpanded: _expandedIndex == 2,
              ),
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return MyExpansionPanelHeader(title: "Finance");
                },
                body: FinanceImpactForm(
                  totalMoney:
                      _controllers["financeImpact"]["totalMoney"] as FormInput,
                  amountSaved:
                      _controllers["financeImpact"]["amountSaved"] as FormInput,
                  timeSaved:
                      _controllers["financeImpact"]["timeSaved"] as FormInput,
                  incomeSources:
                      _controllers["financeImpact"]["incomeSource"]
                          as List<FormInputPair>,
                  addIncomeSource: addIncomeSource,
                ),
                isExpanded: _expandedIndex == 3,
              ),
              // ExpansionPanel(
              //   headerBuilder: headerBuilder,
              //   body: Text('hallluuuu'),
              //   isExpanded: _expandedIndex == 0,
              // ),
              // ExpansionPanel(
              //   headerBuilder: headerBuilder,
              //   body: Text('hallluuuu'),
              //   isExpanded: _expandedIndex == 1,
              // ),
              // ExpansionPanel(
              //   headerBuilder: headerBuilder,
              //   body: Text('hallluuuu'),
              //   isExpanded: _expandedIndex == 2,
              // ),
            ],
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                panelIndex == _expandedIndex
                    ? _expandedIndex = -1
                    : _expandedIndex = panelIndex;
              });
            },
          ),
        ),
        // children: [
        // Accordion(
        //   headerBorderColor: const Color(0xff959595),
        //   contentBorderColor: const Color(0xff959595),
        //   headerBackgroundColor: const Color(0xff2F2F2F),
        //   headerPadding: const EdgeInsets.all(8.0),
        //   children: [
        //     // Goal Information Section
        //     AccordionSection(
        //       contentBorderColor: const Color(0xff959595),
        //       isOpen: true,
        //       leftIcon: const Icon(
        //         Icons.star_rounded,
        //         color: Colors.white,
        //       ),
        //       header: const Text('Goal Information', style: headerStyle),
        //       contentVerticalPadding: 20,
        //       contentBackgroundColor: const Color(0xff2F2F2F),
        //       content: GoalInformationAccordion(),
        //       // content:Column(
        //       //   children: [
        //       //     Row(
        //       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       //       children: [
        //       //         Container(
        //       //           width: MediaQuery.of(context).size.width * 0.40,
        //       //           child: TextFields(
        //       //             hinttext: 'Goal Name',
        //       //             whatIsInput: '1',
        //       //             controller: _goalName,
        //       //           ),
        //       //         ),
        //       //         Container(
        //       //           width: MediaQuery.of(context).size.width * 0.40,
        //       //           child: TextFields(
        //       //             hinttext: 'Terms of Goal',
        //       //             whatIsInput: '1',
        //       //             controller: _goalTerm,
        //       //           ),
        //       //         ),
        //       //       ],
        //       //     ),
        //       //     SizedBox(
        //       //       height: MediaQuery.of(context).size.height * 0.02,
        //       //     ),
        //       //     Row(
        //       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       //       children: [
        //       //         Container(
        //       //           width: MediaQuery.of(context).size.width * 0.40,
        //       //           child: TextFields(
        //       //             hinttext: 'Goal Priority',
        //       //             whatIsInput: '1',
        //       //             controller: _goalPriority,
        //       //           ),
        //       //         ),
        //       //         Container(
        //       //           width: MediaQuery.of(context).size.width * 0.40,
        //       //           child: TextFields(
        //       //             hinttext: 'Goal Status',
        //       //             whatIsInput: '1',
        //       //             controller: _goalStatus,
        //       //           ),
        //       //         ),
        //       //       ],
        //       //     ),
        //       //     SizedBox(
        //       //       height: MediaQuery.of(context).size.height * 0.02,
        //       //     ),
        //       //     MultiLineTextField(
        //       //       hintText: 'description',
        //       //       controller: _goalDescription,
        //       //       icon: Icons.description,
        //       //     ),
        //       //   ],
        //       // ),
        //     ),
        //     // Motivation Section
        //     AccordionSection(
        //       contentBorderColor: const Color(0xff959595),
        //       isOpen: true,
        //       leftIcon: const Icon(
        //         Icons.ads_click_rounded,
        //         color: Colors.white,
        //       ),
        //       header: const Text('Motivation', style: headerStyle),
        //       contentVerticalPadding: 20,
        //       contentBackgroundColor: const Color(0xff2F2F2F),
        //       content: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           TextFields(
        //             hinttext: 'Why is this goal important to you',
        //             whatIsInput: '1',
        //             controller: motivationControllers[0],
        //           ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.019,
        //           ),
        //           TextFields(
        //             hinttext:
        //                 'What will happen after you achieve this goal',
        //             whatIsInput: '1',
        //             controller: motivationControllers[1],
        //           ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.019,
        //           ),
        //           TextFields(
        //             hinttext:
        //                 'How would you feel if you don’t achieve this goal',
        //             whatIsInput: '1',
        //             controller: motivationControllers[2],
        //           ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.019,
        //           ),
        //           ...motivationControllers.sublist(3).asMap().entries.map(
        //             (entry) {
        //               int index = entry.key;
        //               TextEditingController controller = entry.value;
        //               return Padding(
        //                 padding: const EdgeInsets.symmetric(
        //                   vertical: 8.0,
        //                 ),
        //                 child: TextFields(
        //                   hinttext: 'Additional Motivation ${index + 1}',
        //                   whatIsInput: '1',
        //                   controller: controller,
        //                 ),
        //               );
        //             },
        //           ).toList(),
        //           Align(
        //             alignment: Alignment.centerRight,
        //             child: ElevatedButton(
        //               onPressed: () {
        //                 setState(() {
        //                   motivationControllers.add(
        //                     TextEditingController(),
        //                   );
        //                 });
        //               },
        //               child: const Text('Add Motivation'),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     // Sub Goals and Deadline Section
        //     AccordionSection(
        //       contentBorderColor: const Color(0xff959595),
        //       isOpen: true,
        //       leftIcon: const Icon(
        //         Icons.ads_click_rounded,
        //         color: Colors.white,
        //       ),
        //       header: const Text(
        //         'Sub Goals and Deadline',
        //         style: headerStyle,
        //       ),
        //       contentVerticalPadding: 20,
        //       contentBackgroundColor: const Color(0xff2F2F2F),
        //       content: Column(
        //         children: [
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.019,
        //           ),
        //           DateSelector(
        //             hintText: "Dead Line Of this current Vision Board",
        //             controller: _dateController,
        //             icon: Icons.calendar_today,
        //             firstDate: DateTime(2000),
        //             lastDate: DateTime(2100),
        //             initialDate: DateTime.now(),
        //           ),
        //           ...subGoals.asMap().entries.map((entry) {
        //             int index = entry.key;
        //             SubGoalData subGoal = entry.value;
        //             return Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 8.0),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Container(
        //                     width:
        //                         MediaQuery.of(context).size.width * 0.40,
        //                     child: TextFields(
        //                       hinttext: 'Sub goal name',
        //                       whatIsInput: '1',
        //                       controller: subGoal.goalController,
        //                     ),
        //                   ),
        //                   Container(
        //                     width:
        //                         MediaQuery.of(context).size.width * 0.40,
        //                     child: DateSelector(
        //                       hintText: "Subgoal Deadline",
        //                       controller: subGoal.deadlineController,
        //                       icon: Icons.calendar_today,
        //                       firstDate: DateTime(2000),
        //                       lastDate: DateTime(2100),
        //                       initialDate: DateTime.now(),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             );
        //           }).toList(),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.02,
        //           ),
        //           Align(
        //             alignment: Alignment.centerRight,
        //             child: ElevatedButton(
        //               onPressed: () {
        //                 setState(() {
        //                   subGoals.add(
        //                     SubGoalData(
        //                       goalController: TextEditingController(),
        //                       deadlineController: TextEditingController(),
        //                     ),
        //                   );
        //                 });
        //               },
        //               child: const Text('Add Sub Goal'),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     // Finance and Impact Section
        //     AccordionSection(
        //       contentBorderColor: const Color(0xff959595),
        //       isOpen: true,
        //       leftIcon: const Icon(
        //         Icons.monetization_on,
        //         color: Colors.white,
        //       ),
        //       header: const Text(
        //         'Finance and Impact',
        //         style: headerStyle,
        //       ),
        //       contentVerticalPadding: 20,
        //       contentBackgroundColor: const Color(0xff2F2F2F),
        //       content: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.019,
        //           ),
        //           TextFields(
        //             hinttext: "How much will this project",
        //             whatIsInput: '1',
        //             controller: _totalMoney,
        //           ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.02,
        //           ),
        //           Align(
        //             alignment: Alignment.centerLeft,
        //             child: Text(
        //               "How much do you think you are going to save",
        //               style: TextStyle(
        //                 backgroundColor: Colors.black87.withOpacity(.3),
        //                 color: Colors.white70,
        //               ),
        //             ),
        //           ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.019,
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Container(
        //                 width: MediaQuery.of(context).size.width * 0.40,
        //                 child: TextFields(
        //                   hinttext: 'Amount Saved',
        //                   whatIsInput: '0',
        //                   controller: _amountSaved,
        //                 ),
        //               ),
        //               Container(
        //                 width: MediaQuery.of(context).size.width * 0.40,
        //                 child: TextFields(
        //                   hinttext: 'Time Saved',
        //                   whatIsInput: '0',
        //                   controller: _timeSaved,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.02,
        //           ),
        //           Align(
        //             alignment: Alignment.centerLeft,
        //             child: Text(
        //               "Where do you think to get the income",
        //               style: TextStyle(
        //                 backgroundColor: Colors.black87.withOpacity(.3),
        //                 color: Colors.white70,
        //               ),
        //             ),
        //           ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.019,
        //           ),
        //           ...income.asMap().entries.map((entry) {
        //             int index = entry.key;
        //             IncomeData subIncome = entry.value;
        //             return Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 8.0),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Container(
        //                     width:
        //                         MediaQuery.of(context).size.width * 0.40,
        //                     child: TextFields(
        //                       hinttext: 'Source',
        //                       whatIsInput: '1',
        //                       controller: subIncome.sourceController,
        //                     ),
        //                   ),
        //                   Container(
        //                     width:
        //                         MediaQuery.of(context).size.width * 0.40,
        //                     child: TextFields(
        //                       hinttext: 'Amount',
        //                       whatIsInput: '1',
        //                       controller: subIncome.amountController,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             );
        //           }).toList(),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.02,
        //           ),
        //           Align(
        //             alignment: Alignment.center,
        //             child: ElevatedButton(
        //               onPressed: () {
        //                 setState(() {
        //                   income.add(
        //                     IncomeData(
        //                       sourceController: TextEditingController(),
        //                       amountController: TextEditingController(),
        //                     ),
        //                   );
        //                 });
        //               },
        //               child: const Text('Add Source'),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),

        // ],
      ),
      // ),
      // ),
    );
  }
}
