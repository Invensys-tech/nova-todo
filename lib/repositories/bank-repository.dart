import 'package:flutter_application_1/entities/bank-entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class BankRepository {
  Future<BankEntity> getSinglrBank(int id) async {
    try {
      final data =
          await supabaseClient
              .from('bank')
              .select('*')
              .eq('id', id)
              .maybeSingle();
      if (data == null) {
        throw Error();
      }
      return BankEntity.fromJson(data);
    } catch (e) {
      print('Error in Fetching Bank: $e');
      throw Exception('Failed to fetch bank: $e');
    }
  }

  Future<dynamic> deleteBank(int id) async {
    try {
      final data = await supabaseClient.from('bank').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete bank: $e');
    }
  }
}
