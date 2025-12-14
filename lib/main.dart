import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Data/Themes/theme_controller.dart';
import 'Routes/app_pages.dart';
import 'Routes/app_routes.dart';
import 'Routes/initial_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {

    final box = GetStorage();

    bool isFirstTime = box.read('isFirstTime') ?? true;
    // bool isFirstTime = true;

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {


          return GetMaterialApp(
            title: "MyApp",
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              textTheme: GoogleFonts.soraTextTheme(
                ThemeData.light().textTheme,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              textTheme: GoogleFonts.soraTextTheme(
                ThemeData.dark().textTheme,
              ),
            ),
            themeMode: themeController.themeMode,
            initialBinding: InitialBinding(),
            getPages: AppPages.pages,
            initialRoute: isFirstTime ? AppRoutes.ONBOARDING : AppRoutes.LOGIN,
          );
      },
    );
  }
}
