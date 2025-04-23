// notes_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/pages/notespage/common/note-item.dart';

class NotesList extends StatelessWidget {
  final List<Note> notes;
  const NotesList({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const tiltAngle = 0.012;

    // Partition your notes into even and odd index lists
    final evenEntries =
        notes.asMap().entries.where((e) => e.key % 2 == 0).toList();
    final oddEntries =
        notes.asMap().entries.where((e) => e.key % 2 == 1).toList();

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column: even‑indexed notes
          Expanded(
            child: Column(
              children:
                  evenEntries.map((entry) {
                    final idx = entry.key;
                    final note = entry.value;
                    return Transform.rotate(
                      angle: idx.isEven ? tiltAngle : -tiltAngle,
                      origin: const Offset(50, 0),
                      child: NoteItem(note: note),
                    );
                  }).toList(),
            ),
          ),

          const SizedBox(width: 8),

          // Right column: odd‑indexed notes
          Expanded(
            child: Column(
              children:
                  oddEntries.map((entry) {
                    final idx = entry.key;
                    final note = entry.value;
                    return Transform.rotate(
                      angle: idx.isEven ? tiltAngle : -tiltAngle,
                      origin: const Offset(50, 0),
                      child: NoteItem(note: note),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
