import 'package:get/get.dart';
import 'Media/media_controller.dart';
import 'Profile/profile_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<MediaController>(() => MediaController());
  }
}