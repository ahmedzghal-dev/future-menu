import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends GetxService {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  // Save string data
  Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  // Get string data
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Save boolean data
  Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // Get boolean data
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Save object data (converts to JSON string)
  Future<bool> saveObject(String key, Map<String, dynamic> value) async {
    return await _prefs.setString(key, json.encode(value));
  }

  // Get object data (parses from JSON string)
  Map<String, dynamic>? getObject(String key) {
    final String? jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  // Remove data
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Clear all data
  Future<bool> clear() async {
    return await _prefs.clear();
  }
} 