import 'package:supabase_flutter/supabase_flutter.dart';

class StreakService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getStreaksForProductivity(
    int productivityId,
  ) async {
    final response = await _client
        .from('streaks')
        .select()
        .eq('productivity_id', productivityId);
    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getStreaksForProductivityHabit(
    int productivityHabitId,
  ) async {
    final response = await _client
        .from('streaks')
        .select()
        .eq('productivity_habit_id', productivityHabitId);
    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }
}
