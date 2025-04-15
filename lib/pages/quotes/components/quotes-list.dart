import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/pages/quotes/components/quote.item.dart';

class QuotesList extends StatelessWidget {
  final List<Quote> quotes;
  const QuotesList({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    int i = 0;
    final tiltAngle = 0.012;

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          spacing: MediaQuery.of(context).size.width * 0.07,
          children:
              quotes.map((quote) {
                i++;
                return Transform.rotate(
                  angle: i % 2 == 0 ? -tiltAngle : tiltAngle,
                  origin: Offset(50.0, 0.0),
                  child: QuoteItem(quote: quote),
                );
              }).toList(),
        ),
      ),
    );
  }
}
