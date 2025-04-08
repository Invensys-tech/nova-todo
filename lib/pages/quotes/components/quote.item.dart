import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class QuoteItem extends StatelessWidget {
  final Quote quote;
  const QuoteItem({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800, // Set the background color here
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.03,
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Column(
        spacing: MediaQuery.of(context).size.width * 0.02,
        children: [
          Text(
            '"${quote.text}"',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    quote.author,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    quote.source,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  quote.category,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Text(
                getDateOnly(DateTime.now()),
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
