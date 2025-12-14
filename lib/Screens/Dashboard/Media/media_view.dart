import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Data/Themes/app_colors.dart';
import '../../../Data/Themes/theme_controller.dart';
import 'media_controller.dart';

class MediaView extends GetView<MediaController> {
  const MediaView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: AppColors.primaryBgClr,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),

                // 1. Header with Toggle Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Media Library",
                      style: GoogleFonts.sora(
                        color: AppColors.primaryTextClr,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Toggle Icon
                    InkWell(
                      onTap: controller.toggleView,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Obx(() => Icon(
                          // Show List icon if in Grid mode, Grid icon if in List mode
                          controller.isGridView.value
                              ? CupertinoIcons.list_bullet
                              : CupertinoIcons.square_grid_2x2,
                          color: AppColors.primaryTextClr,
                          size: 20.sp,
                        )),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                // 2. Search Bar & Filter
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.inputFieldBg : Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: controller.searchController,
                          style: GoogleFonts.sora(
                            color: AppColors.primaryTextClr,
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: AppColors.secondaryTextClr,
                              size: 18.sp,
                            ),
                            hintText: "Search media...",
                            hintStyle: GoogleFonts.sora(
                              color: AppColors.secondaryTextClr,
                              fontSize: 15.sp,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      height: 6.h,
                      width: 6.h,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.inputFieldBg : Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        CupertinoIcons.slider_horizontal_3,
                        color: AppColors.primaryTextClr,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                // 3. Tabs (All, Image, Video)
                Row(
                  children: [
                    _buildTabButton(context, 0, "All", isDark),
                    SizedBox(width: 3.w),
                    _buildTabButton(context, 1, "Image", isDark),
                    SizedBox(width: 3.w),
                    _buildTabButton(context, 2, "Video", isDark),
                  ],
                ),

                SizedBox(height: 3.h),

                // 4. Content Area (Switch between Grid and List)
                Expanded(
                  child: Obx(() {
                    final items = controller.filteredItems;
                    if (items.isEmpty) {
                      return Center(
                        child: Text("No media found", style: TextStyle(color: AppColors.secondaryTextClr)),
                      );
                    }

                    // Toggle logic
                    return controller.isGridView.value
                        ? _buildGridView(items)
                        : _buildListView(items, isDark);
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // --- Grid View Builder ---
  Widget _buildGridView(List<Map<String, dynamic>> items) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 2.h),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildGridCard(items[index]);
      },
    );
  }

  // --- List View Builder ---
  Widget _buildListView(List<Map<String, dynamic>> items, bool isDark) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 2.h),
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 1.5.h),
      itemBuilder: (context, index) {
        return _buildListCard(items[index], isDark);
      },
    );
  }

  // --- Helpers & Cards ---

  Widget _buildTabButton(BuildContext context, int index, String text, bool isDark) {
    return Obx(() {
      final isSelected = controller.selectedTabIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryBlue
                : (isDark ? AppColors.inputFieldBg : Colors.grey[100]),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: GoogleFonts.sora(
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.white70 : AppColors.primaryTextClr),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    });
  }

  // The small square card for Grid View
  Widget _buildGridCard(Map<String, dynamic> item) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(item['url']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Positioned(
          top: 0.8.h,
          right: 2.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.2.h),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              item['type'],
              style: GoogleFonts.sora(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // The detailed horizontal card for List View
  Widget _buildListCard(Map<String, dynamic> item, bool isDark) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.cardClr, // Use card color from app_colors
        borderRadius: BorderRadius.circular(20),
        // Optional: slight shadow for light mode, flat for dark
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Thumbnail
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(item['url']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 4.w),

          // 2. Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  item['title'] ?? 'Untitled',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.sora(
                    color: AppColors.primaryTextClr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),

                // Type Tag & Date
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.3.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item['type'],
                        style: GoogleFonts.sora(
                          color: AppColors.primaryBlue,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      item['date'] ?? '',
                      style: GoogleFonts.sora(
                        color: AppColors.secondaryTextClr,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.5.h),

                // Hashtags
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: (item['tags'] as List<String>).map((tag) {
                      return Container(
                        margin: EdgeInsets.only(right: 2.w),
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.inputFieldBg : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isDark ? Colors.transparent : Colors.grey[200]!,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.sora(
                            color: AppColors.secondaryTextClr,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}