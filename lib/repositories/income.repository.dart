import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class IncomeRepository {
  String formatDate(String date) {
    List<String> parts = date.split('-'); // Split DD-MM-YYYY
    return '${parts[2]}-${parts[1]}-${parts[0]}'; // Convert to YYYY-MM-DD
  }

  Future<List<Income>> getIncome(DateTime? dateTime) async {
    try {
      final List<dynamic> rawData;
      print('oooooooooooooooooooooooooooo');
      print(dateTime);

      if (dateTime != null) {
        rawData = await supabaseClient
            .from(Entities.INCOME.dbName)
            .select("*")
            .eq('date', getDateOnly(dateTime));
      } else {
        rawData = await supabaseClient.from(Entities.INCOME.dbName).select("*");
      }

      print("Fetched Income Data: $rawData");

      final List<Income> incomeList =
          rawData
              .map((income) => Income.fromJson(income as Map<String, dynamic>))
              .toList();

      return incomeList;
    } catch (e, stackTrace) {
      print('Error in Fetching Income my Income He: $e');
      print('StackTrace: $stackTrace');
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
