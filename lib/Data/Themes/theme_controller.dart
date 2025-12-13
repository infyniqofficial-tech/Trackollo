import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get themeMode {

    bool isDark = _box.read(_key) ?? true;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      _box.write(_key, false);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      _box.write(_key, true);
    }
  }
}