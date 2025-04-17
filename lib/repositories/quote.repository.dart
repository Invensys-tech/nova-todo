import 'dart:convert';

import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuoteRepository {
  Future<bool> createQuote(Quote quote) async {
    try {
      int userId = (await AuthService().findSession())['id'];
      final response = await supabaseClient
          .from(Entities.QUOTES.dbName)
          .insert({...quote.toJson(), 'user_id': userId})
          // Todo: check other options of CountOption
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating quote!');
      }
      return true;
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<List<Quote>> fetchAll() async {
    try {
      int userId = (await AuthService().findSession())['id'];
      final data = await supabaseClient
          .from(Entities.QUOTES.dbName)
          .select()
          .eq('user_id', userId);

      List<Quote> quotes =
          data.map((quoteData) {
            // print(jsonEncode(quoteData));
            return Quote.fromJson(quoteData);
          }).toList();

      return quotes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
