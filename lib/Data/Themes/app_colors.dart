import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static Color get primaryBgClr {
    return Get.isDarkMode ? Colors.black : Colors.white;
  }

  static Color get primaryTextClr {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }

  static Color get cardClr {
    return Get.isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;
  }

  static Color get primaryBtnColor {
    return Get.isDarkMode ? Colors.blue : Colors.blue;
  }
}