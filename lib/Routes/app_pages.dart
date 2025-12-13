import 'package:get/get.dart';
import '../Screens/Onboarding/onboarding_binding.dart';
import '../Screens/Onboarding/onboarding_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    // Add login page later
  ];
}
