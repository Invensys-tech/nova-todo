import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DailyJournalRepository {
  void upsertFromMap(Map<String, dynamic> dailyJournalMap) async {
    try {
      final response = await supabaseClient
          .from(Entities.DAILY_JOURNAL.dbName)
          .upsert(dailyJournalMap, onConflict: 'date')
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error upserting daily journal!');
      }
    } catch (e) {
      // print('Error creating daily journal');
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchByDate(String date) async {
    try {
      final data =
          await supabaseClient
              .from(Entities.DAILY_JOURNAL.dbName)
              .select()
              .eq('date', date)
              .maybeSingle();

      if (data == null) {
        throw Exception('Error getting daily journal!');
      }

      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
