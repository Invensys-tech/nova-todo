import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class JournalRepository {
  Future<Journal> createJournal(
    List<Map<String, dynamic>> journal,
    int goalId,
  ) async {
    // print(journal.toJson());
    print("Goal ID: $goalId");
    try {
      final response = await supabaseClient
          .from(Entities.JOURNAL.dbName)
          .insert({"journal": jsonEncode(journal), "goalId": goalId})
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception("Error creating journal!");
      }

      final journals = await supabaseClient
          .from(Entities.JOURNAL.dbName)
          .select('*');
      print(journals[journals.length - 1]);

      Journal savedJournal = Journal.fromJson(journals[journals.length - 1]);
      print(jsonEncode(savedJournal));

      return savedJournal;
      // return journal;
    } catch (e) {
      print("----------------------Issue in the Repository------------------");

      print(e);
      rethrow;
    }
  }

  Future<Journal> updateJournal(
    List<Map<String, dynamic>> journal,
    int id,
  ) async {
    try {
      final response = await supabaseClient
          .from(Entities.JOURNAL.dbName)
          .update({"journal": jsonEncode(journal)})
          .eq('id', id)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception("Journal not found!");
      }

      final data =
          await supabaseClient
              .from(Entities.JOURNAL.dbName)
              .select('*')
              .eq('id', id)
              .maybeSingle();

      if (data == null) {
        throw Exception("Journal not found!");
      }

      Journal savedJournal = Journal.fromJson(data);
      print(jsonEncode(savedJournal));

      return savedJournal;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

// class JournalRepository {
//   Future<void> createJournal(
//     List<Map<String, dynamic>> journal,
//     int goalId,
//   ) async {
//     try {
//       final response = await supabaseClient
//           .from(Entities.JOURNAL.dbName)
//           .insert({
//             "journal": jsonEncode(journal), // Serialize the journal list
//             "goalId": goalId,
//           })
//           .count(CountOption.exact);

//       if (response.count == 0) {
//         throw Exception("Error creating journal!");
//       }

//       final journals = await supabaseClient
//           .from(Entities.JOURNAL.dbName)
//           .select('id');
//     } catch (e) {
//       print("----------------------Issue in the Repository------------------");
//       print(e);
//       rethrow;
//     }
//   }
// }
