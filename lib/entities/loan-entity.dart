class Loan {
  int id;
  String loanerName;
  num amount;
  String phoneNumber;
  String type;
  String? bank;
  DateTime date;

  Loan({
    required this.id,
    required this.loanerName,
    required this.amount,
    required this.phoneNumber,
    required this.type,
    this.bank,
    required this.date,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return (Loan(
      id: json['id'] as int,
      loanerName: json['loanerName'] as String,
      amount: json['amount'] as num,
      phoneNumber: json['phoneNumber'] as String,
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String),
    ));
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['loanerName'] = loanerName;
    data['amount'] = amount;
    data['phoneNumber'] = phoneNumber;
    data['type'] = type;
    data['bank'] = bank;
    data['date'] = date;
    return data;
  }
}
