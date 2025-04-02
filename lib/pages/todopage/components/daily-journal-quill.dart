import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DailyJournalQuill extends StatefulWidget {
  final String date;
  const DailyJournalQuill({super.key, required this.date});

  @override
  State<DailyJournalQuill> createState() => _DailyJournalQuillState();
}

class _DailyJournalQuillState extends State<DailyJournalQuill> {
  late QuillController controller;

  @override
  void initState() {
    super.initState();
    controller = QuillController.basic();
  }

  saveJournal() {
    Navigator.pop(context);
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
              onPressed:
                  saveJournal, // widget.journal != "" ? updateJournal : saveJournal,
              // onPressed: saveJournal,
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "Journal On ${widget.date}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  QuillSimpleToolbar(
                    controller: controller,
                    config: QuillSimpleToolbarConfig(),
                  ),
                  Expanded(
                    child: QuillEditor.basic(
                      controller: controller,
                      config: QuillEditorConfig(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
