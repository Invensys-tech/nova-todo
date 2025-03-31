import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/pages/notespage/common/notes-quil.dart';
import 'package:flutter_application_1/repositories/notes.repository.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NoteForm extends StatefulWidget {
  final String? note;
  final int? id;
  const NoteForm({super.key, this.note, this.id});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  QuillController controller = QuillController.basic();
  final title = FormInput(
    label: "Title",
    hint: "Enter your title",
    type: "1",
    controller: TextEditingController(),
  );

  saveJournal() async {
    final List<Map<String, dynamic>> json =
        (controller.document.toDelta().toJson());

    final Note note = await NotesRepository().createNote(
      // Journal(journal: json, goalId: widget.goalId),
      {'title': title.controller.text, 'content': json},
    );
    // widget.addJournal(journal, null);
    print('-------------------- JSON ------------------');
    // print(jsonEncode(journal));
    print(json.runtimeType);
    Navigator.pop(context);
  }

  // updateJournal() async {
  //   final List<Map<String, dynamic>> json =
  //       (controller.document.toDelta().toJson());
  //   Journal journal = await JournalRepository().updateJournal(
  //     // Journal(journal: json, goalId: widget.goalId),
  //     json,
  //     widget.id!,
  //   );
  //   // widget.addJournal(journal, widget.id);
  //   print('-------------------- JSON ------------------');

  //   Future.delayed(Duration(milliseconds: 100), () {
  //     Navigator.pop(context);
  //   });
  // }

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
              onPressed: () {
                saveJournal();
              },
              // onPressed: widget.note != "" ? updateJournal : saveJournal,
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   child: TextFields(
            //     hinttext: title.hint,
            //     whatIsInput: title.type,
            //     controller: title.controller,
            //   ),
            // ),
            NoteQuil(note: ''),
          ],
        ),
      ),
    );
  }
}
