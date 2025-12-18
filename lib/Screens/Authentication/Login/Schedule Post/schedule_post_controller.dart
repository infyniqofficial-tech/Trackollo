import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Dashboard/Calander/calander_controller.dart';

class SchedulePostController extends GetxController {
  final TextEditingController captionController = TextEditingController();

  // Changed to a List for multi-selection (or single toggle)
  var selectedPlatforms = <String>[].obs;

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  var dateDisplay = "".obs;
  var timeDisplay = "".obs;

  @override
  void onInit() {
    super.onInit();

    // 1. Check if an Event object was passed (from "Upcoming Events" tile click)
    if (Get.arguments is Event) {
      final Event event = Get.arguments;
      captionController.text = event.title;
      // Parse time string if possible, otherwise keep default
      // This is a placeholder for your actual parsing logic
    }

    updateDateDisplay();
    updateTimeDisplay();
  }

  void togglePlatform(String platform) {
    if (selectedPlatforms.contains(platform)) {
      selectedPlatforms.remove(platform);
    } else {
      selectedPlatforms.add(platform);
    }
  }

  void updateDateDisplay() {
    dateDisplay.value = DateFormat('dd MMM, yyyy').format(selectedDate.value);
  }

  void updateTimeDisplay() {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, selectedTime.value.hour, selectedTime.value.minute);
    timeDisplay.value = DateFormat('hh:mm a').format(dt);
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Get.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate.value = picked;
      updateDateDisplay();
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (context, child) {
        return Theme(
          data: Get.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedTime.value = picked;
      updateTimeDisplay();
    }
  }
}