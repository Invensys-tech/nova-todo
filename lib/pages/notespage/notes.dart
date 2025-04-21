import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/pages/notespage/common/note-list.dart';
import 'package:flutter_application_1/pages/notespage/common/notes-quil.dart';
import 'package:flutter_application_1/repositories/notes.repository.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];
  QuillController controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    List<Note> fetchedNotes = await NotesRepository().getNotes();
    setState(() {
      notes = fetchedNotes;
    });
  }

  Widget buildNoteCard(Note note) {
    try {
      dynamic jsonList = jsonDecode(jsonDecode(note.notes));
      Document quillData = Document.fromJson(jsonList);
      String plainText = quillData.toPlainText();

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => NoteQuil(
                    note: note.notes,
                    id: note.id,
                    title: note.title,
                  ),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Color(int.parse(note.color.replaceFirst('#', '0xFF'))),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(plainText, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    } catch (e) {
      return Text(
        "Error loading note: $e",
        style: const TextStyle(color: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2F2F2F),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteQuil(note: '')),
          ).then((_) {
            // Refresh the notes when returning from the form.
            fetchNotes();
          });
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.account_tree, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Notes",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child:
                  notes.isEmpty
                      ? const Center(
                        child: Text(
                          "No Notes Found",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : NotesList(notes: notes),
            ),

            // Expanded(
            //   child:
            //       notes.isEmpty
            //           ? const Center(
            //             child: Text(
            //               "No Notes Found",
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           )
            //           : SingleChildScrollView(
            //             child: Row(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 // Even index notes
            //                 Expanded(
            //                   child: Column(
            //                     children: [
            //                       for (int i = 0; i < notes.length; i += 2)
            //                         buildNoteCard(notes[i]),
            //                     ],
            //                   ),
            //                 ),
            //                 const SizedBox(width: 8),
            //                 // Odd index notes
            //                 Expanded(
            //                   child: Column(
            //                     children: [
            //                       for (int i = 1; i < notes.length; i += 2)
            //                         buildNoteCard(notes[i]),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            // ),
          ],
        ),
      ),
    );
  }
}
