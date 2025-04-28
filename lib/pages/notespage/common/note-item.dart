// note_item.dart

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart'; // for `isDark`
import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/pages/notespage/common/notes-quil.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: GestureDetector(
        onTap: () {


          PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
            context,
            screen: NoteQuil(note: note.notes, id: note.id, title: note.title),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
            settings: const RouteSettings(name: "/productivity-home"),
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(30),
          ),
          child: Container(
            width: double.infinity,

             decoration:  Theme.of(context).brightness == Brightness.dark  ?
             BoxDecoration(color: bgColor == Color(0xff5EE9B5) ? Color(0xff0B211C) :
             bgColor == Color(0xffFFA1AD) ? Color(0xff3B141F) :
             bgColor == Color(0xffFFB86A) ? Color(0xff381A13) :
             bgColor == Color(0xffE4E4E7) ? Color(0xff09090B) :
             bgColor == Color(0xffA2F4FD) ? Color(0xff0C2524) :
             bgColor == Color(0xffD4D4D8) ? Color(0xff09090B) :
             bgColor == Color(0xffF6CFFF) ? Color(0xff39143B) : bgColor
             ):


             BoxDecoration(color: bgColor ),
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
                  padding:  EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width*.035,
                    vertical: MediaQuery.of(context).size.height*.027,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: GoogleFonts.handlee(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        plainText,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.handlee(
                          fontSize: 14,
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
    );
  }
}
