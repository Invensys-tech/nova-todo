import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/repositories/journal.repository.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';

class QuilExample extends StatefulWidget {
  final int goalId;
  final String journal;
  final void Function(Journal journal) addJournal;

  const QuilExample({
    super.key,
    required this.goalId,
    required this.journal,
    required this.addJournal,
  });

  @override
  State<QuilExample> createState() => _QuilExampleState();
}

class _QuilExampleState extends State<QuilExample> {
  QuillController _controller = QuillController.basic();

  logController() {
    final String json = jsonEncode(_controller.document.toDelta().toJson());
    print('-------------------- JSON ------------------');
    print(json);
  }

  saveJournal() async {
    final String json = jsonEncode(_controller.document.toDelta().toJson());
    Journal savedJournal = await JournalRepository().createJournal(
      Journal(journal: json, goalId: widget.goalId),
      widget.goalId,
    );
    widget.addJournal(savedJournal);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              onPressed: saveJournal,
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            children: [
              QuillSimpleToolbar(
                controller: _controller,
                config: const QuillSimpleToolbarConfig(),
              ),
              Expanded(
                child: QuillEditor.basic(
                  controller: _controller,
                  config: const QuillEditorConfig(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
