import 'package:get/get.dart';
import 'package:infyniq_calander/Screens/Authentication/Login/login_binding.dart';
import 'package:infyniq_calander/Screens/Authentication/Login/login_screen.dart';
import '../Screens/Authentication/Login/Schedule Post/schedule_post_binding.dart';
import '../Screens/Authentication/Login/Schedule Post/schedule_post_screen.dart';
import '../Screens/Dashboard/dashboard_binding.dart';
import '../Screens/Dashboard/dashboard_screen.dart';
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
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.SCHEDULE_POST,
      page: () => const SchedulePostScreen(),
      binding: SchedulePostBinding(),
    ),
  ];
}
