import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static Color get primaryBgClr {
    return Get.isDarkMode ? Color(0xFF0D0D0D) : Colors.white;
  }

  static Color get primaryTextClr {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }

  static Color get secondaryTextClr {
    return Get.isDarkMode ? const Color(0xFF8E8E93) : const Color(0xFF636366);
  }

  // static Color get cardClr {
  //   return Get.isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;
  // }

  static Color get primaryBtnColor {
    return Get.isDarkMode ? Colors.blue : Colors.blue;
  }

  static const Color primaryBlue = Color(0xFF4D8EFF); // The bright blue button color
  static const Color inputFieldBg = Color(0xFF1C1C1E); // Dark grey input background
  static const Color secondaryText = Color(0xFFAAAAAA); // Grey subtitle text
  static const Color darkCardBg = Color(0xFF1C1C1E);
  static const Color lightCardBg = Colors.white;

  static Color get cardClr {
    return Get.isDarkMode ? darkCardBg : lightCardBg;
  }

  static Color get navBarBg {
    return Get.isDarkMode ? Colors.black : Colors.white;
  }

  static Color get borderColor {
    return Get.isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFE5E5EA);
  }

  // --- Status Colors (for Tags & Icons) ---
  static const Color successGreen = Color(0xFF00C853);
  static const Color successBg = Color(0xFF1E3426); // Dark mode green bg hint
  static const Color warningOrange = Color(0xFFFFAB00);
  static const Color warningBg = Color(0xFF3E2D12); // Dark mode orange bg hint
  static const Color errorRed = Color(0xFFFF3D00);
  static const Color errorBg = Color(0xFF351A1A); // Dark mode red bg hint

}