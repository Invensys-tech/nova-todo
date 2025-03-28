import 'package:flutter/widgets.dart';

import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoalInformationAccordion extends StatefulWidget {
  const GoalInformationAccordion({super.key});

  @override
  State<GoalInformationAccordion> createState() =>
      _GoalInformationAccordionState();
}

class _GoalInformationAccordionState extends State<GoalInformationAccordion> {
  @override
  Widget build(BuildContext context) {
    // return AccordionSection(
    //   contentBorderColor: const Color(0xff959595),
    //   isOpen: true,
    //   leftIcon: const Icon(Icons.star_rounded, color: Colors.white),
    //   header: const Text('Goal Information'),
    //   contentVerticalPadding: 20,
    //   contentBackgroundColor: const Color(0xff2F2F2F),
    //   content: Column(
    //     children: [
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            label: Text('Some text goes here ...'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Submit')),
      ],
    );
    //     ],
    //   ),
    // );
  }
}
