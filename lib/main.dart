import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/screens/web_authentication.dart';
import 'package:skill_chain/web/screens/web_dashboard.dart';
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
      ),
      // home: const WebAuthentication(),
      initialRoute: Screens.root,
      getPages: [
        GetPage(
          name: Screens.root,
          page: () => WebAuthentication(),
        ),
        GetPage(
          name: Screens.dashboard,
          page: () => WebDashboard(),
        ),
      ],
    );
  }
}
