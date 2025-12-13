import 'package:get/get.dart';
import 'package:infyniq_calander/Screens/Authentication/Login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<LoginController>(() => LoginController(),);
  }
}
