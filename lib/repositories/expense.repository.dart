import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/entities/expense-entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseRepository {
  Future<List<Expense>> fetchAll() async {
    try {
      final data = await supabaseClient
          .from(Entities.EXPENSE.dbName)
          .select('*');
      return data.map((expense) => Expense.fromJson(expense)).toList();
    } catch (e) {
      throw Exception('Failed to fetch expenses: $e');
    }
  }

  Future<List<Expense>> getExp(DateTime? dateTime) async {
    final HiveService _hiveService = HiveService();

    try {
      final List<dynamic> rawData;
      print('Original dateTime: $dateTime');

      DateTime? queryDate = dateTime;

      if (queryDate != null) {
        rawData = await supabaseClient
            .from(Entities.INCOME.dbName)
            .select("*")
            .eq('userid', userId)
            .eq('date', getDateOnly(queryDate));
      } else {
        rawData = await supabaseClient.from(Entities.INCOME.dbName).select("*");
      }

      print("Fetched Income Data: $rawData");

      final List<Expense> incomeList =
          rawData.map((income) => Expense.fromJson(income)).toList();

      return incomeList;
    } catch (e, stackTrace) {
      print('Error in Fetching Income: $e');
      print('StackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<Expense> getSingleExpense(int id) async {
    try {
      final data =
          await supabaseClient
              .from(Entities.EXPENSE.dbName)
              .select('*')
              .eq('id', id)
              .maybeSingle();
      if (data == null) {
        throw Error();
      }
      print("======================");
      print(data);
      return Expense.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch expense: $e');
    }
  }

  Future<dynamic> deleteExpense(int id, int? bankId, num? amouont) async {
    print("-----------------------");
    print(bankId);
    print(amouont);
    try {
      if (bankId != null) {
        final response =
            await Supabase.instance.client
                .from('bank')
                .select('balance')
                .eq('id', bankId)
                .single();

        final currentBalance = response['balance'] as num;
        final newBalance = currentBalance + amouont!;

        await Supabase.instance.client
            .from('bank')
            .update({'balance': newBalance})
            .eq('id', bankId);
      } else {}

      final data = await supabaseClient
          .from(Entities.EXPENSE.dbName)
          .delete()
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  /// Returns a map with total amount of each expense type
  Future<Map<String, dynamic>> getExpenseTypeTotals(
    DateTime? dateTime,
    DateTime? endDate,
  ) async {
    try {
      final expenses = await Datamanager().getExpense(
        dateTime: dateTime,
        endDate: endDate,
        analytics: true,
      );
      print("======================");
      print(expenses);
      final Map<String, double> typeTotals = {
        'Must': 0.0,
        'Maybe': 0.0,
        'Unwanted': 0.0,
      };

      for (var expense in expenses) {
        if (typeTotals.containsKey(expense.type)) {
          typeTotals[expense.type] =
              typeTotals[expense.type]! + (expense.amount ?? 0);
        }
      }

      return {
        "total": typeTotals.values.reduce((a, b) => a + b),
        "type": typeTotals,
      };
    } catch (e) {
      throw Exception('Failed to total expense amounts: $e');
    }
  }

  Future<List<String>> getExpenseCategory() async {
    try {
      final data = await Supabase.instance.client
          .from('expense')
          .select('category')
          .eq("userid", userId);
      print("I senf");
      print(data.map((e) => e['category'] as String).toSet().toList());
      return data.map((e) => e['category'] as String).toSet().toList();
    } catch (e) {
      throw Exception('Failed to fetch expense: $e');
    }
  }

  Future<Map<String, Map<String, dynamic>>> getExpenseCategoryTotals(
    DateTime? dateTime,
    DateTime? endDate,
  ) async {
    try {
      print("Dates in database");
      print(dateTime);
      print(endDate);
      // Fetch all expenses using your existing fetchAll function.
      final expenses = await Datamanager().getExpense(
        dateTime: dateTime,
        endDate: endDate,
        analytics: true,
      );

      print("From the database");
      print(expenses);

      // Prepare an empty map to accumulate counts and totals.
      final Map<String, Map<String, dynamic>> categoryTotals = {};

      // Loop through each expense.
      for (var expense in expenses) {
        // Use a default category if expense.category is null or empty.
        final String categoryName =
            (expense.category?.trim().isNotEmpty ?? false)
                ? expense.category!
                : "Unknown";

        // Initialize the category in the map if not already present.
        if (!categoryTotals.containsKey(categoryName)) {
          categoryTotals[categoryName] = {"count": 0, "totalAmount": 0.0};
        }

        // Increment the count.
        categoryTotals[categoryName]!["count"]++;
        // Add the amount. In case amount is null, use 0.
        categoryTotals[categoryName]!["totalAmount"] += expense.amount ?? 0.0;
      }

      print("From the database");

      print(categoryTotals);

      return categoryTotals;
    } catch (e) {
      throw Exception('Failed to compute category totals: $e');
    }
  }
}
