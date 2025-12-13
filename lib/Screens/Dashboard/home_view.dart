import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Data/Themes/app_colors.dart';
import 'dashboard_controller.dart';

class HomeView extends GetView<DashboardController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgClr,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              // 1. Header
              _buildHeader(),
              SizedBox(height: 3.h),

              // 2. Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: controller.stats.map((stat) => _buildStatCard(stat)).toList(),
              ),
              SizedBox(height: 3.h),

              // 3. Warning Banner
              _buildWarningBanner(),
              SizedBox(height: 4.h),

              // 4. Upcoming Posts Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcoming Posts",
                    style: GoogleFonts.sora(
                      color: AppColors.primaryTextClr,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See All",
                    style: GoogleFonts.sora(
                      color: AppColors.primaryBlue,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // 5. Post List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.posts.length,
                separatorBuilder: (_, __) => SizedBox(height: 2.h),
                itemBuilder: (context, index) {
                  return _buildPostCard(controller.posts[index]);
                },
              ),
              SizedBox(height: 10.h), // Spacing for Bottom Nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: GoogleFonts.sora(
                color: AppColors.secondaryTextClr,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              "Sarah Johnson",
              style: GoogleFonts.sora(
                color: AppColors.primaryTextClr,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Icon(CupertinoIcons.bell, size: 22.sp, color: AppColors.primaryTextClr),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(0.5.w),
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 4.w,
                  minHeight: 2.h,
                ),
                child: Text(
                  '3',
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    Color iconColor;
    Color bgIconColor;

    // Logic for styling based on stat type
    if (stat['status'] == 'published') {
      iconColor = AppColors.primaryBlue;
      bgIconColor = AppColors.primaryBlue.withValues(alpha:0.15);
    } else if (stat['status'] == 'approved') {
      iconColor = AppColors.successGreen;
      bgIconColor = AppColors.successGreen.withValues(alpha:0.15);
    } else {
      iconColor = AppColors.warningOrange;
      bgIconColor = AppColors.warningOrange.withValues(alpha:0.15);
    }

    return Container(
      width: 28.w,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      decoration: BoxDecoration(
          color: AppColors.cardClr,
          borderRadius: BorderRadius.circular(16),
          // Add subtle shadow for light mode
          boxShadow: Get.isDarkMode ? [] : [
            BoxShadow(
              color: Colors.grey.withValues(alpha:0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              color: bgIconColor,
              shape: BoxShape.circle,
            ),
            // Replacing image asset with generic Icon for now if asset missing
            child: Icon(
              stat['status'] == 'pending' ? CupertinoIcons.clock :
              stat['status'] == 'approved' ? CupertinoIcons.check_mark :
              CupertinoIcons.graph_circle,
              color: iconColor,
              size: 18.sp,
            ),
          ),
          SizedBox(height: 1.5.h),
          Text(
            stat['count'],
            style: GoogleFonts.sora(
              color: AppColors.primaryTextClr,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            stat['label'],
            style: GoogleFonts.sora(
              color: AppColors.secondaryTextClr,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? const Color(0xFF3E2D12) // Dark Warning BG
            : const Color(0xFFFFF3E0), // Light Warning BG
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.warningOrange.withValues(alpha:0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.exclamationmark_circle, color: AppColors.warningOrange, size: 20.sp),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              "You have 2 posts awaiting approval",
              style: GoogleFonts.sora(
                color: AppColors.warningOrange,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    // Logic for Status Colors
    Color statusColor;
    Color statusBg;
    if (post['status'] == 'Approved' || post['status'] == 'Published') {
      statusColor = AppColors.successGreen;
      statusBg = Get.isDarkMode ? const Color(0xFF1E3426) : const Color(0xFFE8F5E9);
    } else if (post['status'] == 'Needs Changes') {
      statusColor = AppColors.errorRed;
      statusBg = Get.isDarkMode ? const Color(0xFF351A1A) : const Color(0xFFFFEBEE);
    } else {
      statusColor = AppColors.warningOrange;
      statusBg = Get.isDarkMode ? const Color(0xFF3E2D12) : const Color(0xFFFFF8E1);
    }

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
          color: AppColors.cardClr,
          borderRadius: BorderRadius.circular(16),
          boxShadow: Get.isDarkMode ? [] : [
            BoxShadow(
              color: Colors.grey.withValues(alpha:0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            )
          ]
      ),
      child: Row(
        children: [
          // Image Placeholder
          Container(
            width: 25.w,
            height: 25.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(post['color']), // Mock color
                image: const DecorationImage(
                  // Use a real asset or network image here
                  image: NetworkImage("https://picsum.photos/200"),
                  fit: BoxFit.cover,
                )
            ),
          ),
          SizedBox(width: 4.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags
                Row(
                  children: [
                    _buildTag(post['type'], AppColors.primaryBlue.withValues(alpha:0.2), AppColors.primaryBlue),
                    SizedBox(width: 2.w),
                    _buildTag(post['status'], statusBg, statusColor),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  post['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.sora(
                    color: AppColors.primaryTextClr,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  post['date'],
                  style: GoogleFonts.sora(
                    color: AppColors.secondaryTextClr,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textClr) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.sora(
          color: textClr,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}