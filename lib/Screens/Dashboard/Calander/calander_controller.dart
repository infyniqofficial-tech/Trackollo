import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

// Simple Event Model for demo
class Event {
  final String title;
  final Color color;
  final String time;
  final String tag;
  final Color tagColor;
  Event(this.title, this.color, this.time, this.tag, this.tagColor);
}

class CalendarController extends GetxController {
  // --- State ---
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  // 0 = Month, 1 = Week
  var currentTab = 0.obs;
  var calendarFormat = CalendarFormat.month.obs;

  // --- Dynamic Text State ---
  var timeAgoText = "Today".obs;

  @override
  void onInit() {
    super.onInit();
    updateTimeAgoText(DateTime.now());
  }

  // --- Actions ---

  void onDaySelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedDay.value, selected)) {
      selectedDay.value = selected;
      focusedDay.value = focused;
      updateTimeAgoText(selected);
    }
  }

  void onPageChanged(DateTime focused) {
    focusedDay.value = focused;
  }

  void changeTab(int index) {
    currentTab.value = index;
    if (index == 0) {
      calendarFormat.value = CalendarFormat.month;
    } else {
      calendarFormat.value = CalendarFormat.week;
    }
  }

  // --- Logic: "Today" or "X weeks ago" ---
  void updateTimeAgoText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) {
      timeAgoText.value = "Today";
    } else if (checkDate.isAfter(today)) {
      final diff = checkDate.difference(today).inDays;
      if (diff == 1) {
        timeAgoText.value = "Tomorrow";
      } else if (diff < 7) {
        timeAgoText.value = "In $diff days";
      } else if (diff < 30) {
        timeAgoText.value = "In ${(diff / 7).floor()} ${(diff / 7).floor() == 1 ? 'week' : 'weeks'}";
      } else {
        timeAgoText.value = "In ${(diff / 30).floor()} ${(diff / 30).floor() == 1 ? 'month' : 'months'}";
      }
    } else {
      final diff = today.difference(checkDate).inDays;
      if (diff == 1) {
        timeAgoText.value = "Yesterday";
      } else if (diff < 7) {
        timeAgoText.value = "$diff days ago";
      } else if (diff < 30) {
        timeAgoText.value = "${(diff / 7).floor()} ${(diff / 7).floor() == 1 ? 'week' : 'weeks'} ago";
      } else {
        timeAgoText.value = "${(diff / 30).floor()} ${(diff / 30).floor() == 1 ? 'month' : 'months'} ago";
      }
    }
  }

  // --- Mock Events with Colors ---
  List<Event> getEventsForDay(DateTime day) {
    // Example: Add dots for specific days
    if (day.day == 10) {
      return [Event("Design Meeting", Colors.blue, "10:00 AM - 11:30 AM", "", Colors.blue)];
    }
    if (day.day == 12) {
      return [Event("Client Call", Colors.red, "10:00 AM - 11:30 AM", "", Colors.red)];
    }
    if (day.day == 15) {
      return [Event("Holiday Sale Story", Colors.orange, "9:00 AM", "STORY", const Color(0xFFFF9500))];
    }
    if (day.day == 18) {
      return [Event("Customer Testimonial Post", Colors.blue, "11:00 AM", "POST", const Color(0xFF007AFF))];
    }
    if (day.day == 20) {
      return [Event("Facebook Ad Campaign - Q4", Colors.green, "8:00 AM", "AD", const Color(0xFF34C759))];
    }
    return [];
  }

  // Get week range text
  String getWeekRangeText() {
    final startOfWeek = focusedDay.value.subtract(Duration(days: focusedDay.value.weekday % 7));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return "${monthNames[startOfWeek.month - 1]} ${startOfWeek.day} - ${monthNames[endOfWeek.month - 1]} ${endOfWeek.day}";
  }

  // Get all days in current week
  List<DateTime> getWeekDays() {
    final startOfWeek = focusedDay.value.subtract(Duration(days: focusedDay.value.weekday % 7));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  // Get events grouped by day for week view
  Map<DateTime, List<Event>> getWeekEvents() {
    final weekDays = getWeekDays();
    final Map<DateTime, List<Event>> events = {};

    for (var day in weekDays) {
      final dayEvents = getEventsForDay(day);
      if (dayEvents.isNotEmpty) {
        events[day] = dayEvents;
      }
    }

    return events;
  }

  // Helper to determine list title
  String getEventSectionTitle() {
    final now = DateTime.now();
    // Normalize to date only
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day);

    if (selected.isBefore(today)) {
      return "Previous Events";
    } else {
      return "Upcoming Events";
    }
  }

  // Check if selected day is today
  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day);
    return selected == today;
  }

  // Navigate to today
  void goToToday() {
    final today = DateTime.now();
    selectedDay.value = today;
    focusedDay.value = today;
    updateTimeAgoText(today);
  }

  // Navigate week
  void previousWeek() {
    focusedDay.value = focusedDay.value.subtract(const Duration(days: 7));
  }

  void nextWeek() {
    focusedDay.value = focusedDay.value.add(const Duration(days: 7));
  }
}