// import 'package:flutter_application_1/datamodel.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class Datamanager {
//   List<Expense>? _expense;
//   fetchExpense() async {
//     var data = await Supabase.instance.client.from('expense').select('*');
//     print(data);
//     return data;
//   }

//   Future<List<Expense>> getExpense() async {
//     var exp = await fetchExpense();
//     return exp;
//   }
// }

import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Datamanager {
  Future<List<Expense>> fetchExpenseWithDateFilter(DateTime dateTime) async {
    final data = await Supabase.instance.client
        .from('expense')
        .select('*')
        .eq('date', getDateOnly(dateTime));

    return (data as List<dynamic>)
        .map((e) => Expense.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Expense>> getExpense({DateTime? dateTime}) async {
    if (dateTime != null) {
      return await fetchExpenseWithDateFilter(dateTime);
    } else {
      return await fetchExpense();
    }
  }

  Future<List<Expense>> fetchExpense() async {
    final data = await Supabase.instance.client.from('expense').select('*');
    return (data as List<dynamic>)
        .map((e) => Expense.fromJson(e as Map<String, dynamic>))
        .toList();
  }
  // Future<List<Expense>> fetchExpense() async {
  //   final data = await Supabase.instance.client.from('expense').select('*');
  //   // print(data);
  //   // Convert the returned list of maps into a list of Expense objects.
  //   return (data as List<dynamic>)
  //       .map((e) => Expense.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  Future<List<Loan>> fetchLoan() async {
    final data = await Supabase.instance.client.from('loan').select('*');
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
    final data = await Supabase.instance.client.from('bank').select('*');
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
        .eq('bankAccount', name);

    // 3. Fetch incomes where specific_from == name
    final incomes = await supabase
        .from('incomes')
        .select('*')
        .eq('specific_from', name);

    return {'bank': bank, 'expenses': expenses, 'incomes': incomes};
  }

  Future<List<Goal>> fetchGoals() async {
    final data = await Supabase.instance.client.from('goal').select('*');
    return data.map((e) => Goal.fromJson(e)).toList();
  }

  // Future<List<Expense>> getExpense() async {
  //   return await fetchExpense();
  // }

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
}
