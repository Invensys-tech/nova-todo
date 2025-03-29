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
import 'package:supabase_flutter/supabase_flutter.dart';

class Datamanager {
  Future<List<Expense>> fetchExpense() async {
    final data = await Supabase.instance.client.from('expense').select('*');
    // print(data);
    // Convert the returned list of maps into a list of Expense objects.
    return (data as List<dynamic>)
        .map((e) => Expense.fromJson(e as Map<String, dynamic>))
        .toList();
  }

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

  Future<List<Bank>> fetchBanks() async {
    final data = await Supabase.instance.client.from('bank').select('*');
    return (data as List<dynamic>)
        .map((e) => Bank.fromJson(e as Map<String, dynamic>))
        .toList();
  

  Future<List<Goal>> fetchGoals() async {
    final data = await Supabase.instance.client.from('goal').select('*');
    return data.map((e) => Goal.fromJson(e)).toList();
  }

  Future<List<Expense>> getExpense() async {
    return await fetchExpense();
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
}
