
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyniq_calander/Screens/Authentication/Login/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Login"),),
    );
  }
}
