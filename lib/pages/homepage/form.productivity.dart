import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity-habit.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';

class ProductivityForm extends StatefulWidget {
  const ProductivityForm({super.key});

  @override
  State<ProductivityForm> createState() => _ProductivityFormState();
}

class _ProductivityFormState extends State<ProductivityForm> {
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
    // Save the productivity data to the database or perform any action
    // print(frequency.controller.text.runtimeType);
    Productivity productivity = await ProductivityRepository()
        .createProductivity({
          'title': title.controller.text,
          'frequency': frequency.controller.text,
          'time': formatDate(time.controller.text),
          'description': description.controller.text,
          'user_id': 1,
        });

    print("Productivity saved!");
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
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                "Topic Title",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFields(
                hinttext: title.hint,
                controller: title.controller,
                whatIsInput: title.type,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                spacing: MediaQuery.of(context).size.width * 0.04,
                children: [
                  Expanded(
                    child: TextFields(
                      hinttext: frequency.hint,
                      whatIsInput: frequency.type,
                      controller: frequency.controller,
                    ),
                  ),
                  Expanded(
                    child: CustomDropdown(
                      hintText: "Term",
                      icon: Icons.local_mall,
                      items: ["Daily", "Weekely", "Monthly", "Yearly"],
                      controller: time.controller,
                    ),
                    // child: DateSelector(
                    //   hintText: time.hint,
                    //   controller: time.controller,
                    //   icon: Icons.calendar_today,
                    //   firstDate: DateTime(2000),
                    //   lastDate: DateTime(2100),
                    //   initialDate: DateTime.now(),
                    // ),
                    // child: TextFields(
                    //   hinttext: time.hint,
                    //   whatIsInput: time.type,
                    //   controller: time.controller,
                    // ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.019),
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
                    child: ElevatedButton(
                      onPressed: () {
                        // Clear all input controllers
                        saveProductivity();

                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Productivity added successfully!"),
                          ),
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
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
                          // print("Expense added successfully!");
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text("Expense added successfully!"),
                          //   ),
                          // );

                          // Navigator.pop(context);
                        } catch (e) {
                          print("Error inserting expense: $e");
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            ],
          ),
        ),
      ),
    );
  }
}
