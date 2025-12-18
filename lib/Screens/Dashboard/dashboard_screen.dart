import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Data/Themes/app_colors.dart';
import '../../Data/Themes/theme_controller.dart';
import 'Calander/calander_view.dart';
import 'Media/media_view.dart';
import 'Profile/profile_view.dart';
import 'dashboard_controller.dart';
import 'home_view.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      // Force rebuild when theme changes
      final isDark = themeController.isDarkMode.value;
      print('DashboardScreen rebuilding, isDarkMode: $isDark');

      return Scaffold(
        backgroundColor: AppColors.primaryBgClr,
        body: Obx(() {
          // Switch views here based on index
          switch (controller.tabIndex.value) {
            case 0:
              return const HomeView();
            case 1:
              return const CalendarView();
            case 2:
              return const MediaView();
            case 3:
              return const ProfileView();
            default:
              return const HomeView();
          }
        }),
        bottomNavigationBar: _buildAnimatedBottomNav(isDark),
      );
    });
  }

  Widget _buildAnimatedBottomNav(bool isDark) {
    return Container(
      padding: EdgeInsets.only(top: 1.5.h, bottom: 3.h, left: 4.w, right: 4.w),
      decoration: BoxDecoration(
        color: AppColors.navBarBg,
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Obx(
            () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(0, CupertinoIcons.square_grid_2x2, CupertinoIcons.square_grid_2x2_fill, "Home"),
            _navItem(1, CupertinoIcons.calendar, CupertinoIcons.calendar_today, "Calendar"),
            _navItem(2, CupertinoIcons.photo, CupertinoIcons.photo_fill, "Media"),
            _navItem(3, CupertinoIcons.person, CupertinoIcons.person_fill, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData outlineIcon, IconData filledIcon, String label) {
    bool isSelected = controller.tabIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 4.w : 2.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Icon Animation
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 300),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double val, child) {
                return Transform.scale(
                  scale: isSelected ? 1.0 + (0.1 * val) : 1.0,
                  child: Icon(
                    isSelected ? filledIcon : outlineIcon,
                    color: isSelected ? AppColors.primaryBlue : AppColors.secondaryTextClr,
                    size: 20.sp,
                  ),
                );
              },
            ),
            // Label Animation (Slide out width)
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: SizedBox(
                width: isSelected ? null : 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}