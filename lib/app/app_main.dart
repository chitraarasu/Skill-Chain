import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skill_chain/app/dashboard/dashboard.dart';
import 'package:skill_chain/app/onboarding/onboarding_screen.dart';
import 'package:skill_chain/web/utils/resizer/fetch_pixels.dart';

import '../web/utils/color_manager.dart';
import '../web/utils/font_manager.dart';
import 'app_controller/app_binder.dart';

class AppMain extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    bool? isSkipped = box.read("isSkipped");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Chain',
      theme: ThemeData(
        fontFamily: firstFont,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brown,
          primary: brown,
        ),
        useMaterial3: true,
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thickness: MaterialStateProperty.all(0),
        ),
      ),
      home: (isSkipped ?? false) ? Dashboard() : OnBoardingPage(),
      initialBinding: AppBinder(),
    );
  }
}
