import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/loading_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/custom_profile.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../controller/web_auth_controller.dart';
import '../../models/dashboard_model.dart';
import '../../utils/font_manager.dart';
import '../../utils/web_support.dart';

class WebDashboard extends StatelessWidget {
  final int index;

  WebDashboard(this.index);

  WebAuthController webAuth = Get.find();

  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    Rx<int> selectedItem = Rx<int>(index);
    User? userData = FirebaseAuth.instance.currentUser;

    if (isInit) {
      if (userData == null) {
        Future.delayed(Duration(microseconds: 5), () {
          Get.offAndToNamed(Screens.root);
          setWebTitleAndUrl("Login", "");
        });
      }
      isInit = false;
    }

    if (userData?.email != "admin@skillchain.com") {
      dashboardList
          .removeWhere((element) => element.route == Screens.institute);
    } else {
      DashboardModel? item = dashboardList
          .firstWhereOrNull((element) => element.route == Screens.institute);
      if (item == null) {
        dashboardList.add(institute);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: userData == null
          ? Container()
          : Row(
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
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(userData.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<
                                        DocumentSnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else if (snapshot.hasData) {
                                print(snapshot.data?.data());
                                var data = snapshot.data?.data();
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Obx(
                                          () => ClipOval(
                                            child: Container(
                                              width: 90,
                                              height: 90,
                                              color: brown1,
                                              child: (webAuth.selectedImages
                                                          .value !=
                                                      null
                                                  ? Image.memory(webAuth
                                                      .selectedImages.value!)
                                                  : data?["logo"] == null
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Image(
                                                            image: AssetImage(
                                                              assetImage(
                                                                  "profile_dummy"),
                                                            ),
                                                          ),
                                                        )
                                                      : NetImage(
                                                          data?["logo"] ?? "",
                                                        )),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            webAuth.pickImages();
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: darkBlue,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 20,
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    vSpace(20),
                                    getCustomFont(
                                      data?["institute_name"] ?? "Super Admin",
                                      18,
                                      fontWeight: bold,
                                      maxLine: 3,
                                      textAlign: TextAlign.center,
                                    ),
                                    vSpace(5),
                                    getCustomFont(
                                      data?["institute_access"] ?? "Manage",
                                      15,
                                      fontWeight: semiBold,
                                      fontColor: colorGrey3,
                                    )
                                  ],
                                );
                              } else {
                                return getErrorMessage(snapshot.error);
                              }
                            },
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
                                            borderRadius:
                                                BorderRadius.circular(12.5),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            child: Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      assetImage(e.image)),
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
