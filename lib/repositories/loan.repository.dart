import 'package:flutter_application_1/entities/loan-entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class LoanRepository {
  Future<Loan> getSingleLoan(int id) async {
    try {
      final data =
          await supabaseClient
              .from(Entities.LOAN.dbName)
              .select('*')
              .eq('id', id)
              .maybeSingle();
      if (data == null) {
        throw Error();
      }
      return Loan.fromJson(data);
    } catch (e) {
      print('Error in Fetching Loan: $e');
      throw Exception('Failed to fetch loan: $e');
    }
  }

  Future<dynamic> deleteParentLoan(int id) async {
    try {
      final data = await supabaseClient
          .from(Entities.LOAN.dbName)
          .delete()
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete loan: $e');
    }
  }
}
