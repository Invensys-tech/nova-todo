import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/finance/expense/addexpense.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class IncomeRepository {
  String formatDate(String date) {
    List<String> parts = date.split('-'); // Split DD-MM-YYYY
    return '${parts[2]}-${parts[1]}-${parts[0]}'; // Convert to YYYY-MM-DD
  }

  Future<List<Income>> getIncome(DateTime? dateTime) async {
    final HiveService _hiveService = HiveService();

    // await _hiveService.initHive(boxName: 'dateType');
    // final stored = await _hiveService.getData('dateType');
    // print('Stored date type: $stored');
    // final isEthiopian = stored == 'Ethiopian';

    try {
      final List<dynamic> rawData;
      print('Original dateTime: $dateTime');
      // print(isEthiopian);

      DateTime? queryDate = dateTime;

      // if (dateTime != null) {
      //   // Convert Ethiopian to Gregorian
      //   final etDate = ETDateTime(dateTime.year, dateTime.month, dateTime.day);
      //   final gregorian = etDate.convertToGregorian();
      //   queryDate = DateTime(gregorian.year, gregorian.month, gregorian.day);
      //   print('Converted to Gregorian: $queryDate');
      // }

      if (queryDate != null) {
        rawData = await supabaseClient
            .from(Entities.INCOME.dbName)
            .select("*")
            .eq('user_id', userId)
            .eq('date', getDateOnly(queryDate));
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
      print('Error in Fetching Income: $e');
      print('StackTrace: $stackTrace');
      rethrow;
    }
  }

  // Future<List<Income>> getIncome(DateTime? dateTime) async {
  //   final HiveService _hiveService = HiveService();

  //   await _hiveService.initHive(boxName: 'dateTime');

  //   final stored = await _hiveService.getData('dateType');
  //   try {
  //     final List<dynamic> rawData;
  //     print('oooooooooooooooooooooooooooo');
  //     print(dateTime);

  //     if (dateTime != null) {
  //       rawData = await supabaseClient
  //           .from(Entities.INCOME.dbName)
  //           .select("*")
  //           .eq('date', getDateOnly(dateTime));
  //     } else {
  //       rawData = await supabaseClient.from(Entities.INCOME.dbName).select("*");
  //     }

  //     print("Fetched Income Data: $rawData");

  //     final List<Income> incomeList =
  //         rawData
  //             .map((income) => Income.fromJson(income as Map<String, dynamic>))
  //             .toList();

  //     return incomeList;
  //   } catch (e, stackTrace) {
  //     print('Error in Fetching Income my Income He: $e');
  //     print('StackTrace: $stackTrace');
  //     rethrow;
  //   }
  // }

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
