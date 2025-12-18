import 'package:get/get.dart';
import 'schedule_post_controller.dart';

class SchedulePostBinding extends Bindings {
  @override
  void dependencies() {
    // LazyPut ensures the controller is created only when the screen is first built
    Get.lazyPut<SchedulePostController>(
          () => SchedulePostController(),
    );
  }
}