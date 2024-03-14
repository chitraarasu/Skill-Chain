import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/app/dashboard/screens/AppProfile/app_profile.dart';
import 'package:skill_chain/app/dashboard/screens/app_home/app_home.dart';
import 'package:skill_chain/app/dashboard/screens/verification/verification.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../web/utils/resizer/fetch_pixels.dart';
import '../app_controller/app_controller.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  List<dynamic> bottomBarList = [
    {
      "icon": assetImage("home"),
      "title": "Home",
    },
    {
      "icon": assetImage("skill_approve"),
      "title": "Verification",
    },
    {
      "icon": assetImage("profile"),
      "title": "Profile",
    },
  ];

  @override
  Widget build(BuildContext context) {
    AppRouteController routeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => routeController.currentPos.value == 0
            ? AppHome()
            : routeController.currentPos.value == 1
                ? AppVerification()
                : routeController.currentPos.value == 2
                    ? AppProfile()
                    : Container(),
      ),
      bottomNavigationBar: buildBottomBar(
        FetchPixels.getPixelHeight(70),
        FetchPixels.getPixelHeight(24),
      ),
    );
  }

  Container buildBottomBar(double size, double iconSize) {
    AppRouteController routeController = Get.find();
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 50,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SafeArea(
          bottom: true,
          top: false,
          child: SizedBox(
            height: FetchPixels.getPixelHeight(70),
            child: Obx(
              () => Row(
                  children: List.generate(bottomBarList.length, (index) {
                return Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      routeController.currentPos.value = index;
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AnimatedContainer(
                          height: 60,
                          decoration: BoxDecoration(
                            color: index == routeController.currentPos.value
                                ? lightBlue.withOpacity(.6)
                                : Colors.transparent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(milliseconds: 200),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage(
                                    bottomBarList[index]["icon"],
                                  ),
                                  color:
                                      routeController.currentPos.value == index
                                          ? darkBlue
                                          : Colors.grey,
                                ),
                                getCustomFont(
                                  bottomBarList[index]["title"],
                                  10,
                                  fontColor:
                                      routeController.currentPos.value == index
                                          ? darkBlue
                                          : Colors.grey,
                                  maxLine: 1,
                                  fontWeight: FontWeight.w600,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })),
            ),
          ),
        ));
  }
}
