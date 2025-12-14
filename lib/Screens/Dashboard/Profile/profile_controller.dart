import 'package:get/get.dart';

import '../../../Data/Themes/theme_controller.dart';

class ProfileController extends GetxController {
  final ThemeController _themeController = Get.find<ThemeController>();

  // Access the reactive value directly
  bool get isDarkMode => _themeController.isDarkMode.value;

  void toggleTheme(bool value) {
    _themeController.toggleTheme();
    // No need to call update() manually if we use Obx in the view
  }

  void logout() {
    // Add logout logic here
    print("Logging out...");
  }
}