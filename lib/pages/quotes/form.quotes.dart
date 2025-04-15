import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/quote.repository.dart';
import 'package:flutter_application_1/ui/inputs/mutitext.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class QuoteForm extends StatefulWidget {
  final void Function() refetch;
  const QuoteForm({super.key, required this.refetch});

  @override
  State<QuoteForm> createState() => _QuoteFormState();
}

class _QuoteFormState extends State<QuoteForm> {
  TextEditingController textController = TextEditingController();
  FormInput authorInput = FormInput(
    label: 'Author',
    hint: 'Author',
    type: "1",
    controller: TextEditingController(),
  );
  FormInput sourceInput = FormInput(
    label: 'Source (Optional)',
    hint: 'Quote Source',
    type: "1",
    controller: TextEditingController(),
  );

  List<String> categories = [
    'Motivation',
    'Productivity',
    'Success',
    'Motivation ',
    'Productivity ',
    'Success ',
  ];

  String selectedCategory = "";

  selectCategory(value) {
    setState(() {
      selectedCategory = value;
    });
  }

  navigateBack() {
    Navigator.pop(context);
  }

  saveQuote() {
    Quote quote = Quote(
      text: textController.text,
      author: authorInput.controller.text,
      source: sourceInput.controller.text,
      category: selectedCategory,
    );

    QuoteRepository().createQuote(quote).then((value) {
      if (value) {
        navigateBack();
        widget.refetch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Quotes"),
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.04,
          children: [
            IconButton(
              onPressed: navigateBack,
              icon: const Icon(Icons.arrow_back, color: Colors.green),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            spacing: MediaQuery.of(context).size.width * 0.04,
            children: [
              MultiLineTextField(
                hintText: 'Enter Quote Text...',
                controller: textController,
                icon: Icons.abc,
              ),
              MyTextInput(
                label: authorInput.label,
                textFields: TextFields(
                  hinttext: authorInput.hint,
                  whatIsInput: authorInput.type,
                  controller: authorInput.controller,
                  // icon: Icons.fingerprint,
                ),
              ),
              MyTextInput(
                label: sourceInput.label,
                textFields: TextFields(
                  hinttext: sourceInput.hint,
                  whatIsInput: sourceInput.type,
                  controller: sourceInput.controller,
                  // icon: Icons.fingerprint,
                ),
              ),
              Padding(
                // padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: MediaQuery.of(context).size.width * 0.04,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children:
                          categories
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    selectCategory(e);
                                  },
                                  child: IntrinsicWidth(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            selectedCategory == e
                                                ? Colors.green.shade800
                                                : Colors.blueGrey.shade800,
                                        borderRadius: BorderRadius.circular(
                                          40.0,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        e,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // child: Container(
                                  //   width: 100.0,
                                  //   height: 40.0,
                                  //   decoration: BoxDecoration(
                                  //     color:
                                  //         selectedCategory == e
                                  //             ? Colors.green.shade800
                                  //             : Colors.blueGrey.shade800,
                                  //     borderRadius: BorderRadius.circular(40.0),
                                  //   ),
                                  //   alignment: Alignment.center,
                                  //   child: Text(e),
                                  // ),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: navigateBack,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: saveQuote,
                      child: const Text(
                        "Save Quote",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
