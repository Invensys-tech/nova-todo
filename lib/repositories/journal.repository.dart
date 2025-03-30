import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JournalRepository {
  Future<Journal> createJournal(Journal journal, int goalId) async {
    try {
      final response = await supabaseClient
          .from(Entities.JOURNAL.dbName)
          .insert({...journal.toJson(), goalId: goalId})
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception("Error creating journal!");
      }

      final journals = await supabaseClient
          .from(Entities.JOURNAL.dbName)
          .select('id');

      Journal savedJournal = Journal.fromJson(journals[journals.length - 1]);

      return savedJournal;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
