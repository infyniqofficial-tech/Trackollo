import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infyniq_calander/Routes/app_routes.dart';

class LoginController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable for password visibility
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    // Add your login logic here
    print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");
    Get.toNamed(AppRoutes.DASHBOARD);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}