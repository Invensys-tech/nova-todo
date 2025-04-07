// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'dart:convert';

import 'package:flutter_application_1/entities/user.entity.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class AuthService {
  // final SupabaseClient _supabaseClient = supabaseClient;

  // Future<AuthResponse> signInWithPhoneNumber(
  //   String email,
  //   String password,
  // ) async {
  //   return await _supabaseClient.auth.signInWithPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  // Future<AuthResponse> signUpWithPhoneNumber(
  //   String email,
  //   String password,
  // ) async {
  //   return await _supabaseClient.auth.signUp(email: email, password: password);
  // }

  // Future<void> signOut() async {
  //   await _supabaseClient.auth.signOut();
  // }

  // String? getCurrentUser() {
  //   final session = _supabaseClient.auth.currentSession;
  //   final user = session?.user;
  //   return user?.email;
  // }

  Future<void> signUp(String phoneNumber, String password) async {
    try {
      // Todo: hash password
      String otp = generateRandomString(5);
      print(otp);
      UserRepository().createUser(phoneNumber, password, otp);
      NotificationService().showNotification(-1, 'OTP', 'Your otp is $otp');
      // print(jsonEncode({'phoneNumber': phoneNumber, 'password': password}));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserEntity> initializeUser(
    String phoneNumber,
    String name,
    String gender,
    String otp,
  ) async {
    try {
      UserRepository userRepository = UserRepository();
      Map<String, dynamic> userData = await userRepository.fetchUser(
        phoneNumber,
      );

      if (userData['otp'] != otp) {
        throw Exception('Invalid otp');
      }

      Map<String, dynamic> data = await UserRepository().initializeUser(
        phoneNumber,
        name,
        gender,
      );

      UserEntity user = UserEntity.fromJson(data);
      storeSession(user);

      // print(jsonEncode(data));

      return UserEntity.fromJson(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserEntity> signIn(String phoneNumber, String password) async {
    try {
      Map<String, dynamic> data = await UserRepository().fetchUser(phoneNumber);

      // print(jsonEncode(data));

      // Todo: compare the hashed password
      if (password != data['password']) {
        throw Exception('Invalid password');
      }

      UserEntity user = UserEntity.fromJson(data);
      await storeSession(user);
      return user;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> logout() async {
    await deleteSession();
  }

  Future<String> findSession() async {
    HiveService hiveService = HiveService();
    await hiveService.initHive(boxName: 'session');
    Map<String, dynamic> session = await hiveService.getData('user');
    return session['id'];
  }

  Future<void> storeSession(UserEntity user) async {
    HiveService hiveService = HiveService();
    await hiveService.initHive(boxName: 'session');
    await hiveService.upsertData('user', user.toJson());
  }

  Future<void> deleteSession() async {
    HiveService hiveService = HiveService();
    await hiveService.initHive(boxName: 'session');
    await hiveService.deleteData('user');
  }
}
