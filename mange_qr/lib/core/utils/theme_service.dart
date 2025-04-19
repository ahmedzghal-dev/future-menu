import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class ThemeService {
  final _box = Get.find<SharedPreferences>();
  final _key = AppConstants.themeKey;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkMode => _loadThemeFromBox();

  bool _loadThemeFromBox() => _box.getBool(_key) ?? false;
  
  _saveThemeToBox(bool isDarkMode) => _box.setBool(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
} 