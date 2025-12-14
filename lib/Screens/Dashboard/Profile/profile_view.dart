import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Data/Themes/app_colors.dart';
import '../../../Data/Themes/theme_controller.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    // Use Obx to rebuild entire screen when isDarkMode changes
    return Obx(() {
      // Force evaluation of isDarkMode to trigger rebuilds
      final isDark = themeController.isDarkMode.value;
      print('ProfileView rebuilding, isDarkMode: $isDark');

      return Scaffold(
        backgroundColor: AppColors.primaryBgClr,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),

                Text(
                  "Profile",
                  style: GoogleFonts.sora(
                    color: AppColors.primaryTextClr,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),

                // Profile Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: AppColors.cardClr,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: isDark ? [] : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 25.w,
                        height: 25.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: NetworkImage("https://i.pravatar.cc/300?img=5"),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: AppColors.primaryBgClr,
                            width: 4,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),

                      Text(
                        "Sarah Johnson",
                        style: GoogleFonts.sora(
                          color: AppColors.primaryTextClr,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 0.5.h),

                      Text(
                        "sarah@agency.com",
                        style: GoogleFonts.sora(
                          color: AppColors.secondaryTextClr,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                        decoration: BoxDecoration(
                          color: AppColors.badgeBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Agency",
                          style: GoogleFonts.sora(
                            color: AppColors.primaryBlue,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),

                      Text(
                        "Digital Wave Agency",
                        style: GoogleFonts.sora(
                          color: AppColors.secondaryTextClr,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),

                _buildSectionHeader("SETTINGS"),
                SizedBox(height: 1.5.h),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardClr,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Dark Mode Switch
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
                        leading: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(CupertinoIcons.moon, color: AppColors.primaryBlue, size: 18.sp),
                        ),
                        title: Text(
                          "Dark Mode",
                          style: GoogleFonts.sora(
                            color: AppColors.primaryTextClr,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: CupertinoSwitch(
                          value: isDark,
                          activeColor: AppColors.primaryBlue,
                          onChanged: (value) {
                            print('Switch tapped: $value');
                            controller.toggleTheme(value);
                          },
                        ),
                      ),
                      _buildDivider(),
                      _buildListTile(
                        icon: CupertinoIcons.bell,
                        title: "Notifications",
                        trailing: Icon(
                          CupertinoIcons.chevron_right,
                          color: AppColors.secondaryTextClr,
                          size: 18.sp,
                        ),
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildListTile(
                        icon: CupertinoIcons.question_circle,
                        title: "Help & Support",
                        trailing: Icon(
                          CupertinoIcons.chevron_right,
                          color: AppColors.secondaryTextClr,
                          size: 18.sp,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),

                _buildSectionHeader("ACCOUNT"),
                SizedBox(height: 1.5.h),

                SizedBox(
                  width: double.infinity,
                  height: 6.5.h,
                  child: ElevatedButton(
                    onPressed: controller.logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.logoutBtnBg,
                      foregroundColor: AppColors.logoutTextClr,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.square_arrow_right, size: 18.sp),
                        SizedBox(width: 2.w),
                        Text(
                          "Log Out",
                          style: GoogleFonts.sora(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: Text(
        title,
        style: GoogleFonts.sora(
          color: AppColors.secondaryTextClr,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primaryBlue, size: 18.sp),
      ),
      title: Text(
        title,
        style: GoogleFonts.sora(
          color: AppColors.primaryTextClr,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: AppColors.borderColor,
      indent: 16.w,
      endIndent: 4.w,
    );
  }
}