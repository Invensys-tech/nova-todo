import 'dart:convert';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class QuoteRepository {
  Future<bool> createQuote(Quote quote) async {
    try {
      int userId = (await AuthService().findSession())['id'];

      final response = await supabaseClient
          .from(Entities.QUOTES.dbName)
          .insert({...quote.toDBJson(), 'user_id': userId})
          // .insert({...quote.toJson(), 'user_id': 25})
          // Todo: check other options of CountOption
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating quote!');
      }
      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Quote>> fetchAll() async {
    try {
      int userId = (await AuthService().findSession())['id'];

      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      print('user id');
      print(userId);
      print(connectivityResult);

      final isConnected =
          connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) |
              connectivityResult.contains(ConnectivityResult.ethernet);

      // if (![
      //   ConnectivityResult.wifi,
      //   ConnectivityResult.mobile,
      //   ConnectivityResult.ethernet
      // ].contains(connectivityResult))
      if (!isConnected) {
        // print('no connection');
        final oldQuotes = await QuoteService.getOfflineQuotes();
        return oldQuotes ?? [];
      }

      // print('connection');

      final data = await supabaseClient
          .from(Entities.QUOTES.dbName)
          // .from('abebech')
          .select()
          .eq('user_id', userId);
      // .eq('user_id', 25);

      List<Quote> quotes =
          data.map((quoteData) {
            // print(jsonEncode(quoteData));
            return Quote.fromJson(quoteData);
          }).toList();

      await QuoteService.syncQuotes(quotes);

      return quotes;
    } catch (e) {
      if (e.runtimeType.toString() == 'ClientException') {
        print('coudnt connect to internet');
        print(e.runtimeType.toString());
        print(e.runtimeType);
        print(e);
        final oldQuotes = await QuoteService.getOfflineQuotes();
        return oldQuotes ?? [];
      }
      print(e);
      print(e.runtimeType);
      rethrow;
    }
  }

  Future<bool> updateQuoteById(int id, Quote quote) async {
    try {
      int userId = (await AuthService().findSession())['id'];
      final response = await supabaseClient
          .from(Entities.QUOTES.dbName)
          // .insert({...quote.toJson(), 'user_id': 25})
          .update({...quote.toJson()})
          .eq('id', id)
          // Todo: check other options of CountOption
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating quote!');
      }
      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
