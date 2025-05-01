import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity-habit.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/productivity-frequency.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductivityForm extends StatefulWidget {
  const ProductivityForm({super.key});

  @override
  State<ProductivityForm> createState() => _ProductivityFormState();
}

class _ProductivityFormState extends State<ProductivityForm> {
  bool isLoading = false;
  final title = FormInput(
    label: "Title",
    hint: "Enter your title",
    type: "1",
    controller: TextEditingController(),
  );
  final frequency = FormInput(
    label: "Frequency",
    hint: "Frequency",
    type: "0",
    controller: TextEditingController(),
  );
  final time = FormInput(
    label: "Time",
    hint: "Time",
    type: "0",
    controller: TextEditingController(),
  );
  final description = FormInput(
    label: "Description",
    hint: "Description",
    type: "1",
    controller: TextEditingController(),
  );

  saveProductivity() async {
    print(" Step 1: Starting saveProductivity");

    final productivity = await ProductivityRepository().createProductivity({
      'title': title.controller.text,
      'frequency': frequency.controller.text,
      'time': (time.controller.text),
      'description': description.controller.text,
      'user_id': userId,
      'streak_count': 1,
    });

    print(" Step 2: Productivity created: ${productivity.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 25,
            color: Color(0xff006045),
          ),
        ),
        title: Text(
          "Add Productivity",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(.4), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(
                8,
              ), // Optional: rounded corners
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  "Topic Title",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                TextFields(
                  hinttext: title.hint,
                  controller: title.controller,
                  whatIsInput: title.type,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TermSelector(controller: time.controller),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  "Frequency",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0025),

                TextFields(
                  hinttext: frequency.hint,
                  whatIsInput: frequency.type,
                  controller: frequency.controller,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.019),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
                MultiLineTextField(
                  hintText: description.hint,
                  controller: description.controller,
                  icon: Icons.description,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.09),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await saveProductivity();

                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Productivity added successfully!",
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pop(context);
                                  } catch (e, stacktrace) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print(" Crash in saveProductivity: $e");
                                    print(stacktrace); // This helps a lot
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error: $e")),
                                    );
                                  }
                                },

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isLoading ? Colors.grey : Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Save and Exit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProductivityHabitForm(
                                              description: description,
                                              frequency: frequency,
                                              time: time,
                                              title: title,
                                            ),
                                      ),
                                    );
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print("Error inserting expense: $e");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error: $e")),
                                    );
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isLoading ? Colors.grey : Colors.blue,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
