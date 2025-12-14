import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Data/Themes/app_colors.dart';
import '../../../Data/Themes/theme_controller.dart';
import '../../../Utils/Widgets/common_text_field.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get ThemeController to make the UI reactive to theme changes
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      // This forces rebuild when theme changes
      final _ = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: AppColors.primaryBgClr,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),

                // 1. Header Section
                Text(
                  "Welcome Back",
                  style: GoogleFonts.sora(
                    color: AppColors.primaryTextClr,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  "Sign in to continue managing your content",
                  style: GoogleFonts.sora(
                    color: AppColors.secondaryText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 5.h),

                // 2. Email Field
                CommonTextField(
                  label: "Email",
                  hintText: "Enter your email",
                  prefixIcon: CupertinoIcons.mail,
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 3.h),

                // 3. Password Field with Toggle Logic
                Obx(() => CommonTextField(
                  label: "Password",
                  hintText: "Enter your password",
                  prefixIcon: CupertinoIcons.lock,
                  obscureText: controller.isPasswordHidden.value,
                  controller: controller.passwordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: Colors.grey[500],
                      size: 20.sp,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                )),

                // 4. Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.sora(
                        color: AppColors.primaryBlue,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 3.h),

                // 5. Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 6.5.h,
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.sora(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 2.h),

                // 6. Footer (Sign Up)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.sora(
                        color: AppColors.secondaryText,
                        fontSize: 15.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Sign Up
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.sora(
                          color: AppColors.primaryBlue,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}