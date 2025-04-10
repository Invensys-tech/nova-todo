// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'dart:convert';

import 'package:flutter_application_1/entities/user.entity.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/services/message.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:flutter_application_1/utils/enums.dart';
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

  Future<loginRoutes> signin(String phoneNumber) async {
    try {
      // Todo: hash password
      String otp = generateRandomString(5);
      print(otp);

      UserRepository userRepository = UserRepository();
      Map<String, dynamic>? userData = await userRepository.fetchUser(
        phoneNumber,
      );

      NotificationService().showNotification(-1, 'OTP', 'Your otp is $otp');

      if (userData == null) {
        UserRepository().createUser(phoneNumber, otp);
        return loginRoutes.SIGNUP;
      }

      await UserRepository().setOTP(phoneNumber, otp);

      return loginRoutes.LOGIN;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    try {
      // Todo: hash password

      UserRepository userRepository = UserRepository();
      Map<String, dynamic>? userData = await userRepository.fetchUser(
        phoneNumber,
      );

      if (userData == null) {
        return false;
      }

      if (userData['otp'] != otp) {
        print('wrong otp');
        print('${userData['otp']} != $otp');
        return false;
      }

      UserEntity user = UserEntity.fromJson(userData);
      storeSession(user);

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserEntity> initializeUser(
    String phoneNumber,
    String name,
    String gender,
  ) async {
    try {
      // print(phoneNumber);
      UserRepository userRepository = UserRepository();
      Map<String, dynamic>? userData = await userRepository.fetchUser(
        phoneNumber,
      );

      if (userData == null) {
        throw Exception('New data not found');
      }

      // if (userData['otp'] != otp) {
      //   throw Exception('Invalid otp');
      // }

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

  Future<UserEntity?> signIn(String phoneNumber, String password) async {
    try {
      Map<String, dynamic>? data = await UserRepository().fetchUser(
        phoneNumber,
      );

      // print(jsonEncode(data));

      if (data == null) {
        return null;
      }

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

  String generateOTP() => generateRandomString(5);

  Future<void> logout() async {
    await deleteSession();
  }

  Future<Map<String, dynamic>> findSession() async {
    HiveService hiveService = HiveService();
    await hiveService.initHive(boxName: 'session');
    Map<String, dynamic> session = await hiveService.getData('user');
    return session;
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
