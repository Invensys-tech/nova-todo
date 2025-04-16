class Quote {
  final String text;
  final String author;
  final String source;
  final String category;

  Quote({
    required this.text,
    required this.author,
    required this.source,
    required this.category,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    text: json['text'],
    author: json['author'],
    source: json['source'],
    category: json['category'],
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'author': author,
    'source': source,
    'category': category,
  };
}
