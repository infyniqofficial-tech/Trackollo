import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // 1. Create a reactive boolean so the Switch updates INSTANTLY
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 2. Load the saved state when the app starts
    isDarkMode.value = _box.read(_key) ?? true;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // 3. Helper to get the actual ThemeMode
  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    // 4. Flip the boolean immediately (UI updates now)
    isDarkMode.value = !isDarkMode.value;

    // 5. Change the actual theme (Background updates a split second later)
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

    // 6. Save to storage
    _box.write(_key, isDarkMode.value);
  }
}