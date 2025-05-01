import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class Quote {
  final int? id;
  final String text;
  final String author;
  final String source;
  final String category;

  Quote({
    this.id,
    required this.text,
    required this.author,
    required this.source,
    required this.category,
  });

  factory Quote.fromJson(Map<dynamic, dynamic> json) => Quote(
    id: json['id'],
    text: json['text'],
    author: json['author'],
    source: json['source'],
    category: json['category'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'author': author,
    'source': source,
    'category': category,
  };

  Map<String, dynamic> toDBJson() => {
    'text': text,
    'author': author,
    'source': source,
    'category': category,
  };
}

class QuoteService {
  static final hiveService = HiveService();

  static Future<List<Quote>>? getOfflineQuotes() async {
    await QuoteService.hiveService.initHive(boxName: Entities.QUOTES.dbName);
    final List<dynamic>? quotes = await QuoteService.hiveService
        .getData('all');

    return quotes?.map((quote) => Quote.fromJson(quote)).toList() ?? [];
  }

  static syncQuotes(List<Quote> quotes) async {
    await QuoteService.hiveService.initHive(boxName: Entities.QUOTES.dbName);
    await QuoteService.hiveService.upsertData(
      'all',
      quotes.map((quote) => quote.toJson()).toList(),
    );
  }

  static createOfflineQuote(Quote quote) async {
    await QuoteService.hiveService.initHive(boxName: Entities.QUOTES.dbName);
    final List<Map<String, dynamic>> quotes = await QuoteService.hiveService
        .getData('all');
    await QuoteService.hiveService.upsertData('all', [
      ...quotes,
      quote.toJson(),
    ]);
  }
}
