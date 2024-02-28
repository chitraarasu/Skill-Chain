import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/screens/dashboard/web_dashboard.dart';
import 'package:skill_chain/web/screens/web_authentication.dart';
import 'package:skill_chain/web/utils/resizer/fetch_pixels.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Chain',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scrollbarTheme: ScrollbarThemeData().copyWith(
            thickness: MaterialStateProperty.all(0),
          )),
      // home: const WebAuthentication(),
      initialRoute: Screens.root,
      getPages: [
        GetPage(
          name: Screens.root,
          page: () => WebAuthentication(),
        ),
        GetPage(
          name: Screens.dashboard,
          page: () => WebDashboard(0),
        ),
        GetPage(
          name: Screens.verification,
          page: () => WebDashboard(1),
        ),
        GetPage(
          name: Screens.addSkill,
          page: () => WebDashboard(2),
        ),
        GetPage(
          name: Screens.institute,
          page: () => WebDashboard(3),
        ),
        GetPage(
          name: Screens.skillApproval,
          page: () => WebDashboard(4),
        ),
        GetPage(
          name: Screens.users,
          page: () => WebDashboard(5),
        ),
        // GetPage(
        //   name: Screens.settings,
        //   page: () => WebDashboard(5),
        // ),
      ],
    );
  }
}
