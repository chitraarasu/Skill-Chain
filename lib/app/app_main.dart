import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:skill_chain/app/onboarding/onboarding_screen.dart';

import '../web/utils/color_manager.dart';
import '../web/utils/font_manager.dart';

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: OnBoardingPage(),
      // initialBinding: WebBinder(),
    );
  }
}
