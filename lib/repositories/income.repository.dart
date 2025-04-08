import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class IncomeRepository {
  Future<List<Income>> getIncome() async {
    try {
      final data = await supabaseClient
          .from(Entities.INCOME.dbName)
          .select("*");

      print("Fetched Income Data: $data"); // Print raw data for debugging

      return data.map((income) => Income.fromJson(income)).toList();
    } catch (e, stackTrace) {
      print('Error in Fetching Income: $e');
      print('StackTrace: $stackTrace'); // Print stack trace for more details
      rethrow;
    }
  }

  Future<Income> createIncome(Map<String, dynamic> income) async {
    try {
      final response = await supabaseClient
          .from(Entities.INCOME.dbName)
          .insert({
            'name': income['name'],
            'date': formatDate(income['date']),
            'category': income['category'],
            'paid_from': income['paid_from'],
            'specific_from': income['specific_from'],
            "amount": income['amount'],
            'user_id': income['user_id'],
            'description': income['description'],
          });
      final data = await supabaseClient
          .from(Entities.INCOME.dbName)
          .select('*');
      final lastItem = data[data.length - 1];
      return Income.fromJson(lastItem);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteIncome(int id) async {
    try {
      await supabaseClient.from(Entities.INCOME.dbName).delete().eq('id', id);

      print("Income with ID $id deleted successfully");
    } catch (e) {
      print('Error deleting income with ID $id: $e');
      rethrow;
    }
  }

  Future<Income> editIncome(int id, Map<String, dynamic> updatedIncome) async {
    try {
      await supabaseClient
          .from(Entities.INCOME.dbName)
          .update({
            'name': updatedIncome['name'],
            'date': formatDate(updatedIncome['date']),
            'category': updatedIncome['category'],
            'paid_from': updatedIncome['paid_from'],
            'specific_from': updatedIncome['specific_from'],
            'amount': updatedIncome['amount'],
            'description': updatedIncome['description'],
          })
          .eq('id', id);

      final data =
          await supabaseClient
              .from(Entities.INCOME.dbName)
              .select('*')
              .eq('id', id)
              .single();

      return Income.fromJson(data);
    } catch (e) {
      print('Error updating income with ID $id: $e');
      rethrow;
    }
  }
}
