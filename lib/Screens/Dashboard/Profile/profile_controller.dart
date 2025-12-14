import 'package:get/get.dart';
import 'package:infyniq_calander/Routes/app_routes.dart';

import '../../../Data/Themes/theme_controller.dart';
import '../dashboard_controller.dart';

class ProfileController extends GetxController {
  final ThemeController _themeController = Get.find<ThemeController>();

  // Access the reactive value directly
  bool get isDarkMode => _themeController.isDarkMode.value;

  void toggleTheme(bool value) {
    print('ProfileController toggleTheme called with: $value');
    // Call changeTheme with the exact value from the switch
    _themeController.changeTheme(value);
  }

  void logout() {
    // Add logout logic here
    print("Logging out...");
    try {
      final dashboardController = Get.find<DashboardController>();
      dashboardController.changeTabIndex(0);
    } catch (e) {
      print("Dashboard controller not found: $e");
    }

    // Navigate to login screen and remove all previous routes
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}