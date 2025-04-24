import 'dart:convert';

import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  Future<Map<String, dynamic>> createUser(
    String phoneNumber,
    String otp,
  ) async {
    try {
      String userId = generateUniqueId(null);
      print(userId);

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
    String endTime,
  ) async {
    try {
      final response = await supabaseClient
          .from(Entities.USER.dbName)
          .update({'name': name, 'gender': gender, 'sub_end_date': endTime})
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

  Future<void> addSubscription(int? days, String phoneNumber) async {
    try {
      final userData =
          await supabaseClient
              .from(Entities.USER.dbName)
              .select('created_at')
              .eq('phoneNumber', phoneNumber)
              .maybeSingle();

      if (userData == null) {
        throw Exception('User not found');
      }

      final createdAt = userData['created_at'];

      final createdAtDateTime = DateTime.parse(createdAt);
      final subscriptionEndDateTime = createdAtDateTime.add(
        Duration(days: 90),
      );

      final response = await supabaseClient
          .from(Entities.USER.dbName)
          .update({'sub_end_date': subscriptionEndDateTime.toIso8601String()})
          .eq('phoneNumber', phoneNumber)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception('Error adding subscription');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DateTime> getSubscriptionEndDate(String phoneNumber) async {
    try {
      final userData =
          await supabaseClient
              .from(Entities.USER.dbName)
              .select('sub_end_date')
              .eq('phoneNumber', phoneNumber)
              .maybeSingle();

      print(jsonEncode(userData));

      if (userData == null) {
        throw Exception('User not found');
      }

      if (userData['sub_end_date'] == null) {
        throw Exception('Subscription end date not found');
      }

      final subEndDate = userData['sub_end_date'];
      return DateTime.parse(subEndDate);
    } catch (e) {
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
