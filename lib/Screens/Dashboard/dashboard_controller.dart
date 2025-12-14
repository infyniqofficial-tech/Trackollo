import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Bottom Nav Index
  var tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Always start at home tab when dashboard is initialized
    tabIndex.value = 0;
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  // --- Mock Data for Home Screen ---
  final stats = [
    {"label": "Published", "count": "1", "icon": "assets/images/Onboarding/stats.png", "status": "published"},
    {"label": "Approved", "count": "1", "icon": "assets/images/Onboarding/check.png", "status": "approved"},
    {"label": "Pending", "count": "2", "icon": "assets/images/Onboarding/clock.png", "status": "pending"}, // Ensure you add a clock icon asset or use IconData logic
  ];

  final posts = [
    {
      "title": "New Product Launch - Summer Collection",
      "type": "POST",
      "status": "Pending",
      "date": "Dec 10 • 10:00 AM",
      // Using a placeholder color to simulate an image if asset is missing
      "color": 0xFFB0BEC5
    },
    {
      "title": "Instagram Reel - Behind the Scenes",
      "type": "REEL",
      "status": "Approved",
      "date": "Dec 12 • 2:00 PM",
      "color": 0xFF90CAF9
    },
    {
      "title": "Holiday Sale Story",
      "type": "STORY",
      "status": "Needs Changes",
      "date": "Dec 15 • 9:00 AM",
      "color": 0xFFEF9A9A
    },
    {
      "title": "Customer Testimonial Post",
      "type": "POST",
      "status": "Published",
      "date": "Dec 18 • 11:00 AM",
      "color": 0xFFE6EE9C
    },
  ];
}