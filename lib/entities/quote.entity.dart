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

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
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
}
