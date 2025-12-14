import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infyniq_calander/Data/Themes/app_colors.dart';
import 'package:infyniq_calander/Data/Themes/theme_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CommonTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label Text (e.g., "Email")
          Text(
            label,
            style: GoogleFonts.sora(
              color: AppColors.primaryTextClr,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          // Input Field
          TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: GoogleFonts.sora(
              color: AppColors.primaryTextClr,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Get.isDarkMode ? AppColors.inputFieldBg : Colors.grey[100],
              hintText: hintText,
              hintStyle: GoogleFonts.sora(
                color: Colors.grey[600],
                fontSize: 15.sp,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: Colors.grey[500],
                size: 20.sp,
              ),
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}