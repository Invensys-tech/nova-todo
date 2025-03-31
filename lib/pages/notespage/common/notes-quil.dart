import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/notes.repository.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NoteQuil extends StatefulWidget {
  final String note;
  int? id;
  String? title;
  // final QuillController controller;

  NoteQuil({super.key, required this.note, this.id, this.title});

  @override
  State<NoteQuil> createState() => _NoteQuilState();
}

class _NoteQuilState extends State<NoteQuil> {
  late QuillController _controller;
  final title = FormInput(
    label: "Title",
    hint: "Enter your title",
    type: "1",
    controller: TextEditingController(),
  );

  Color _selectedColor = Colors.lightGreen;

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }

  saveJournal() async {
    final List<Map<String, dynamic>> json =
        (_controller.document.toDelta().toJson());

    Note note = await NotesRepository().createNote({
      'title': title.controller.text,
      'notes': json,
      'user_id': 1,
      'color': colorToHex(_selectedColor),
    });

    print('-------------------- JSON ------------------');
    print(json.runtimeType);
    Navigator.pop(context);
  }

  updateJournal() async {
    final List<Map<String, dynamic>> json =
        (_controller.document.toDelta().toJson());

    final List<Map<String, dynamic>> finalJson = [
      {
        'title': title.controller.text,
        'notes': json,
        'color': colorToHex(_selectedColor),
      },
    ];
    Note note = await NotesRepository().updateNote(finalJson, widget.id!);

    print('-------------------- JSON ------------------');
    print(json.runtimeType);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    print("====================llllllllllllll");
    print(widget.note);
    if (widget.note != "") {
      _controller = QuillController(
        document: Document.fromJson(jsonDecode(jsonDecode(widget.note))),
        selection: const TextSelection.collapsed(offset: 0),
      );
      title.controller.text = widget.title ?? "";
    } else {
      _controller = QuillController.basic();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void openColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = _selectedColor;
        return AlertDialog(
          title: const Text("Pick a color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
              enableAlpha: false,
              displayThumbColor: true,
              paletteType: PaletteType.hsv,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedColor = tempColor;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Select"),
            ),
          ],
        );
      },
    );
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
                  widget.note != ""
                      ? updateJournal
                      : saveJournal, // widget.journal != "" ? updateJournal : saveJournal,
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
            const Text(
              "Title",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            TextFields(
              hinttext: title.hint,
              whatIsInput: title.type,
              controller: title.controller,
            ),
            const SizedBox(height: 10),
            // Color selector row (Hex selector)
            Row(
              children: [
                const Text(
                  "Select Color:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: openColorPicker,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  colorToHex(_selectedColor),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  QuillSimpleToolbar(
                    controller: _controller,
                    config: QuillSimpleToolbarConfig(),
                  ),
                  Expanded(
                    child: QuillEditor.basic(
                      controller: _controller,
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
