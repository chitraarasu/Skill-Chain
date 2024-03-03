import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../controller/web_auth_controller.dart';
import '../../models/dashboard_model.dart';
import '../../utils/font_manager.dart';
import '../../utils/web_support.dart';

class WebDashboard extends StatelessWidget {
  final int index;

  WebDashboard(this.index);

  WebAuthController webAuth = Get.find();

  @override
  Widget build(BuildContext context) {
    Rx<int> selectedItem = Rx<int>(index);
    User? userData = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          SizedBox(
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(assetImage("sk_logo")),
                    width: 120,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 45,
                                backgroundColor: brown1,
                                backgroundImage: (webAuth
                                            .selectedImages.value !=
                                        null
                                    ? MemoryImage(webAuth.selectedImages.value!)
                                    : userData?.photoURL == null
                                        ? null
                                        : NetworkImage(
                                            userData?.photoURL ?? "",
                                          )) as ImageProvider<Object>?,
                                child: webAuth.selectedImages.value != null
                                    ? null
                                    : userData?.photoURL == null
                                        ? Image(
                                            image: AssetImage(
                                              assetImage("profile_dummy"),
                                            ),
                                          )
                                        : null,
                              ),
                            ),
                            // CircleAvatar(
                            //   radius: 45,
                            //   backgroundColor: brown1,
                            //   backgroundImage: NetworkImage(
                            //       "https://images.unsplash.com/photo-1593085512500-5d55148d6f0d"),
                            // ),
                            GestureDetector(
                              onTap: () {
                                webAuth.pickImages();
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 20,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.edit, size: 15),
                              ),
                            ),
                          ],
                        ),
                        vSpace(20),
                        getCustomFont(
                          "University Name",
                          18,
                          fontWeight: bold,
                        ),
                        vSpace(5),
                        getCustomFont(
                          "ROLE",
                          15,
                          fontWeight: semiBold,
                          fontColor: colorGrey3,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: dashboardList
                            .map(
                              (e) => Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    selectedItem.value =
                                        dashboardList.indexOf(e);
                                    setWebTitleAndUrl(e.text, e.route);
                                  },
                                  child: AnimatedContainer(
                                    decoration: BoxDecoration(
                                      color: selectedItem.value ==
                                              dashboardList.indexOf(e)
                                          ? brown1
                                          : null,
                                      borderRadius: BorderRadius.circular(12.5),
                                    ),
                                    duration: const Duration(milliseconds: 200),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: Row(
                                        children: [
                                          Image(
                                            image:
                                                AssetImage(assetImage(e.image)),
                                            width: 16,
                                          ),
                                          hSpace(15),
                                          getCustomFont(e.text, 16,
                                              fontWeight: semiBold),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  vSpace(20),
                  GestureDetector(
                    onTap: () {
                      webAuth.logout();
                    },
                    child: Row(
                      children: [
                        hSpace(20),
                        Icon(
                          Icons.exit_to_app_rounded,
                          size: 17.5,
                          color: colorGrey3,
                        ),
                        hSpace(6),
                        getCustomFont(
                          "Logout",
                          15,
                          fontColor: colorGrey3,
                          fontWeight: semiBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: brown1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: dashboardList[selectedItem.value].screen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
