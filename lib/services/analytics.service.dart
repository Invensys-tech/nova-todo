import 'dart:convert';

import 'package:flutter_application_1/entities/habit.entity.dart';
import 'package:flutter_application_1/repositories/goal.repository.dart';
import 'package:flutter_application_1/repositories/habits.repository.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnalyticsService {
  SupabaseClient analyticsClient = supabaseClient;

  static Future<TotalBanksAnalytics> getBankAnalytics() async {
    try {
      int userId = (await AuthService().findSession())['id'];

      final banks = await supabaseClient
          .from('bank')
          .select('balance')
          .eq('userId', userId);

      final loans = await supabaseClient
          .from('loan')
          .select('amount, type')
          .eq('userId', userId);

      num balance = 0;
      num receivableLoan = 0;
      num payableLoan = 0;

      for (var bank in banks) {
        balance += bank['balance'];
      }

      for (var loan in loans) {
        if (loan['type'] == 'Receivable') {
          receivableLoan += loan['amount'];
        } else if (loan['type'] == 'Payable') {
          payableLoan += loan['amount'];
        }
      }

      return TotalBanksAnalytics(
          total: balance + receivableLoan + payableLoan,
          balance: balance,
          receivableLoan: receivableLoan,
          payableLoan: payableLoan
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<ExpenseAnalytics> getExpense() async {
    try {
      int userId = (await AuthService().findSession())['id'];

      final expenses = await supabaseClient
          .from('expense')
          .select('amount, type')
          .eq('userid', userId);

      num total = 0;
      num maybe = 0;
      num must = 0;
      num unwanted = 0;

      for (var expense in expenses) {
        if (expense['amount'] == null ||
            expense['amount'].runtimeType == Null) {
          continue;
        }

        total += expense['amount'];
        if (expense['type'] == 'Must') {
          must += expense['amount'];
        } else if (expense['type'] == 'Maybe') {
          maybe += expense['amount'];
        } else if (expense['type'] == 'Unwanted') {
          unwanted += expense['amount'];
        }
      }

      return ExpenseAnalytics(
        total: total,
        maybe: maybe,
        must: must,
        unwanted: unwanted,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getIncome() async {
    try {
      int userId = (await AuthService().findSession())['id'];

      final incomes = await supabaseClient
          .from('incomes')
          .select('amount, category')
          .eq('user_id', userId);

      num total = 0;

      Map<String, num> incomeTypes = {};

      for (var income in incomes) {
        if (income['amount'] == null ||
            income['amount'].runtimeType == 'Null') {
          continue;
        }

        total += income['amount'];
        incomeTypes[income['category']] =
            (incomeTypes[income['category']] ?? 0) + income['amount'];

        // if (income['type'] == 'Must') {
        //   must += income['amount'];
        // } else if (income['type'] == 'Maybe') {
        //   maybe += income['amount'];
        // } else if (income['type'] == 'Unwanted') {
        //   unwanted += income['amount'];
        // }
      }

      var sortedIncomes = incomeTypes.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value))
        ..toList();

      print(sortedIncomes);

      return {
        'total': total,
        'categorized': sortedIncomes.take(3).toList(),
      };
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<GoalAnalytics>> getGoalAnalytics() async {
    try {
      final goals = await GoalRepository().fetchAll();

      return goals.map((goal) =>
          GoalAnalytics(
              date: goal.deadline ?? getDateOnly(DateTime.now()),
              title: goal.name,
              percent: goal.getPercentage
          )).take(3).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<ExpenseAnalytics> getDailyExpenseSummary() async {
    try {
      try {
        int userId = (await AuthService().findSession())['id'];

        final expenses = await supabaseClient
            .from('expense')
            .select('amount, type')
            .eq('date', getDateOnly(DateTime.now()))
            .eq('userid', userId);

        num total = 0;
        num maybe = 0;
        num must = 0;
        num unwanted = 0;

        for (var expense in expenses) {
          if (expense['amount'] == null ||
              expense['amount'].runtimeType == Null) {
            continue;
          }

          total += expense['amount'];
          if (expense['type'] == 'Must') {
            must += expense['amount'];
          } else if (expense['type'] == 'Maybe') {
            maybe += expense['amount'];
          } else if (expense['type'] == 'Unwanted') {
            unwanted += expense['amount'];
          }
        }

        return ExpenseAnalytics(
          total: total,
          maybe: maybe,
          must: must,
          unwanted: unwanted,
        );
      } catch (e) {
        print(e);
        rethrow;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getDailyIncomeSummary() async {
    try {
      int userId = (await AuthService().findSession())['id'];

      final incomes = await supabaseClient
          .from('incomes')
          .select('amount, category')
          .eq('date', getDateOnly(DateTime.now()))
          .eq('user_id', userId);

      num total = 0;

      Map<String, num> incomeTypes = {};

      for (var income in incomes) {
        if (income['amount'] == null ||
            income['amount'].runtimeType == 'Null') {
          continue;
        }

        total += income['amount'];
        incomeTypes[income['category']] =
            (incomeTypes[income['category']] ?? 0) + income['amount'];

        // if (income['type'] == 'Must') {
        //   must += income['amount'];
        // } else if (income['type'] == 'Maybe') {
        //   maybe += income['amount'];
        // } else if (income['type'] == 'Unwanted') {
        //   unwanted += income['amount'];
        // }
      }

      var sortedIncomes = incomeTypes.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value))
        ..toList();

      print(sortedIncomes);

      return {
        'total': total,
        'categorized': sortedIncomes.take(3).toList(),
      };
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<Habit>> getHabitAnalytics() async {
    try {
      final habits = await HabitsRepository().fetchHabitsByDate(DateTime.now());

      return habits;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

class TotalBanksAnalytics {
  final num total;
  final num balance;
  final num receivableLoan;
  final num payableLoan;

  TotalBanksAnalytics({
    required this.total,
    required this.balance,
    required this.receivableLoan,
    required this.payableLoan,
  });
}

class ExpenseAnalytics {
  final num total;
  final num must;
  final num maybe;
  final num unwanted;

  ExpenseAnalytics({
    required this.total,
    required this.maybe,
    required this.must,
    required this.unwanted,
  });
}

class GoalAnalytics {
  final String date;
  final String title;
  final double percent;

  GoalAnalytics({
    required this.date,
    required this.title,
    required this.percent,
  });
}

// total balance - table names (bank - balance, loan - (amount, type (Receivable, Payable)))
// banks
// receivable loan
// payable loan
// expense - by type (must, maybe, unwanted) - table names (expense - (amount, type(must, unwanted, maybe)))
// income - by type (must, maybe, unwanted)
//
