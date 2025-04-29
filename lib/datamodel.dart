import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';

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
  num amount;
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
      amount: json['amount'] as num,
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
  num amount;
  String type;
  DateTime date;
  int parentId;
  String? source;

  ChildLoan({
    required this.amount,
    required this.date,
    required this.id,
    required this.paidFrom,
    required this.parentId,
    required this.specificFrom,
    required this.type,
    this.source,
  });

  factory ChildLoan.fromJson(Map<String, dynamic> json) {
    return ChildLoan(
      amount: json['amount'] as num,
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as int,
      type: json['type'] as String,
      paidFrom: json['paidFrom'] as String,
      specificFrom: json['specificFrom'] as String,
      parentId: json['parentId'] as int,
      source: json['source'] as String?,
    );
  }
}

class Bank {
  int id;
  num balance;
  String accountHolder;
  num accountNumber;
  int userId;
  String accountBank;
  String branch;
  String accountType;

  Bank({
    required this.accountBank,
    required this.accountHolder,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.branch,
    required this.id,
    required this.userId,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      accountBank: json['accountBank'] as String,
      accountHolder: json['accountHolder'] as String,
      accountNumber: json['accountNumber'] as num,
      accountType: json['accountType'] as String,
      balance: json['balance'] as num,
      branch: json['branch'] as String,
      id: json['id'] as int,
      userId: json['userId'] as int,
    );
  }
}

class Goal {
  int id;
  String name;
  String term;
  String status;
  String description;
  String priority;
  String? deadline;
  Map<String, dynamic> motivation;
  Map<String, dynamic> finance;
  List<SubGoal> subGoals;
  List<Journal> journals;

  Goal({
    required this.description,
    required this.finance,
    required this.id,
    required this.motivation,
    required this.name,
    required this.priority,
    required this.status,
    required this.term,
    required this.subGoals,
    required this.journals,
    this.deadline,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      description: json['description'] as String,
      finance: json['finance'] as Map<String, dynamic>,
      id: json['id'] as int,
      motivation: json['motivation'] as Map<String, dynamic>,
      name: json['name'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      term: json['term'] as String,
      deadline: json['deadline'] as String?,
      subGoals:
          json['sub_goal'] == Null || json['sub_goal'] == null
              ? []
              : (json['sub_goal'] as List<dynamic>)
                  .map((e) => SubGoal.fromJson(e))
                  .toList(),
      journals:
          json['goal_journal'] == Null || json['goal_journal'] == null
              ? []
              : (json['goal_journal'] as List<dynamic>)
                  .map((e) => Journal.fromJson(e))
                  .toList(),
    );
  }

  double get getPercentage {
    final allTasks = subGoals.expand((sg) => sg.tasks).toList();

    if (allTasks.isEmpty) return 0;

    final completedTasks = allTasks.where((task) => task.status).length;

    return (completedTasks / allTasks.length) * 100;
  }

  Widget? get isShortTerm => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['finance'] = finance;
    data['id'] = id;
    data['motivation'] = motivation;
    data['name'] = name;
    data['priority'] = priority;
    data['status'] = status;
    data['term'] = term;
    data['deadline'] = deadline;
    return data;
  }
}

class SubGoal {
  final String goal;
  final int id;
  final int goalId;
  final dynamic deadline;
  final List<Task> tasks;
  final dynamic? created_at;
  // final DateTime deadline;

  SubGoal({
    required this.goal,
    required this.id,
    required this.goalId,
    required this.tasks,
    this.created_at,
    required this.deadline,
    // required this.deadline,
  });

  factory SubGoal.fromJson(Map<String, dynamic> json) {
    return SubGoal(
      goal: json['goal'] as String,
      id: json['id'] as int,
      goalId: json['goalId'] as int,
      created_at: json['created_at'],
      deadline: json['deadline'],
      tasks:
          json['sub_goal_task'] == Null || json['sub_goal_task'] == null
              ? []
              : (json['sub_goal_task'] as List<dynamic>)
                  .map((e) => Task.fromJson(e))
                  .toList(),
      // deadline: DateTime.parse(json['deadline'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goal'] = goal;
    data['id'] = id;
    data['goalId'] = goalId;
    data['tasks'] = tasks.map((task) => task.toJson()).toList();
    data['deadline'] = deadline;
    return data;
  }
}

class Task {
  int? id;
  final String name;
  final int subGoalId;
  bool status;

  Task({
    this.id,
    required this.name,
    required this.status,
    required this.subGoalId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as bool,
      subGoalId: json['subGoalId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
    data['subGoalId'] = subGoalId;
    return data;
  }
}

class Journal {
  // DateTime? date;
  final String journal;
  int? goalId;
  int? id;

  Journal({required this.journal, this.goalId, this.id});

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      // date: DateTime.parse(json['date'] as String),
      journal: jsonEncode(json['journal']),
      id: json['id'] as int,
    );

    /// Converts the `Journal` instance into a JSON-compatible map.
    ///
    /// This method serializes the `journal` and `goalId` properties of the `Journal`
    /// instance into a map format that can be used for JSON encoding.
    ///
    /// Returns a `Map<String, dynamic>` representing the `Journal` object.
    /// Throws an exception if any error occurs during serialization.
  }

  Map<String, dynamic> toJson() {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      // data['date'] = date;

      data['journal'] = {"journal": journal};
      data['goalId'] = goalId;

      return data;
    } catch (e) {
      print("----------------------Issue in the model------------------");
      print(e);
      rethrow;
    }
  }
}
