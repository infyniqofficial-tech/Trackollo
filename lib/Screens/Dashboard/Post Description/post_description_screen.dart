import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Data/Themes/app_colors.dart';
import '../../../../Data/Themes/theme_controller.dart';
import 'post_description_controller.dart';

class PostDescriptionScreen extends GetView<PostDescriptionController> {
  const PostDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Close Button
              _buildCloseButton(isDark),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      _buildImageSection(),

                      // Content Section
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 3.h),

                            // Pending Badge
                            _buildPendingBadge(isDark),

                            SizedBox(height: 2.h),

                            // Title
                            Text(
                              "New Product Launch - Summer Collection",
                              style: GoogleFonts.inter(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),

                            SizedBox(height: 2.h),

                            // Date and Time
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.clock,
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                  size: 18.sp,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  controller.formattedDateTime,
                                  style: GoogleFonts.inter(
                                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 3.h),

                            // Platforms Section
                            _buildPlatformsSection(isDark),

                            SizedBox(height: 3.h),

                            // Caption Section
                            _buildCaptionSection(isDark),

                            SizedBox(height: 3.h),

                            // Hashtags Section
                            _buildHashtagsSection(isDark),

                            SizedBox(height: 3.h),

                            // Comments Section
                            _buildCommentsSection(isDark),

                            SizedBox(height: 3.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Comment Input
              _buildCommentInput(isDark),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCloseButton(bool isDark) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.close,
            color: isDark ? Colors.white : Colors.black,
            size: 22.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1523381210434-271e8be1f52b?q=80&w=800",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPendingBadge(bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF3E2D12)
            : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.clock,
            color: const Color(0xFFFFAB00),
            size: 16.sp,
          ),
          SizedBox(width: 2.w),
          Text(
            "PENDING",
            style: GoogleFonts.inter(
              color: const Color(0xFFFFAB00),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PLATFORMS",
          style: GoogleFonts.inter(
            color: isDark ? Colors.grey[500] : Colors.grey[600],
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 1.5.h),
        Row(
          children: [
            _buildPlatformChip(
              icon: Icons.camera_alt_outlined,
              label: "Instagram",
              color: const Color(0xFFE1306C),
              isDark: isDark,
            ),
            SizedBox(width: 3.w),
            _buildPlatformChip(
              icon: Icons.facebook_rounded,
              label: "Facebook",
              color: const Color(0xFF1877F2),
              isDark: isDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlatformChip({
    required IconData icon,
    required String label,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(width: 2.w),
          Text(
            label,
            style: GoogleFonts.inter(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptionSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CAPTION",
          style: GoogleFonts.inter(
            color: isDark ? Colors.grey[500] : Colors.grey[600],
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 1.5.h),
        Text(
          "Introducing our newest summer collection! ✨ Fresh styles for the season ahead. Shop now and get 20% off your first order. #SummerVibes #NewCollection",
          style: GoogleFonts.inter(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 15.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildHashtagsSection(bool isDark) {
    final hashtags = ["#SummerVibes", "#NewCollection", "#Fashion", "#Style"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "HASHTAGS",
          style: GoogleFonts.inter(
            color: isDark ? Colors.grey[500] : Colors.grey[600],
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 1.5.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: hashtags.map((tag) => _buildHashtagChip(tag, isDark)).toList(),
        ),
      ],
    );
  }

  Widget _buildHashtagChip(String tag, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tag,
        style: GoogleFonts.inter(
          color: const Color(0xFF007AFF),
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCommentsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "COMMENTS (1)",
          style: GoogleFonts.inter(
            color: isDark ? Colors.grey[500] : Colors.grey[600],
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 2.h),
        _buildCommentItem(isDark),
      ],
    );
  }

  Widget _buildCommentItem(bool isDark) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.sp,
                backgroundImage: const NetworkImage(
                  "https://i.pravatar.cc/100?img=33",
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Michael Chen",
                      style: GoogleFonts.inter(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Dec 8, 2:30 PM",
                      style: GoogleFonts.inter(
                        color: isDark ? Colors.grey[500] : Colors.grey[600],
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Text(
            "Love the aesthetic! Can we adjust the copy to emphasize the discount more?",
            style: GoogleFonts.inter(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 15.sp,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput(bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.commentController,
              style: GoogleFonts.inter(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                hintText: "Add a comment...",
                hintStyle: GoogleFonts.inter(
                  color: isDark ? Colors.grey[600] : Colors.grey[500],
                  fontSize: 15.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Icon(
            CupertinoIcons.paperclip,
            color: isDark ? Colors.grey[600] : Colors.grey[500],
            size: 22.sp,
          ),
          SizedBox(width: 4.w),
          Icon(
            CupertinoIcons.paperplane,
            color: isDark ? Colors.grey[600] : Colors.grey[500],
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}