import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../Data/Themes/app_colors.dart';
import '../../../../Data/Themes/theme_controller.dart';
import 'schedule_post_controller.dart';

class SchedulePostScreen extends GetView<SchedulePostController> {
  const SchedulePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final bgColor = isDark ? const Color(0xFF000000) : const Color(0xFFF9F9F9);
      final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
      final textColor = isDark ? Colors.white : Colors.black;
      final hintColor = isDark ? Colors.grey[600] : Colors.grey[400];

      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20.sp),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "Schedule Post",
            style: GoogleFonts.inter(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECTION 1: Social Platforms ---
              Text(
                "Post to",
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSocialIcon("Instagram", Icons.camera_alt, Colors.pink, isDark),
                  _buildSocialIcon("Facebook", Icons.facebook, Colors.blue, isDark),
                  _buildSocialIcon("Twitter", Icons.alternate_email, Colors.lightBlue, isDark),
                  _buildSocialIcon("LinkedIn", Icons.business, Colors.blue[800]!, isDark),
                ],
              ),

              SizedBox(height: 3.h),

              // --- SECTION 2: Media Upload (Dashed Border) ---
              Text(
                "Media",
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.5.h),
              GestureDetector(
                onTap: () {
                  // Trigger upload
                },
                child: CustomPaint(
                  painter: _DottedBorderPainter(
                    color: isDark ? Colors.grey[700]! : Colors.grey[400]!,
                    strokeWidth: 1.5,
                    gap: 5.0,
                  ),
                  child: Container(
                    height: 22.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF151517) : const Color(0xFFF2F2F7).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.cloud_upload_outlined,
                            size: 26.sp,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          "Upload Photo or Video",
                          style: GoogleFonts.inter(
                            color: textColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          "Supports JPG, PNG, MP4",
                          style: GoogleFonts.inter(
                            color: hintColor,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 3.h),

              // --- SECTION 3: Caption ---
              Text(
                "Caption",
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.5.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.transparent : const Color(0xFFE5E5EA),
                  ),
                ),
                child: TextField(
                  controller: controller.captionController,
                  maxLines: 5,
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: 15.sp,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write your caption here...",
                    hintStyle: GoogleFonts.inter(
                      color: hintColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 3.h),

              // --- SECTION 4: Schedule Time ---
              Text(
                "Schedule for",
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.5.h),
              Row(
                children: [
                  Expanded(
                    child: _buildPickerTile(
                      controller.dateDisplay,
                      Icons.calendar_month,
                          () => controller.pickDate(context),
                      isDark,
                      cardColor,
                      textColor,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: _buildPickerTile(
                      controller.timeDisplay,
                      Icons.access_time_filled,
                          () => controller.pickTime(context),
                      isDark,
                      cardColor,
                      textColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h),

              // --- SECTION 5: Action Button ---
              SizedBox(
                width: double.infinity,
                height: 6.5.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      "Scheduled",
                      "Your post has been scheduled successfully.",
                      backgroundColor: const Color(0xFF34C759),
                      colorText: Colors.white,
                      margin: EdgeInsets.all(4.w),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Schedule Post",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      );
    });
  }

  // Helper: Social Icons
  Widget _buildSocialIcon(String platform, IconData icon, Color color, bool isDark) {
    return Obx(() {
      final isSelected = controller.selectedPlatforms.contains(platform);

      return GestureDetector(
        onTap: () => controller.togglePlatform(platform),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 16.w,
              height: 16.w,
              decoration: BoxDecoration(
                color: isSelected ? color : (isDark ? const Color(0xFF1C1C1E) : Colors.white),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))]
                    : [],
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : (isDark ? Colors.grey[500] : Colors.grey[400]),
                size: 22.sp,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              platform,
              style: GoogleFonts.inter(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper: Date/Time Picker Tile
  Widget _buildPickerTile(
      RxString value,
      IconData icon,
      VoidCallback onTap,
      bool isDark,
      Color cardColor,
      Color textColor,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.transparent : const Color(0xFFE5E5EA),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDark ? Colors.grey[400] : Colors.grey[500],
              size: 20.sp,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Obx(() => Text(
                value.value,
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Custom Dotted Border Painter ---
class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DottedBorderPainter({required this.color, required this.strokeWidth, required this.gap});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ));

    Path dashPath = Path();
    double dashWidth = 10.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + gap;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}