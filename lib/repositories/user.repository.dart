import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  Future<Map<String, dynamic>> createUser(
    String phoneNumber,
    String otp,
  ) async {
    try {
      final response = await supabaseClient
          .from(Entities.USER.dbName)
          .insert({'phoneNumber': phoneNumber, 'otp': otp})
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating user');
      }

      final data =
          await supabaseClient
              .from(Entities.USER.dbName)
              .select('*')
              .eq('phoneNumber', phoneNumber)
              .limit(1)
              .single();

      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> initializeUser(
    String phoneNumber,
    String name,
    String gender,
  ) async {
    try {
      final response = await supabaseClient
          .from(Entities.USER.dbName)
          .update({'name': name, 'gender': gender})
          .eq('phoneNumber', phoneNumber)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error updating user');
      }

      final data =
          await supabaseClient
              .from(Entities.USER.dbName)
              .select()
              .eq('phoneNumber', phoneNumber)
              .limit(1)
              .single();

      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchUser(String phoneNumber) async {
    try {
      final data =
          await supabaseClient
              .from(Entities.USER.dbName)
              .select()
              .eq('phoneNumber', phoneNumber)
              // .limit(1)
              .maybeSingle();

      // print('fetch user');
      // print(jsonEncode(data));

      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<dynamic>> fetchUsers() async {
    try {
      final data = await supabaseClient.from(Entities.USER.dbName).select();
      // print(jsonEncode(data));
      return data;
    } catch (e) {
      // print('error fetching the users');
      print(e);
      rethrow;
    }
  }

  Future<void> setOTP(String phoneNumber, String otp) async {
    try {
      final response = await supabaseClient
          .from(Entities.USER.dbName)
          .update({'otp': otp})
          .eq('phoneNumber', phoneNumber)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error creating otp');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
