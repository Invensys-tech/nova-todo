import 'package:supabase_flutter/supabase_flutter.dart';

enum Entities {
  GOAL("goal"),
  EXPENSE("expense"),
  LOAN("loan"),
  BANK("bank"),
  SUBGOAL_TASK("sub_goal_task"),
  JOURNAL("goal_journal"),
  NOTE('notes');

  final String dbName;

  const Entities(this.dbName);
}

SupabaseClient supabaseClient = Supabase.instance.client;
// dynamic goalClient = Supabase.instance.client.from('goal');
// dynamic expenseClient = Supabase.instance.client.from('expense');
// dynamic loanClient = Supabase.instance.client.from('loan');
// dynamic bankClient = Supabase.instance.client.from('bank');
