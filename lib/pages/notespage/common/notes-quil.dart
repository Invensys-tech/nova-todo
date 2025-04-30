// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/entities/notes-entity.dart';
// import 'package:flutter_application_1/pages/goal/common/types.dart';
// import 'package:flutter_application_1/repositories/notes.repository.dart';
// import 'package:flutter_application_1/ui/inputs/textfield.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'dart:convert';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// class NoteQuil extends StatefulWidget {
//   final String note;
//   int? id;
//   String? title;
//   // final QuillController controller;

//   NoteQuil({super.key, required this.note, this.id, this.title});

//   @override
//   State<NoteQuil> createState() => _NoteQuilState();
// }

// class _NoteQuilState extends State<NoteQuil> {
//   late QuillController _controller;
//   final title = FormInput(
//     label: "Title",
//     hint: "Enter your title",
//     type: "1",
//     controller: TextEditingController(),
//   );

//   Color _selectedColor = Colors.lightGreen;

//   List colorList = [
//     '#5EE9B5',
//     '#FFA1AD',
//     '#FFB86A',
//     '#D4D4D8',
//     '#A2F4FD',
//     '#F6CFFF',
//   ];

//   String colorToHex(Color color) {
//     return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
//   }

//   saveJournal() async {
//     final List<Map<String, dynamic>> json =
//         (_controller.document.toDelta().toJson());

//     Note note = await NotesRepository().createNote({
//       'title': title.controller.text,
//       'notes': json,
//       'user_id': 1,
//       'color': colorToHex(_selectedColor),
//     });

//     print('-------------------- JSON ------------------');
//     print(json.runtimeType);
//     Navigator.pop(context);
//   }

//   updateJournal() async {
//     final List<Map<String, dynamic>> json =
//         (_controller.document.toDelta().toJson());

//     final List<Map<String, dynamic>> finalJson = [
//       {
//         'title': title.controller.text,
//         'notes': json,
//         'color': colorToHex(_selectedColor),
//       },
//     ];
//     Note note = await NotesRepository().updateNote(finalJson, widget.id!);

//     print('-------------------- JSON ------------------');
//     print(json.runtimeType);
//     Navigator.pop(context);
//   }

