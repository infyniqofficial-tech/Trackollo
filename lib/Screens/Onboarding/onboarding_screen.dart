// ... existing imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Data/Themes/app_colors.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgClr,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Bar with Skip Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.skip,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: GoogleFonts.sora(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text("Skip"),
                ),
              ),
            ),

            // 2. Page View (Content)
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pages.length,
                onPageChanged: controller.updatePage,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final page = controller.pages[index];
                  return _buildPageContent(
                    image: page["image"],
                    title: page["title"],
                    subtitle: page["subtitle"],
                  );
                },
              ),
            ),

            // 3. Bottom Section (Dots & Button)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              child: Column(
                children: [
                  // Page Indicators
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.pages.length,
                          (index) => _buildDot(index),
                    ),
                  )),

                  SizedBox(height: 4.h),

                  // Big Blue Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 6.5.h,
                    child: Obx(() {
                      bool isLast = controller.pageIndex.value == controller.pages.length - 1;
                      return ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBtnColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: GoogleFonts.sora(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Text(isLast ? "Get Started" : "Next"),
                      );
                    }),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildPageContent({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Image.asset(
              image,
              height: 25.h,
              width: 25.h,
              fit: BoxFit.contain,
            ),

          SizedBox(height: 5.h),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              //todo change later
              color: Colors.grey,
              fontSize: 16.sp,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = controller.pageIndex.value == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      height: 0.8.h,
      width: isActive ? 6.w : 0.8.h,
      decoration: BoxDecoration(
        //todo change later
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}