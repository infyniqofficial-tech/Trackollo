import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostDescriptionController extends GetxController {
  // Text controller for comments
  final commentController = TextEditingController();

  // Observable date
  var selectedDate = DateTime.now().obs;

  // Get formatted date string
  String get formattedDate {
    return DateFormat('EEEE, MMMM d, y').format(selectedDate.value);
  }

  // Get formatted date and time for detail view
  String get formattedDateTime {
    return DateFormat('MMMM d, y \'at\' h:mm a').format(selectedDate.value);
  }

  @override
  void onInit() {
    super.onInit();
    // Check if date was passed as argument from calendar
    if (Get.arguments != null && Get.arguments is DateTime) {
      selectedDate.value = Get.arguments;
    } else {
      // Default to a specific date for demo
      selectedDate.value = DateTime(2025, 12, 10, 10, 0);
    }
  }

  // Method to change date if needed
  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  // Method to add a comment
  void addComment() {
    if (commentController.text.trim().isNotEmpty) {
      // Handle comment submission
      print("Comment: ${commentController.text}");
      commentController.clear();
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}