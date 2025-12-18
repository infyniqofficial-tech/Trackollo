import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../Data/Themes/app_colors.dart';
import '../../../Data/Themes/theme_controller.dart';
import '../../../Routes/app_routes.dart'; // Added Import
import 'calander_controller.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalendarController());
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 2.h),

              // --- 1. Custom Header Row ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    // LEFT: Title
                    Text(
                      "Calendar",
                      style: GoogleFonts.inter(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    // RIGHT: Today Button
                    Obx(() {
                      final isSelectedToday = controller.isToday();
                      return GestureDetector(
                        onTap: () {
                          if (!isSelectedToday) {
                            controller.goToToday();
                          }
                        },
                        child: Container(
                          height: 4.h,
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: isSelectedToday
                                ? const Color(0xFF007AFF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              controller.timeAgoText.value,
                              style: GoogleFonts.inter(
                                color: isSelectedToday
                                    ? Colors.white
                                    : (isDark ? Colors.grey[600] : Colors.grey[400]),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              // --- 2. Tabs (Month/Week) ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1C1C1E)
                        : const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(0.5.w),
                  child: Row(
                    children: [
                      Expanded(child: _buildTabBtn("Month", 0, controller, isDark)),
                      Expanded(child: _buildTabBtn("Week", 1, controller, isDark)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              // --- 3. Content ---
              Expanded(
                child: Obx(() {
                  if (controller.currentTab.value == 0) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCalendarCard(controller, isDark),
                          SizedBox(height: 3.h),
                          _buildEventSection(controller, isDark),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    );
                  } else {
                    return _buildWeekView(controller, isDark);
                  }
                }),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTabBtn(String label, int index, CalendarController controller, bool isDark) {
    return Obx(() {
      final isSelected = controller.currentTab.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF007AFF)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.grey[600] : Colors.grey[600]),
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildWeekView(CalendarController controller, bool isDark) {
    return Obx(() {
      final weekRange = controller.getWeekRangeText();
      final weekDays = controller.getWeekDays();
      final weekEvents = controller.getWeekEvents();
      final dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: controller.previousWeek,
                  icon: Icon(Icons.chevron_left, color: isDark ? Colors.white : Colors.black, size: 24.sp),
                ),
                Text(
                  weekRange,
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: controller.nextWeek,
                  icon: Icon(Icons.chevron_right, color: isDark ? Colors.white : Colors.black, size: 24.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                final day = weekDays[index];
                final dayName = dayNames[day.weekday % 7];
                final events = weekEvents[day] ?? [];
                final isToday = isSameDay(day, DateTime.now());

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
                      margin: EdgeInsets.only(bottom: 1.h),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            dayName,
                            style: GoogleFonts.inter(
                              color: isDark ? Colors.grey[500] : Colors.grey[600],
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => controller.onDaySelected(day, day),
                            child: Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: BoxDecoration(
                                color: isToday ? const Color(0xFF007AFF) : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: GoogleFonts.inter(
                                  color: isToday ? Colors.white : (isDark ? Colors.white : Colors.black),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (events.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.5.h),
                          child: Text(
                            "No posts scheduled",
                            style: GoogleFonts.inter(
                              color: isDark ? Colors.grey[700] : Colors.grey[400],
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      )
                    else
                      ...events.map((event) => GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.SCHEDULE_POST, arguments: event),
                        child: _buildWeekEventCard(event, isDark),
                      )).toList(),
                    SizedBox(height: 0.5.h),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildWeekEventCard(Event event, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 5.h,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.3.h),
                Text(
                  event.time,
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          if (event.tag.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
              decoration: BoxDecoration(
                color: event.tagColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                event.tag,
                style: GoogleFonts.inter(
                  color: event.tagColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard(CalendarController controller, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() => TableCalendar<Event>(
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: controller.focusedDay.value,
        calendarFormat: controller.calendarFormat.value,
        selectedDayPredicate: (day) => isSameDay(controller.selectedDay.value, day),
        onDaySelected: controller.onDaySelected,
        onPageChanged: controller.onPageChanged,
        eventLoader: controller.getEventsForDay,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: GoogleFonts.inter(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: isDark ? Colors.white : Colors.black, size: 24.sp),
          rightChevronIcon: Icon(Icons.chevron_right, color: isDark ? Colors.white : Colors.black, size: 24.sp),
          headerMargin: EdgeInsets.only(bottom: 2.h),
          headerPadding: EdgeInsets.zero,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.inter(color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 13.sp),
          weekendStyle: GoogleFonts.inter(color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
        calendarStyle: CalendarStyle(
          outsideTextStyle: GoogleFonts.inter(color: isDark ? Colors.grey[800] : Colors.grey[400], fontSize: 16.sp),
          defaultTextStyle: GoogleFonts.inter(color: isDark ? Colors.white : Colors.black, fontSize: 16.sp),
          weekendTextStyle: GoogleFonts.inter(color: isDark ? Colors.white : Colors.black, fontSize: 16.sp),
          markersMaxCount: 0,
          cellMargin: EdgeInsets.all(1.w),
        ),
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, focusedDay) => _buildCell(date: date, isSelected: true, isToday: isSameDay(date, DateTime.now()), events: controller.getEventsForDay(date), isDark: isDark),
          todayBuilder: (context, date, focusedDay) => _buildCell(date: date, isSelected: false, isToday: true, events: controller.getEventsForDay(date), isDark: isDark),
          defaultBuilder: (context, date, focusedDay) => _buildCell(date: date, isSelected: false, isToday: false, events: controller.getEventsForDay(date), isDark: isDark),
          outsideBuilder: (context, date, focusedDay) => _buildCell(date: date, isSelected: false, isToday: false, events: [], isDark: isDark, isOutside: true),
        ),
      )),
    );
  }

  Widget _buildCell({required DateTime date, required bool isSelected, required bool isToday, required List<Event> events, required bool isDark, bool isOutside = false}) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.all(0.5.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF007AFF).withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: const Color(0xFF007AFF), width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: GoogleFonts.inter(
                color: isOutside ? (isDark ? Colors.grey[800] : Colors.grey[400]) : (isDark ? Colors.white : Colors.black),
                fontWeight: (isSelected || isToday) ? FontWeight.bold : FontWeight.normal,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 0.5.h),
            if (events.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: events.take(3).map((event) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: event.color),
                )).toList(),
              )
            else
              SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  // --- MODIFIED Event Section ---
  Widget _buildEventSection(CalendarController controller, bool isDark) {
    return Obx(() {
      final title = controller.getEventSectionTitle();
      final events = controller.getEventsForDay(controller.selectedDay.value);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),

          if (events.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  "No events found",
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.grey[600] : Colors.grey[600],
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              separatorBuilder: (_,__) => SizedBox(height: 1.5.h),
              itemBuilder: (context, index) {
                final event = events[index];

                // --- WRAPPED IN GESTURE DETECTOR ---
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.SCHEDULE_POST, arguments: event);
                  },
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1C1C1E)
                          : const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: event.color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            CupertinoIcons.circle_fill,
                            color: event.color,
                            size: 10.sp,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: GoogleFonts.inter(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              event.time,
                              style: GoogleFonts.inter(
                                color: isDark ? Colors.grey[600] : Colors.grey[600],
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )
        ],
      );
    });
  }
}