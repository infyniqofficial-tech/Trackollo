import 'package:get/get.dart';
import 'post_description_controller.dart';

class PostDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDescriptionController>(
          () => PostDescriptionController(),
    );
  }

}