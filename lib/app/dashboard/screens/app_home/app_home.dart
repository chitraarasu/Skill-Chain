import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skill_chain/app/dashboard/screens/verification/app_add_skill.dart';
import 'package:skill_chain/web/models/institute_user_model.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/loading_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../../web/models/skills_model.dart';
import '../../../../web/utils/buttons/secondary_button.dart';
import '../../../../web/utils/color_manager.dart';
import '../../../app_controller/app_controller.dart';
import 'open_certificate.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouteController appRouteController = Get.find();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpace(20),
            getCustomFont("Dashboard", 20, fontWeight: bold),
            vSpace(12.5),
            Expanded(
              child: FutureBuilder(
                future: appRouteController.profile(false),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return kLoading;
                  } else if (snapshot.hasData) {
                    return FutureBuilder(
                      future:
                          FirebaseFirestore.instance.collection("skills").get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              skillSnap) {
                        if (skillSnap.connectionState ==
                            ConnectionState.waiting) {
                          return kLoading;
                        } else if (skillSnap.hasData) {
                          List<SkillsModel> data = skillsModelFromJson(
                            skillSnap.data?.docs
                                    .map((e) => e.data())
                                    .toList() ??
                                [],
                          );
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                vSpace(12.5),
                                Container(
                                  decoration: BoxDecoration(
                                    color: lightBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  appRouteController
                                                          .loggedInUser
                                                          .value
                                                          ?.imageUrl ??
                                                      ""),
                                            ),
                                            hSpace(20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  getCustomFont(
                                                    appRouteController
                                                            .loggedInUser
                                                            .value
                                                            ?.name ??
                                                        "",
                                                    18,
                                                    fontWeight: semiBold,
                                                    fontColor: Colors.black,
                                                  ),
                                                  vSpace(5),
                                                  getCustomFont(
                                                    (appRouteController
                                                                .loggedInUser
                                                                .value
                                                                ?.skills
                                                                ?.isEmpty ??
                                                            false)
                                                        ? "No skills added"
                                                        : data
                                                                .firstWhere((element) =>
                                                                    element
                                                                        .skillId ==
                                                                    appRouteController
                                                                        .loggedInUser
                                                                        .value
                                                                        ?.skills
                                                                        ?.last
                                                                        .skillId)
                                                                .name ??
                                                            "",
                                                    14,
                                                    fontWeight: medium,
                                                    fontColor: Colors.black,
                                                  ),
                                                  vSpace(5),
                                                  getCustomFont(
                                                    "${appRouteController.loggedInUser.value?.skills?.length} Skills",
                                                    14,
                                                    fontWeight: medium,
                                                    fontColor: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        vSpace(20),
                                        Divider(
                                          height: 0,
                                          thickness: 0.5,
                                          color: Colors.black,
                                        ),
                                        vSpace(20),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: SecondaryButton(
                                            title: "Add Skill",
                                            isNeedBorder: false,
                                            radius: 10,
                                            backgroundColor:
                                                darkBlue.withOpacity(0.75),
                                            onTap: () {
                                              AppRouteController
                                                  .to.currentPos.value = 1;
                                              Get.to(() => AppAddSkill());
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                vSpace(25),
                                getCustomFont("Public Id", 18,
                                    fontWeight: bold),
                                vSpace(15),
                                Container(
                                  decoration: BoxDecoration(
                                    color: brown,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        getCustomFont(
                                          appRouteController.loggedInUser.value
                                                  ?.publicId ??
                                              "",
                                          15,
                                          fontWeight: semiBold,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: appRouteController
                                                        .loggedInUser
                                                        .value
                                                        ?.publicId ??
                                                    ""));
                                            toastPlatform("Public id copied!");
                                          },
                                          icon: const Icon(Icons.copy),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                vSpace(25),
                                getCustomFont("Skills", 18, fontWeight: bold),
                                vSpace(15),
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection("users")
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>
                                          instituteSnap) {
                                    if (instituteSnap.connectionState ==
                                        ConnectionState.waiting) {
                                      return kLoading;
                                    } else if (instituteSnap.hasData) {
                                      List<InstituteUserModel> insData =
                                          instituteSnap.data?.docs
                                                  .map((e) => InstituteUserModel
                                                      .fromJson(e.data()))
                                                  .toList() ??
                                              [];
                                      return Column(
                                        children: appRouteController
                                                .loggedInUser.value?.skills
                                                ?.map(
                                                  (item) => Builder(
                                                    builder: (context) {
                                                      InstituteUserModel
                                                          instituteItem =
                                                          insData.firstWhere(
                                                        (element) =>
                                                            element.uid ==
                                                            item.instituteId,
                                                      );
                                                      SkillsModel skillItem =
                                                          data.firstWhere(
                                                        (element) =>
                                                            element.skillId ==
                                                            item.skillId,
                                                      );
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                            () => OpenCertificate(
                                                                item.skillDoc ??
                                                                    ""),
                                                          );
                                                        },
                                                        child: SkillCard(
                                                          false,
                                                          image: instituteItem
                                                              .logo,
                                                          institute:
                                                              instituteItem
                                                                  .instituteName,
                                                          skillName:
                                                              skillItem.name,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                                .toList() ??
                                            [],
                                      );
                                    } else {
                                      return getErrorMessage(snapshot.error);
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                        } else {
                          print(skillSnap.error);
                          return getErrorMessage(skillSnap.error);
                        }
                      },
                    );
                  } else {
                    return getErrorMessage(snapshot.error);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final bool isNeedStatus;
  final String? image;
  final String? institute;
  final String? skillName;
  final String? status;

  SkillCard(this.isNeedStatus,
      {this.image, this.institute, this.skillName, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.75, color: colorGrey1),
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    image ??
                        "https://upload.wikimedia.org/wikipedia/commons/b/b9/Tamil_Nadu_Emblem.png",
                  ),
                ),
                hSpace(20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        institute ?? "Tamil nadu state government.",
                        14,
                        fontWeight: semiBold,
                        maxLine: 2,
                      ),
                      vSpace(5),
                      getCustomFont(
                        skillName ?? "Skills",
                        13,
                        fontWeight: medium,
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (isNeedStatus)
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: getCustomFont(
                      "Pending",
                      13,
                      fontWeight: medium,
                      fontColor: orange,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
