import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../web/models/institute_user_model.dart';
import '../../../../web/models/skill_request_model.dart';
import '../../../../web/models/skills_model.dart';
import '../../../../web/utils/font_manager.dart';
import '../../../../web/utils/loading_manager.dart';
import '../../../../web/utils/ui_element.dart';
import '../../../../web/utils/widgets/widgets.dart';
import '../../../app_controller/app_controller.dart';
import '../app_home/app_home.dart';
import '../app_home/open_certificate.dart';
import 'app_add_skill.dart';

class AppVerification extends StatelessWidget {
  const AppVerification({super.key});

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
            Row(
              children: [
                Expanded(
                  child: getCustomFont(
                    "Verification Request",
                    20,
                    fontWeight: bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => AppAddSkill());
                  },
                  icon: Icon(Icons.add_box_outlined),
                ),
              ],
            ),
            vSpace(12.5),
            vSpace(7.5),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("requests").get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        reqSnap) {
                  if (reqSnap.connectionState == ConnectionState.waiting) {
                    return kLoading;
                  } else if (reqSnap.hasData) {
                    List<RequestModel> reqData = reqSnap.data?.docs
                            .map((e) => RequestModel.fromJson(e.data()))
                            .toList() ??
                        [];
                    List<RequestModel> currentUserReqData = reqData
                        .where((e) =>
                            e.userId ==
                            appRouteController.loggedInUser.value?.publicId)
                        .toList();
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
                          List<SkillsModel> skillData = skillsModelFromJson(
                            skillSnap.data?.docs
                                    .map((e) => e.data())
                                    .toList() ??
                                [],
                          );
                          return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    instituteSnap) {
                              if (instituteSnap.connectionState ==
                                  ConnectionState.waiting) {
                                return kLoading;
                              } else if (instituteSnap.hasData) {
                                List<InstituteUserModel> insData = instituteSnap
                                        .data?.docs
                                        .map((e) => InstituteUserModel.fromJson(
                                            e.data()))
                                        .toList() ??
                                    [];
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 7.5),
                                    child: Column(
                                      children: currentUserReqData
                                          .map(
                                            (item) =>
                                                Builder(builder: (context) {
                                              InstituteUserModel instituteItem =
                                                  insData.firstWhere(
                                                (element) =>
                                                    element.uid ==
                                                    item.industryId,
                                              );
                                              SkillsModel skillItem =
                                                  skillData.firstWhere(
                                                (element) =>
                                                    element.skillId ==
                                                    item.skillId,
                                              );
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(() => OpenCertificate(
                                                      item.certificateUrl ??
                                                          ""));
                                                },
                                                child: SkillCard(
                                                  true,
                                                  image: instituteItem.logo,
                                                  institute: instituteItem
                                                      .instituteName,
                                                  skillName: skillItem.name,
                                                  status: item.status,
                                                ),
                                              );
                                            }),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                );
                              } else {
                                print(skillSnap.error);
                                return getErrorMessage(skillSnap.error);
                              }
                            },
                          );
                        } else {
                          print(skillSnap.error);
                          return getErrorMessage(skillSnap.error);
                        }
                      },
                    );
                  } else {
                    return getErrorMessage(reqSnap.error);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