//   @override
//   void initState() {
//     super.initState();
//     print("====================llllllllllllll");
//     print(widget.note);
//     if (widget.note != "") {
//       _controller = QuillController(
//         document: Document.fromJson(jsonDecode(jsonDecode(widget.note))),
//         selection: const TextSelection.collapsed(offset: 0),
//       );
//       title.controller.text = widget.title ?? "";
//     } else {
//       _controller = QuillController.basic();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void openColorPicker() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         Color tempColor = _selectedColor;
//         return AlertDialog(
//           title: const Text("Pick a color"),
//           content: SingleChildScrollView(
//             child: ColorPicker(
//               pickerColor: tempColor,
//               onColorChanged: (Color color) {
//                 tempColor = color;
//               },
//               enableAlpha: false,
//               displayThumbColor: true,
//               paletteType: PaletteType.hsv,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _selectedColor = tempColor;
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Select"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: widget.note != "" ? updateJournal : saveJournal,
//               child: const Text("Save", style: TextStyle(color: Colors.white)),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.05,
//           vertical: MediaQuery.of(context).size.height * 0.02,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Title",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white70,
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       TextFields(
//                         hinttext: title.hint,
//                         whatIsInput: title.type,
//                         controller: title.controller,
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(width: 10),
//                 // Color selector row (Hex selector)
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Select Color:",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white70,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       GestureDetector(
//                         onTap: openColorPicker,
//                         child: Container(
//                           width: 30,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: _selectedColor,
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.white, width: 1),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         colorToHex(_selectedColor),
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 10),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.7,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   QuillSimpleToolbar(
//                     controller: _controller,
//                     config: QuillSimpleToolbarConfig(
//                       showUndo:
//                           false, // Set this to false to remove the undo button
//                       showRedo: false,
//                       showStrikeThrough: false,
//                       showInlineCode: false,
//                       showClearFormat: false,
//                       showCodeBlock: false,
//                       showSearchButton: false,
//                       showLink: false,

//                       // Set this to false to remove the redo button
//                     ),
//                   ),

//                   Expanded(
//                     child: QuillEditor.basic(
//                       controller: _controller,
//                       config: QuillEditorConfig(
//                         scrollable: true,
//                         scrollPhysics: AlwaysScrollableScrollPhysics(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/pages/goal/common/types.dart';
import 'package:flutter_application_1/repositories/notes.repository.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
class NoteQuil extends StatefulWidget {
  final String note;
  int? id;
  String? title;

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

  // Map of display name → hex code
  final Map<String, String> _colorOptions = {
    "Mint Green": "#5EE9B5",
    "Coral Pink": "#FFA1AD",
    "Apricot": "#FFB86A",
    "Light Gray": "#D4D4D8",
    "Sky Blue": "#A2F4FD",
    "Lavender": "#F6CFFF",
  };

  // Currently selected name & hex
  late String _selectedName;
  late String _selectedHex;

  Color _hexToColor(String hex) {
    final cleaned = hex.replaceAll('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }

  String _hexToDisplay(String hex) {
    return hex.toUpperCase();
  }

  @override
  void initState() {
    super.initState();

    // init Quill controller
    if (widget.note.isNotEmpty) {
      _controller = QuillController(
        document: Document.fromJson(
          jsonDecode(jsonDecode(widget.note)) as List<dynamic>,
        ),
        selection: const TextSelection.collapsed(offset: 0),
      );
      title.controller.text = widget.title ?? "";
    } else {
      _controller = QuillController.basic();
    }

    // default to first entry
    _selectedName = _colorOptions.keys.first;
    _selectedHex = _colorOptions[_selectedName]!;
  }

  Future<void> saveJournal() async {
    final json = _controller.document.toDelta().toJson();
    await NotesRepository().createNote({
      'title': title.controller.text,
      'notes': json,
      'user_id': 1,
      'color': _selectedHex,
    });
    Navigator.pop(context);
  }

  Future<void> updateJournal() async {
    final json = _controller.document.toDelta().toJson();
    await NotesRepository().updateNote([
      {'title': title.controller.text, 'notes': json, 'color': _selectedHex},
    ], widget.id!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon:  Icon(Icons.arrow_back, ),
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
              onPressed: widget.note != "" ? updateJournal : saveJournal,
              child:  Text(translate("Save"), style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .05,
          vertical: MediaQuery.of(context).size.height * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .005),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title input
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .0025,
                      ),
                      TextFields(
                        hinttext: title.hint,
                        whatIsInput: title.type,
                        controller: title.controller,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // **Dropdown in place of color selector**
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Color of Note:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .0025,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*.045,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedName,
                            iconEnabledColor: Colors.white,
                            dropdownColor: Colors.grey.shade900,
                            items:
                                _colorOptions.entries.map((entry) {
                                  return DropdownMenuItem<String>(
                                    value: entry.key,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          margin: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _hexToColor(entry.value),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white24,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          entry.key,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                            onChanged: (newName) {
                              if (newName == null) return;
                              setState(() {
                                _selectedName = newName;
                                _selectedHex = _colorOptions[newName]!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

             SizedBox(height: MediaQuery.of(context).size.height*.025),

            // Quill toolbar + editor
            Localizations.override(
              context: context,
              locale:Locale ('en','US'),
              delegates: [
                FlutterQuillLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,],
              child: Container(
                height: MediaQuery.of(context).size.height * 0.757,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width:MediaQuery.of(context).size.width*1,
                      child: QuillSimpleToolbar(
                        controller: _controller,

                        config: QuillSimpleToolbarConfig(
                            toolbarIconAlignment: WrapAlignment.start,
                            toolbarRunSpacing: 0,
                            showUndo:
                            false, // Set this to false to remove the undo button
                            showRedo: false,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),

                            showStrikeThrough: false,
                            showInlineCode: false,
                            showClearFormat: false,
                            showCodeBlock: false,
                            showSearchButton: false,
                            showLink: false,
                            showCenterAlignment: false,
                            showQuote: false,
                            showRightAlignment: false,
                            showListCheck: false,
                            showListBullets: false,
                            showListNumbers: false,
                            showSmallButton: false,
                            showLeftAlignment: false,
                            showJustifyAlignment: false,
                            showAlignmentButtons: false,
                            showLineHeightButton: false,
                            showIndent: false,
                            headerStyleType: HeaderStyleType.original,
                            axis: Axis.horizontal
                        ),
                      ),
                    ),
                    Expanded(
                      child: QuillEditor.basic(
                        controller: _controller,
                        config: QuillEditorConfig(
                          scrollable: true,
                        ),
                      ),
                    ),
                    QuillSimpleToolbar(

                      controller: _controller,
                      config: QuillSimpleToolbarConfig(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),

                          showUndo:
                          false, // Set this to false to remove the undo button
                          showRedo: false,
                          showStrikeThrough: false,
                          showInlineCode: false,
                          showClearFormat: false,
                          showCodeBlock: false,
                          showSearchButton: false,
                          showLink: false,
                          showBackgroundColorButton: false,
                          showColorButton: false,
                          showFontSize: false,
                          showFontFamily: false,
                          showBoldButton: false,
                          showItalicButton: false,
                          showUnderLineButton: false,
                          showSubscript: false,
                          showSuperscript: false,
                          showHeaderStyle: false,
                          headerStyleType: HeaderStyleType.original,
                          axis: Axis.horizontal
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
