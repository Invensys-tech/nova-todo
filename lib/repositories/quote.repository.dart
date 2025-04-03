import 'dart:convert';

import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuoteRepository {
  Future<bool> createQuote(Quote quote) async {
    try {
      final response = await supabaseClient
          .from(Entities.QUOTES.dbName)
          .insert(quote.toMap())
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
      final data = await supabaseClient.from(Entities.QUOTES.dbName).select();

      List<Quote> quotes =
          data.map((quoteData) {
            // print(jsonEncode(quoteData));
            return Quote.fromJson(quoteData);
          }).toList();

      return quotes;
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
}
