import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/repositories/journal.repository.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';

class QuilExample extends StatefulWidget {
  final int goalId;
  final String journal;
  final int? id;
  final void Function(Journal journal, int? id) addJournal;

  const QuilExample({
    super.key,
    required this.goalId,
    required this.journal,
    required this.addJournal,
    this.id,
  });

  @override
  State<QuilExample> createState() => _QuilExampleState();
}

class _QuilExampleState extends State<QuilExample> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    print("====================");
    print(widget.journal);
    _controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.journal)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  logController() {
    final String json = jsonEncode(_controller.document.toDelta().toJson());
    print('-------------------- JSON ------------------');
    print(json);
  }

  saveJournal() async {
    final List<Map<String, dynamic>> json =
        (_controller.document.toDelta().toJson());
    Journal journal = await JournalRepository().createJournal(
      // Journal(journal: json, goalId: widget.goalId),
      json,
      widget.goalId,
    );
    widget.addJournal(journal, null);
    print('-------------------- JSON ------------------');
    // print(jsonEncode(journal));
    print(json.runtimeType);
    Navigator.pop(context);
  }

  updateJournal() async {
    final List<Map<String, dynamic>> json =
        (_controller.document.toDelta().toJson());
    Journal journal = await JournalRepository().updateJournal(
      // Journal(journal: json, goalId: widget.goalId),
      json,
      widget.id!,
    );
    widget.addJournal(journal, widget.id);
    print('-------------------- JSON ------------------');
   
  Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pop(context);
    });
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
              onPressed: widget.journal != "" ? updateJournal : saveJournal,
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
