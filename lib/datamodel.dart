class User {
  int id;
  DateTime createdAt;
  String name;
  String email;
  String phoneNumber;

  User({
    required this.createdAt,
    required this.email,
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return (User(
      id: json['id'] as int,
      createdAt: json['created_at'] as DateTime,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    ));
  }
}

class Expense {
  int id;
  String expenseName;
  String category;
  String type;
  DateTime date;
  String paidBy;
  String? bankAccount;
  String description;
  num amount;
  int userId;

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
    required this.userId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return (Expense(
      amount: json['amount'] as num,
      bankAccount: json['bankAccount'] as String?,
      category: json['category'] as String,
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String),
      paidBy: json['paidBy'] as String,
      description: json['description'] as String,
      userId: json['userid'] as int,
      expenseName: json['expenseName'] as String,
      id: json['id'] as int,
    ));
  }
}

class Loan {
  int id;
  String loanerName;
  double amount;
  String type;
  String phoneNumber;
  String bank;
  DateTime date;
  int userId;

  Loan({
    required this.amount,
    required this.bank,
    required this.date,
    required this.id,
    required this.loanerName,
    required this.phoneNumber,
    required this.type,
    required this.userId,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      amount: json['amount'] as double,
      bank: json['bank'] as String,
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as int,
      loanerName: json['loanerName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      type: json['type'] as String,
      userId: json['userId'] as int,
    );
  }
}

class ChildLoan {
  int id;
  String paidFrom;
  String specificFrom;
  double amount;
  String type;
  DateTime date;
  int parentId;

  ChildLoan({
    required this.amount,
    required this.date,
    required this.id,
    required this.paidFrom,
    required this.parentId,
    required this.specificFrom,
    required this.type,
  });

  factory ChildLoan.fromJson(Map<String, dynamic> json) {
    return ChildLoan(
      amount: json['amount'] as double,
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as int,
      type: json['type'] as String,
      paidFrom: json['paidFrom'] as String,
      specificFrom: json['specificFrom'] as String,
      parentId: json['parentId'] as int,
    );
  }
}
