class Income {
  int id;
  String name;
  String category;
  DateTime date;
  String paidBy;
  String specificFrom;
  num amount;
  String description;

  Income({
    required this.category,
    required this.date,
    required this.id,
    required this.name,
    required this.paidBy,
    required this.specificFrom,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['name'] = name;
    data['paid_from'] = paidBy;
    data['specific_from'] = specificFrom;
    data['date'] = date;
    data['amount'] = amount;
    data['description'] = description;

    return data;
  }

  // factory Income.fromJson(Map<String, dynamic> json) {
  //   return Income(
  //     category: json['category'] as String,
  //     date: DateTime.parse(json['date'] as String),
  //     id: json['id'] as int,
  //     name: json['name'] as String,
  //     paidBy: json['paid_from'] as String,
  //     specificFrom: json['specific_from'] as String,
  //     amount: json['amount'] as num,
  //     description: json['description'] as String,
  //   );
  // }
  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      category: json['category'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      paidBy: json['paid_from'] ?? '',
      specificFrom: json['specific_from'] ?? '',
      amount: json['amount'] ?? 0,
      description: json['description'] ?? '',
    );
  }
}
