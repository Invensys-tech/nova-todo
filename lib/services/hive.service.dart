import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  late Box _box;

  Box get box => _box;
  // Todo: initialize it like the notification service
  Future<void> initHive({String boxName = 'test'}) async {
    _box = await Hive.openBox(boxName);
  }

  Future<void> upsertData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  Future<dynamic> getData(String key) async {
    await _box.get(key, defaultValue: null);
  }

  Future<void> deleteData(String key) async {
    await _box.delete(key);
  }

  Future<void> clearData() async {
    await _box.clear();
  }
}
