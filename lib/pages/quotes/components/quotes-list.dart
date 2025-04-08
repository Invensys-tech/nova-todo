import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/pages/quotes/components/quote.item.dart';

class QuotesList extends StatelessWidget {
  final List<Quote> quotes;
  const QuotesList({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: MediaQuery.of(context).size.width * 0.04,
      children: quotes.map((quote) => QuoteItem(quote: quote)).toList(),
    );
  }
}
