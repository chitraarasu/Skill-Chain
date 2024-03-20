import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/controller/web_auth_controller.dart';
import 'package:skill_chain/web/controller/web_verification_controller.dart';
import 'package:skill_chain/web/screens/dashboard/pages/users.dart';
import 'package:skill_chain/web/utils/buttons/secondary_button.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../models/bc_user_model.dart';
import '../../../models/institute_user_model.dart';
import '../../../models/skill_request_model.dart';
import '../../../models/skills_model.dart';
import '../../../utils/buttons/primary_button.dart';
import '../../../utils/loading_manager.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/top_categories.dart';

class SkillApproval extends StatelessWidget {
  List<String> topics = [
    "SI NO",
    "Institute",
    "",
    "Skill Details",
    "Certificate",
    "Options",
  ];

  @override
  Widget build(BuildContext context) {
    WebAuthController webAuthController = Get.find();
    WebVerificationController webVerificationController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Row(
          //         children: [
          //           PrimaryButton(
          //             "Add Institute",
          //             buttonColor: Colors.white,
          //             radius: 20,
          //             textColor: colorGrey1,
          //             padding: EdgeInsets.symmetric(
          //               vertical: FetchPixels.getPixelHeight(20),
          //               horizontal: FetchPixels.getPixelWidth(5),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //           child: CustomTextField(
          //             // borderRadius: 20,
          //             isNeedborder: false,
          //             hint: "Search",
          //             height: null,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // vSpace(15),
          TopCategories(topics),
          vSpace(10),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("requests").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> reqSnap) {
                if (reqSnap.connectionState == ConnectionState.waiting) {
                  return kLoading;
                } else if (reqSnap.hasData) {
                  List<RequestModel> reqData = reqSnap.data?.docs
                          .map((e) => RequestModel.fromJson(e.data()))
                          .toList() ??
                      [];
                  List<RequestModel> currentUserReqData = reqData
                      .where((e) =>
                          e.industryId ==
                              webAuthController.customLoggedInUser.value?.uid &&
                          e.status == "Pending")
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
                          skillSnap.data?.docs.map((e) => e.data()).toList() ??
                              [],
                        );
                        return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("users")
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  instituteSnap) {
                            if (instituteSnap.connectionState ==
                                ConnectionState.waiting) {
                              return kLoading;
                            } else if (instituteSnap.hasData) {
                              List<InstituteUserModel> insData = instituteSnap
                                      .data?.docs
                                      .map((e) =>
                                          InstituteUserModel.fromJson(e.data()))
                                      .toList() ??
                                  [];
                              return ListView.builder(
                                itemCount: currentUserReqData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Builder(builder: (context) {
                                    InstituteUserModel instituteItem =
                                        insData.firstWhere(
                                      (element) =>
                                          element.uid ==
                                          currentUserReqData[index].industryId,
                                    );
                                    SkillsModel skillItem =
                                        skillData.firstWhere(
                                      (element) =>
                                          element.skillId ==
                                          currentUserReqData[index].skillId,
                                    );
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 25),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 55,
                                                child: Center(
                                                  child: getCustomFont(
                                                    index.toString(),
                                                    14,
                                                    fontColor: Colors.black,
                                                    fontWeight: medium,
                                                    maxLine: 1,
                                                  ),
                                                ),
                                              ),
                                              hSpace(25),
                                              Expanded(
                                                flex: 2,
                                                child: getCustomFont(
                                                  instituteItem.name,
                                                  15,
                                                  fontColor: colorGrey1,
                                                  fontWeight: bold,
                                                  maxLine: 1,
                                                  textAlign: TextAlign.justify,
                                                  txtHeight: 0,
                                                ),
                                              ),
                                              Expanded(
                                                child: getCustomFont(
                                                  skillItem.name,
                                                  13,
                                                  fontColor: colorGrey1,
                                                  fontWeight: semiBold,
                                                  maxLine: 1,
                                                  textAlign: TextAlign.center,
                                                  txtHeight: 0,
                                                ),
                                              ),
                                              // Expanded(
                                              //   child: Center(
                                              //     child: getCustomFont(
                                              //       "123456",
                                              //       13,
                                              //       fontColor: colorGrey1,
                                              //       fontWeight: medium,
                                              //       maxLine: 1,
                                              //       textAlign: TextAlign.justify,
                                              //       txtHeight: 0,
                                              //     ),
                                              //   ),
                                              // ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    openDoc(
                                                        context,
                                                        currentUserReqData[
                                                                    index]
                                                                .certificateUrl ??
                                                            "");
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.link,
                                                        size: 17,
                                                      ),
                                                      hSpace(5),
                                                      getCustomFont(
                                                        "Open",
                                                        13,
                                                        fontColor: colorGrey1,
                                                        fontWeight: medium,
                                                        maxLine: 1,
                                                        textAlign:
                                                            TextAlign.center,
                                                        txtHeight: 0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20),
                                                    child: SecondaryButton(
                                                      title: "View",
                                                      color: brown,
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              AlertDialog(
                                                                  insetPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .6,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              20),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child:
                                                                          FutureBuilder(
                                                                        future: webVerificationController
                                                                            .getUserFromPublicId([
                                                                          currentUserReqData[index].userId ??
                                                                              ""
                                                                        ], () {}),
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<BcUserModel?>
                                                                                snapshot) {
                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return kLoading;
                                                                          } else if (snapshot.hasData) {
                                                                            return Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: getCustomFont(
                                                                                        "Skill Approval",
                                                                                        24,
                                                                                        fontWeight: bold,
                                                                                        fontColor: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                    IconButton(
                                                                                      onPressed: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      icon: CircleAvatar(
                                                                                        radius: 12,
                                                                                        backgroundColor: brown,
                                                                                        child: Icon(
                                                                                          Icons.close,
                                                                                          size: 18,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                vSpace(15),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          getCustomFont(
                                                                                            "Institute",
                                                                                            17,
                                                                                            fontWeight: bold,
                                                                                            fontColor: colorGrey1,
                                                                                          ),
                                                                                          vSpace(5),
                                                                                          CustomTextField(
                                                                                            enable: false,
                                                                                            controller: TextEditingController(
                                                                                              text: instituteItem.name,
                                                                                            ),
                                                                                          ),
                                                                                          vSpace(15),
                                                                                          getCustomFont(
                                                                                            "Skill Details",
                                                                                            17,
                                                                                            fontWeight: bold,
                                                                                            fontColor: colorGrey1,
                                                                                          ),
                                                                                          vSpace(5),
                                                                                          CustomTextField(
                                                                                            enable: false,
                                                                                            controller: TextEditingController(
                                                                                              text: skillItem.name,
                                                                                            ),
                                                                                          ),
                                                                                          vSpace(15),
                                                                                          getCustomFont(
                                                                                            "Public Id",
                                                                                            17,
                                                                                            fontWeight: bold,
                                                                                            fontColor: colorGrey1,
                                                                                          ),
                                                                                          vSpace(5),
                                                                                          CustomTextField(
                                                                                            enable: false,
                                                                                            controller: TextEditingController(
                                                                                              text: currentUserReqData[index].userId,
                                                                                            ),
                                                                                          ),
                                                                                          vSpace(15),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    hSpace(20),
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              CircleAvatar(
                                                                                                radius: 70,
                                                                                                backgroundImage: NetworkImage(snapshot.data?.data?.first.imageUrl ?? ""),
                                                                                              ),
                                                                                              hSpace(10),
                                                                                              Expanded(
                                                                                                child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    getCustomFont(
                                                                                                      "Name",
                                                                                                      17,
                                                                                                      fontWeight: bold,
                                                                                                      fontColor: colorGrey1,
                                                                                                    ),
                                                                                                    vSpace(5),
                                                                                                    CustomTextField(
                                                                                                      enable: false,
                                                                                                      controller: TextEditingController(
                                                                                                        text: snapshot.data?.data?.first.name ?? "",
                                                                                                      ),
                                                                                                    ),
                                                                                                    vSpace(15),
                                                                                                    getCustomFont(
                                                                                                      "Email",
                                                                                                      17,
                                                                                                      fontWeight: bold,
                                                                                                      fontColor: colorGrey1,
                                                                                                    ),
                                                                                                    vSpace(5),
                                                                                                    CustomTextField(
                                                                                                      enable: false,
                                                                                                      controller: TextEditingController(
                                                                                                        text: snapshot.data?.data?.first.emailId ?? "",
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          vSpace(10),
                                                                                          getCustomFont(
                                                                                            "Mobile",
                                                                                            17,
                                                                                            fontWeight: bold,
                                                                                            fontColor: colorGrey1,
                                                                                          ),
                                                                                          vSpace(5),
                                                                                          CustomTextField(
                                                                                            enable: false,
                                                                                            controller: TextEditingController(
                                                                                              text: snapshot.data?.data?.first.mobileNo ?? "",
                                                                                            ),
                                                                                          ),
                                                                                          vSpace(15),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                vSpace(30),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: PrimaryButton(
                                                                                        "Reject",
                                                                                        // buttonColor: orange,
                                                                                        radius: 10,
                                                                                        textColor: orange,
                                                                                        isNeedBorder: true,
                                                                                        borderColor: orange,
                                                                                        onTap: () async {
                                                                                          LoadingManager.shared.showLoading();
                                                                                          try {
                                                                                            await FirebaseFirestore.instance.collection("requests").doc(currentUserReqData[index].requestId).update({
                                                                                              "status": "Rejected",
                                                                                            });
                                                                                          } catch (e) {
                                                                                            print(e);
                                                                                          }

                                                                                          LoadingManager.shared.hideLoading();
                                                                                          Get.back();
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    hSpace(20),
                                                                                    Expanded(
                                                                                      child: PrimaryButton(
                                                                                        "Approve",
                                                                                        buttonColor: darkGreen,
                                                                                        radius: 10,
                                                                                        textColor: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            );
                                                                          } else {
                                                                            return getErrorMessage(snapshot.error);
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                  )),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
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
    );
  }
}
