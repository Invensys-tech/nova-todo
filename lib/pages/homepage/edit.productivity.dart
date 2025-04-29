import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/pages/homepage/form.productivity-habit.dart';
import 'package:flutter_application_1/repositories/productivity.repository.dart';
import 'package:flutter_application_1/ui/inputs/dateselector.dart';
import 'package:flutter_application_1/ui/inputs/dropdown.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/productivity-frequency.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';

class EditProductivity extends StatefulWidget {
  final Productivity productivity;

  const EditProductivity({Key? key, required this.productivity})
    : super(key: key);

  @override
  _EditProductivityState createState() => _EditProductivityState();
}

class _EditProductivityState extends State<EditProductivity> {
  late FormInput title;
  late FormInput frequency;
  late FormInput time;
  late FormInput description;

  @override
  void initState() {
    super.initState();

    // Initialize each FormInput with the existing values
    title = FormInput(
      label: "Title",
      hint: "Enter your title",
      type: "1",
      controller: TextEditingController(text: widget.productivity.title),
    );
    frequency = FormInput(
      label: "Frequency",
      hint: "Frequency",
      type: "0",
      controller: TextEditingController(
        text: widget.productivity.frequency?.toString(),
      ),
    );
    time = FormInput(
      label: "Time",
      hint: "Time",
      type: "0",
      controller: TextEditingController(text: widget.productivity.time),
    );
    description = FormInput(
      label: "Description",
      hint: "Description",
      type: "1",
      controller: TextEditingController(text: widget.productivity.description),
    );
  }

  Future<void> _updateProductivity() async {
    await ProductivityRepository().updateProductivity(widget.productivity.id, {
      'title': title.controller.text,
      'frequency': frequency.controller.text,
      'time': time.controller.text,
      'description': description.controller.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Productivity",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xff2F2F2F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, false),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff27272A), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Topic Title",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                TextFields(
                  hinttext: title.hint,
                  controller: title.controller,
                  whatIsInput: title.type,
                ),

                const SizedBox(height: 16),
                const Text(
                  "Time",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                TermSelector(controller: time.controller),

                const SizedBox(height: 16),
                const Text(
                  "Frequency",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                TextFields(
                  hinttext: frequency.hint,
                  whatIsInput: frequency.type,
                  controller: frequency.controller,
                ),

                const SizedBox(height: 16),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                MultiLineTextField(
                  hintText: description.hint,
                  controller: description.controller,
                  icon: Icons.description,
                ),

                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await _updateProductivity();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Changes saved!")),
                            );
                            Navigator.pop(context, true);
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
