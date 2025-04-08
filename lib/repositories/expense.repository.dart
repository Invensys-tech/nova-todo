import 'package:flutter_application_1/entities/expense-entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class ExpenseRepository {
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

  Future<dynamic> deleteExpense(int id) async {
    try {
      final data = await supabaseClient
          .from(Entities.EXPENSE.dbName)
          .delete()
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }
}
