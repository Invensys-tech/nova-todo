import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/pages/notespage/common/note-list.dart';
import 'package:flutter_application_1/pages/notespage/common/notes-quil.dart';
import 'package:flutter_application_1/repositories/notes.repository.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../drawer/drawerpage.dart';

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
          ).then((value) {
            fetchNotes();
          });
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(Icons.menu, size: 27),
        ),
        title: Row(
          children: [
            Text(translate("Notes")),
            SizedBox(width: MediaQuery.of(context).size.width * .015),
            Container(
              height: MediaQuery.of(context).size.height * .03,
              width: MediaQuery.of(context).size.width * .06,
              child: Image.asset('assets/Gif/Quotes.gif'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff009966),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
            context,
            screen: NoteQuil(note: ''),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
            settings: const RouteSettings(),
          ).then((_) {
            // Refresh the notes when returning from the form.
            fetchNotes();
          });
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),

      drawer: Drawer(child: Drawerpage(), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }
}
