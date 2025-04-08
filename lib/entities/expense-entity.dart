class Expense {
  int id;
  String expenseName;
  String category;
  String type;
  DateTime date;
  String paidBy;
  String bankAccount;
  String description;
  num amount;
  Expense({
    required this.amount,
    required this.bankAccount,
    required this.category,
    required this.date,
    required this.description,
    required this.expenseName,
    required this.id,
    required this.paidBy,
    required this.type,
  });
  factory Expense.fromJson(Map<String, dynamic> json) {
    return (Expense(
      amount: json['amount'] as num,
      bankAccount: json['bankAccount'] as String,
      category: json['category'] as String,
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String),
      paidBy: json['paidBy'] as String,
      description: json['description'] as String,
      expenseName: json['expenseName'] as String,
      id: json['id'] as int,
    ));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['bankAccount'] = bankAccount;
    data['category'] = category;
    data['type'] = type;
    data['date'] = date;
    data['paidBy'] = paidBy;
    data['description'] = description;
    data['expenseName'] = expenseName;
    data['id'] = id;
    return data;
  }
}
