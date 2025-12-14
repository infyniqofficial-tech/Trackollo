import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // Reactive boolean for switch UI and theme state
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the saved state when the app starts
    isDarkMode.value = _box.read(_key) ?? true;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    // Call update to ensure initial state is set
    update();
  }

  // Helper to get the actual ThemeMode
  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // Main method to change theme - called from UI
  void changeTheme(bool darkMode) {
    print('changeTheme called with: $darkMode, current: ${isDarkMode.value}');

    // Update the boolean
    isDarkMode.value = darkMode;

    // Change the actual theme
    Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);

    // Save to storage
    _box.write(_key, darkMode);

    // Notify GetBuilder widgets to rebuild
    update();

    print('Theme changed to: ${darkMode ? "Dark" : "Light"}');
  }

  // Toggle method for convenience
  void toggleTheme() {
    changeTheme(!isDarkMode.value);
  }
}