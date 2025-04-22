// note_item.dart

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart'; // for `isDark`
import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/pages/notespage/common/notes-quil.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  NoteItem({Key? key, required this.note}) : super(key: key);

  // exactly the same translucent square you had in QuoteItem
  Widget _buildSquare(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    // decode Quill JSON → plain text
    String plainText;
    try {
      final dynamic jsonList = jsonDecode(jsonDecode(note.notes));
      final Document doc = Document.fromJson(jsonList);
      plainText = doc.toPlainText().trim();
    } catch (e) {
      plainText = "Error parsing note…";
    }

    // use your DB‑stored color
    final Color bgColor = Color(
      int.parse(note.color.replaceFirst('#', '0xFF')),
    );

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) =>
                        NoteQuil(note: note.notes, id: note.id, title: note.title),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(30),
              ),
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(color: bgColor),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: -60,
                      right: -60,
                      child: _buildSquare(
                        90,
                        const Color(0xFFFAFAFA).withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: GoogleFonts.handlee(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            plainText,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.handlee(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),


        // ClipRRect(
        //   borderRadius: BorderRadius.only(
        //     topRight: Radius.circular(10.0),
        //     topLeft: Radius.circular(10.0),
        //     bottomLeft: Radius.circular(10.0),
        //     bottomRight: Radius.circular(30.0),
        //   ),
        //   child: Container(
        //     width: MediaQuery.of(context).size.width*.45,
        //     decoration: BoxDecoration(
        //       // color: Colors.grey.shade800,
        //       color: bgColor
        //     ),
        //     child: Stack(
        //       children: [
        //         Positioned(
        //           bottom: -60,
        //           right: -60,
        //           child: _buildSquare(
        //             90.0,
        //             const Color(0xFFFAFAFA).withValues(alpha: 0.5),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(
        //             horizontal: MediaQuery.of(context).size.width * .035,
        //             vertical: 20.0,
        //           ),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 note.title,
        //                 style: const TextStyle(
        //                   fontSize: 16,
        //                   fontWeight: FontWeight.w500,
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               const SizedBox(height: 12),
        //               Text(
        //                 plainText,
        //                 maxLines: 6,
        //                 overflow: TextOverflow.ellipsis,
        //                 style: const TextStyle(
        //                   fontSize: 14,
        //                   color: Colors.white70,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
