import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/controller/binder.dart';
import 'package:skill_chain/web/controller/web_auth_controller.dart';
import 'package:skill_chain/web/screens/dashboard/web_dashboard.dart';
import 'package:skill_chain/web/screens/web_authentication.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/resizer/fetch_pixels.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(WebAuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    WebAuthController webAuth = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Chain',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: brown,
          primary: brown,
        ),
        useMaterial3: true,
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thickness: MaterialStateProperty.all(0),
        ),
      ),
      // home: const WebAuthentication(),
      initialBinding: WebBinder(),
      initialRoute: webAuth.isLoggedIn.value ? Screens.dashboard : Screens.root,
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
