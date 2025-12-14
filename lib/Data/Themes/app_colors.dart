import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme_controller.dart';

class AppColors {
  // Helper to check dark mode from our controller
  static bool get _isDark {
    try {
      final controller = Get.find<ThemeController>();
      return controller.isDarkMode.value;
    } catch (e) {
      // Fallback to Get.isDarkMode if controller not found
      return Get.isDarkMode;
    }
  }

  static Color get primaryBgClr {
    return _isDark ? const Color(0xFF0D0D0D) : Colors.white;
  }

  static Color get primaryTextClr {
    return _isDark ? Colors.white : Colors.black;
  }

  static Color get secondaryTextClr {
    return _isDark ? const Color(0xFF8E8E93) : const Color(0xFF636366);
  }

  static Color get primaryBtnColor {
    return _isDark ? Colors.blue : Colors.blue;
  }

  // Keep const colors as they are
  static const Color primaryBlue = Color(0xFF4D8EFF);
  static const Color inputFieldBg = Color(0xFF1C1C1E);
  static const Color secondaryText = Color(0xFFAAAAAA);
  static const Color darkCardBg = Color(0xFF1C1C1E);
  static const Color lightCardBg = Colors.white;

  static Color get cardClr {
    return _isDark ? darkCardBg : lightCardBg;
  }

  static Color get navBarBg {
    return _isDark ? Colors.black : Colors.white;
  }

  static Color get borderColor {
    return _isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E5EA);
  }

  // Status Colors
  static const Color successGreen = Color(0xFF00C853);
  static const Color successBg = Color(0xFF1E3426);
  static const Color warningOrange = Color(0xFFFFAB00);
  static const Color warningBg = Color(0xFF3E2D12);
  static const Color errorRed = Color(0xFFFF3D00);
  static const Color errorBg = Color(0xFF351A1A);

  static Color get badgeBg {
    return _isDark ? const Color(0xFF1A2744) : const Color(0xFFE3F2FD);
  }

  static Color get logoutBtnBg {
    return _isDark ? const Color(0xFF351A1A) : const Color(0xFFFFEBEE);
  }

  static Color get logoutTextClr {
    return const Color(0xFFFF3D00);
  }
}