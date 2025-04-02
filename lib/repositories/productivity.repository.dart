import 'package:flutter_application_1/entities/productivity-entity.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class ProductivityRepository {
  Future<List<Productivity>> getProductivity() async {
    try {
      final data = await supabaseClient
          .from(Entities.PRODUCTIVITY.dbName)
          .select('*');
      return data
          .map((productivity) => Productivity.fromJson(productivity))
          .toList();
    } catch (e) {
      throw Exception("Error getting productivity!");
    }
  }

  Future<Productivity> createProductivity(
    Map<String, dynamic> productivity,
  ) async {
    try {
      final response =
          await supabaseClient.from(Entities.PRODUCTIVITY.dbName).insert({
            'title': productivity['title'],
            'description': productivity['description'],
            'frequency': productivity['frequency'],
            'time': productivity['time'],
            'user_id': productivity['user_id'],
          }).select();

      final data = await supabaseClient
          .from(Entities.PRODUCTIVITY.dbName)
          .select('*');

      final lastItem = data[data.length - 1];

      return Productivity.fromJson(lastItem);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
