import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infyniq_calander/Utils/asset_strings.dart';
import '../../Routes/app_routes.dart';

class OnboardingController extends GetxController {
  RxInt pageIndex = 0.obs;
  final PageController pageController = PageController();

  final List<Map<String, dynamic>> pages = [
    {
      "title": "Content Calendar",
      "subtitle":
          "Visualize your entire content strategy with monthly and weekly calendar views. Never miss a scheduled post.",
      "image": AssetStrings.onboarding_1,
    },
    {
      "title": "Client Approvals",
      "subtitle":
          "Streamline your approval workflow. Get instant feedback and make revisions in real-time.",
      "image": AssetStrings.onboarding_2,
    },
    {
      "title": "Smart Notifications",
      "subtitle":
          "Stay on top of deadlines and approval requests with intelligent notifications.",
      "image": AssetStrings.onboarding_3,
    },
    {
      "title": "Track Performance",
      "subtitle":
          "Monitor your content performance and optimize your strategy with comprehensive analytics.",
      "image": AssetStrings.onboarding_4,
    },
  ];

  void updatePage(int index) {
    pageIndex.value = index;
  }

  void nextPage() {
    if (pageIndex.value == pages.length - 1) {
      completeOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  void skip() {
    completeOnboarding();
  }

  void completeOnboarding() {
    final box = GetStorage();
    box.write('isFirstTime', false);
    Get.offAllNamed(AppRoutes.LOGIN); // Navigate to Login later
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
