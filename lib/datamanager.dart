// import 'dart:convert';

// import 'package:flutter_application_1/datamodel.dart';
// import 'package:flutter_application_1/utils/helpers.dart';
// import 'package:flutter_application_1/utils/supabase.clients.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class Datamanager {
//   Future<List<Expense>> fetchExpenseWithDateFilter(DateTime dateTime) async {
//     final data = await Supabase.instance.client
//         .from('expense')
//         .select('*')
//         .eq('date', getDateOnly(dateTime));

//     return (data as List<dynamic>)
//         .map((e) => Expense.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }

//   Future<List<Expense>> getExpense({DateTime? dateTime}) async {
//     if (dateTime != null) {
//       return await fetchExpenseWithDateFilter(dateTime);
//     } else {
//       return await fetchExpense();
//     }
//   }

//   Future<List<Expense>> fetchExpense() async {
//     final data = await Supabase.instance.client.from('expense').select('*');
//     return (data as List<dynamic>)
//         .map((e) => Expense.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }

//   Future<List<Loan>> fetchLoan() async {
//     final data = await Supabase.instance.client.from('loan').select('*');
//     return (data as List<dynamic>)
//         .map((e) => Loan.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }

//   Future<List<ChildLoan>> fetchChildLoans(int id) async {
//     final data = await Supabase.instance.client
//         .from('single_loan')
//         .select('*')
//         .eq('parentId', id);
//     return (data as List<dynamic>)
//         .map((e) => ChildLoan.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }

//   Future<List<Loan>> getLoansByName(String name) async {
//     final response = await supabaseClient
//         .from('loan')
//         .select()
//         .eq('loanerName', name);

//     return (response as List).map((e) => Loan.fromJson(e)).toList();
//   }

//   Future<List<Bank>> fetchBanks() async {
//     final data = await Supabase.instance.client.from('bank').select('*');
//     return (data as List<dynamic>)
//         .map((e) => Bank.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }

//   Future<Map<String, dynamic>> fetchBankView(int id, String name) async {
//     final supabase = Supabase.instance.client;

//     // 1. Fetch bank by ID
//     final bankResponse =
//         await supabase.from('bank').select('*').eq('id', id).single();

//     final bank = Bank.fromJson(bankResponse);

//     // 2. Fetch expenses where bankAccount == name
//     final expenses = await supabase
//         .from('expense')
//         .select('*')
//         .eq('bankAccount', name);

//     // 3. Fetch incomes where specific_from == name
//     final incomes = await supabase
//         .from('incomes')
//         .select('*')
//         .eq('specific_from', name);

//     return {'bank': bank, 'expenses': expenses, 'incomes': incomes};
//   }

//   Future<List<Goal>> fetchGoals() async {
//     final data = await Supabase.instance.client
//         .from('goal')
//         .select('*  ,sub_goal(*,  sub_goal_task(*))')
//         .order('created_at', ascending: false);
//     ;
//     print("///////////////////");
//     print(jsonEncode(data));
//     return data.map((e) => Goal.fromJson(e)).toList();
//   }

//   // Future<List<Expense>> getExpense() async {
//   //   return await fetchExpense();
//   // }

//   Future<List<Loan>> getLoan() async {
//     return await fetchLoan();
//   }

//   Future<List<ChildLoan>> getChildLoan(int id) async {
//     return await fetchChildLoans(id);
//   }

//   Future<List<Bank>> getBanks() async {
//     return await fetchBanks();
//   }

