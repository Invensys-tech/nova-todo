// dynamic x = [..._expansions.asMap().entries.map(
//                 (entry) => ExpansionPanel(
//                   headerBuilder: (context, isExpanded) {
//                     return Container(
//                       padding: const EdgeInsets.all(8.0),
//                       color: const Color(0xff2F2F2F),
//                       child: Text(entry.value, style: headerStyle),
//                     );
//                   },
//                   body: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.40,
//                             child: TextFields(
//                               hinttext: 'Goal Name',
//                               whatIsInput: '1',
//                               controller: _goalName,
//                             ),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.40,
//                             child: TextFields(
//                               hinttext: 'Terms of Goal',
//                               whatIsInput: '1',
//                               controller: _goalTerm,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.40,
//                             child: TextFields(
//                               hinttext: 'Goal Priority',
//                               whatIsInput: '1',
//                               controller: _goalPriority,
//                             ),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.40,
//                             child: TextFields(
//                               hinttext: 'Goal Status',
//                               whatIsInput: '1',
//                               controller: _goalStatus,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       MultiLineTextField(
//                         hintText: 'description',
//                         controller: _goalDescription,
//                         icon: Icons.description,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: const Text('Submit'),
//                       ),
//                     ],
//                   ),
//                   isExpanded: _expandedIndex == entry.key,
//                 ),
//               )];