//   Future<List<Goal>> getGoals() async {
//     return await fetchGoals();
//   }
// }

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/entities/income-entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/hive.service.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Datamanager {
  final hiveService = HiveService();
  Future<List<Expense>> fetchExpenseWithDateFilter(DateTime dateTime) async {
    final data = await Supabase.instance.client
        .from('expense')
        .select('*, bank(*), partners(*)')
        .eq("userid", userId)
        .eq('date', getDateOnly(dateTime));

    print("lllllllllllllllllllllllllllll");

    for (final e in data) {
      print(e);
    }

    // print(
    //   (data as List<dynamic>)
    //       .map((e) => Expense.fromJson(e as Map<String, dynamic>))
    //       .toList(),
    // );

    return (data as List<dynamic>)
        .map((e) => Expense.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Expense>> fetchExpensesBetweenDates({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    // convert to "YYYY-MM-DD" (or whatever your getDateOnly produces)
    final start = getDateOnly(startDate);
    final end = getDateOnly(endDate);

    print("IN the datamager");
    print(start);
    print(end);

    final data = await Supabase.instance.client
        .from('expense')
        .select('*')
        .eq('userid', userId)
        .gte('date', start) // date >= start
        .lte('date', end) // date <= end
        .order('date', ascending: true);

    return (data as List<dynamic>)
        .map((e) => Expense.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Expense>> getExpense({
    DateTime? dateTime,
    bool? analytics = false,
    DateTime? endDate = null,
  }) async {
    try {
      print("My date time in the data manager");
      print(dateTime);
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      final isConnected =
          connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) |
              connectivityResult.contains(ConnectivityResult.ethernet);

      if (dateTime != null) {
        if (analytics == true) {
          return await fetchExpensesBetweenDates(
            startDate: dateTime,
            endDate: endDate ?? DateTime.now(),
          );
        }
        if (!isConnected) {
          // print('no connection');
          final oldExpenses = await getOfflineExpense();
          return oldExpenses
                  ?.where((e) => e.date == getDateOnly(dateTime))
                  .toList() ??
              [];
        }
        return await fetchExpenseWithDateFilter(dateTime);
      } else {
        // if (![
        //   ConnectivityResult.wifi,
        //   ConnectivityResult.mobile,
        //   ConnectivityResult.ethernet,
        // ].contains(connectivityResult)) {
        //   // print('no connection');
        //   final oldExpenses = await getOfflineExpense();
        //   return oldExpenses ?? [];
        // }

        // else {
        return await fetchExpense();
        // }
        // print('connection');
      }
    } catch (e) {
      print('error type');
      print(e.runtimeType);
      print('error');
      print(e);
      rethrow;
    }
  }

  Future<List<Expense>>? getOfflineExpense() async {
    await hiveService.initHive(boxName: 'expense');
    final List<dynamic>? expenses = await hiveService.getData('all');
    return expenses?.map((expense) => Expense.fromJson(expense)).toList() ?? [];
  }

  Future<List<Income>> getOfflineIncome() async {
    await hiveService.initHive(boxName: 'income');
    final List<dynamic>? incomes = await hiveService.getData('all');
    return incomes?.map((income) => Income.fromJson(income)).toList() ?? [];
  }

  createOfflineExpense(Expense expense) async {
    await hiveService.initHive(boxName: 'expense');
    final List<Map<String, dynamic>> expenses = await hiveService.getData(
      'all',
    );

    await hiveService.upsertData('all', expenses);
  }

  Future<List<Expense>> fetchExpense() async {
    final data = await Supabase.instance.client
        .from('expense')
        .select('*')
        .eq('userid', userId);
    return (data as List<dynamic>)
        .map((e) => Expense.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Loan>> fetchLoan() async {
    final data = await Supabase.instance.client
        .from('loan')
        .select('*')
        .eq("userId", (await AuthService().findSession())['id']);
    return (data as List<dynamic>)
        .map((e) => Loan.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ChildLoan>> fetchChildLoans(int id) async {
    final data = await Supabase.instance.client
        .from('single_loan')
        .select('*')
        .eq('parentId', id);
    return (data as List<dynamic>)
        .map((e) => ChildLoan.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Loan>> getLoansByName(String name) async {
    final response = await supabaseClient
        .from('loan')
        .select()
        .eq('loanerName', name);

    return (response as List).map((e) => Loan.fromJson(e)).toList();
  }

  Future<List<Bank>> fetchBanks() async {
    final data = await Supabase.instance.client
        .from('bank')
        .select('*')
        .eq("userId", userId);
    return (data as List<dynamic>)
        .map((e) => Bank.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> fetchBankView(int id, String name) async {
    final supabase = Supabase.instance.client;

    // 1. Fetch bank by ID
    final bankResponse =
        await supabase.from('bank').select('*').eq('id', id).single();

    final bank = Bank.fromJson(bankResponse);

    // 2. Fetch expenses where bankAccount == name

    final expenses = await supabase
        .from('expense')
        .select('*')
        .eq('bankAccount', id)
        .order('date', ascending: true);
    ;

    // 3. Fetch incomes where specific_from == name
    final incomes = await supabase
        .from('incomes')
        .select('*')
        .eq('specific_from', id)
        .order('date', ascending: true);
    ;

    return {'bank': bank, 'expenses': expenses, 'incomes': incomes};
  }

  Future<List<Goal>> fetchGoals() async {
    print("My user id");
    print(userId);
    final data = await Supabase.instance.client
        .from('goal')
        .select('*  ,sub_goal(*,  sub_goal_task(*))')
        .eq('userId', userId)
        .order('created_at', ascending: false);
    return (data as List<dynamic>).map((e) => Goal.fromJson(e)).toList();
  }

  Future<List<Loan>> getLoan() async {
    return await fetchLoan();
  }

  Future<List<ChildLoan>> getChildLoan(int id) async {
    return await fetchChildLoans(id);
  }

  Future<List<Bank>> getBanks() async {
    return await fetchBanks();
  }

  Future<List<Goal>> getGoals() async {
    return await fetchGoals();
  }

  double totalBankExpense(List<Expense> expenses) {
    print("I am the idiot");
    print(expenses);
    return expenses
        .where((e) => e.paidBy == "Bank")
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  double totalBankIncome(List<Income> incomes) {
    print("No you are");
    print(incomes);
    return incomes
        .where((i) => i.paidBy == 'Bank')
        .fold(0.0, (sum, i) => sum + i.amount);
  }
}
