import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/screens/dashboard/pages/verification.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../controller/web_auth_controller.dart';
import '../../../controller/web_verification_controller.dart';
import '../../../models/bc_user_model.dart';
import '../../../models/skill_request_model.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/loading_manager.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget statText(String text, String subText) {
    return Expanded(
      child: Column(
        children: [
          getCustomFont(text, 35,
              fontColor: Colors.white, fontWeight: semiBold),
          getCustomFont(subText, 12,
              fontColor: Colors.white.withOpacity(.7), fontWeight: semiBold),
        ],
      ),
    );
  }

  Widget circleText(Color color, String subText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          hSpace(25),
          getCustomFont(
            subText,
            15,
            fontColor: Colors.white,
            fontWeight: semiBold,
          )
        ],
      ),
    );
  }

  Widget bottomBox(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Container(
            height: 156,
            width: 156,
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSpace(15),
                  getCustomFont(title, 16,
                      fontWeight: semiBold, overflow: TextOverflow.visible),
                  Spacer(),
                  getCustomFont(subTitle, 35, fontWeight: bold),
                ],
              ),
            ),
          ),
          Positioned(
            top: -24,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WebVerificationController webVerify = Get.find();
    WebAuthController webAuthController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont("Performance", 20,
                                fontColor: Colors.white, fontWeight: semiBold),
                            vSpace(10),
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FutureBuilder(
                                        future: webVerify.fetchUsers(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<BcUser>>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return kLoading;
                                          } else if (snapshot.hasData) {
                                            List<BcUser> data = snapshot.data
                                                    ?.where(
                                                      (e) => FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  ?.email ==
                                                              "admin@skillchain.com"
                                                          ? true
                                                          : (e.skills ?? [])
                                                              .map((item) =>
                                                                  item.toJson())
                                                              .toList()
                                                              .toString()
                                                              .contains(FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      ?.uid ??
                                                                  ""),
                                                    )
                                                    .toList() ??
                                                [];
                                            print(data);
                                            return statText(
                                                data.length.toString(),
                                                "Students");
                                          } else {
                                            return statText("-", "Students");
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: VerticalDivider(
                                          thickness: 1,
                                          color: Colors.white.withOpacity(.5),
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("requests")
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    QuerySnapshot<
                                                        Map<String, dynamic>>>
                                                reqSnap) {
                                          if (reqSnap.connectionState ==
                                              ConnectionState.waiting) {
                                            return kLoading;
                                          } else if (reqSnap.hasData) {
                                            List<RequestModel> reqData = reqSnap
                                                    .data?.docs
                                                    .map((e) =>
                                                        RequestModel.fromJson(
                                                            e.data()))
                                                    .toList() ??
                                                [];
                                            List<RequestModel>
                                                currentUserReqData = reqData
                                                    .where((e) => FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                ?.email ==
                                                            "admin@skillchain.com"
                                                        ? true &&
                                                            e.status ==
                                                                "Pending"
                                                        : e.industryId ==
                                                                webAuthController
                                                                    .customLoggedInUser
                                                                    .value
                                                                    ?.uid &&
                                                            e.status ==
                                                                "Pending")
                                                    .toList();
                                            return statText(
                                                currentUserReqData.length
                                                    .toString(),
                                                "Pending Requests");
                                          } else {
                                            return statText(
                                                "-", "Pending Requests");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            circleText(orange, "Strong encryption protocols."),
                            circleText(lightBlue, "Identity verification."),
                            circleText(brown, "Strict access controls."),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                hSpace(25),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Verification(
                      isFromHome: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          vSpace(25),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: brown,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont("Engagement", 24, fontWeight: semiBold),
                          const Spacer(),
                          getCustomFont(
                            "General statistics of\nuser engagement\nprocess.",
                            15,
                            fontWeight: medium,
                          ),
                        ],
                      ),
                      hSpace(60),
                      Expanded(
                        child: FutureBuilder(
                          future: webVerify.fetchUsers(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<BcUser>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return kLoading;
                            } else if (snapshot.hasData) {
                              return FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("users")
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        userSnap) {
                                  if (userSnap.connectionState ==
                                      ConnectionState.waiting) {
                                    return kLoading;
                                  } else if (userSnap.hasData) {
                                    return FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection("skills")
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>
                                              skillsSnap) {
                                        if (skillsSnap.connectionState ==
                                            ConnectionState.waiting) {
                                          return kLoading;
                                        } else if (skillsSnap.hasData) {
                                          List skillDocs = skillsSnap.data?.docs
                                                  .map((item) => item.data())
                                                  .toList() ??
                                              [];
                                          print(skillDocs);
                                          return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  bottomBox(
                                                      "Overall Users",
                                                      snapshot.data!.length
                                                          .toString()),
                                                  bottomBox(
                                                      "Institutes",
                                                      userSnap.data!.docs.length
                                                          .toString()),
                                                  bottomBox(
                                                      "Skills",
                                                      skillDocs.length
                                                          .toString()),
                                                  bottomBox(
                                                      "Precision", "100%"),
                                                ],
                                              ));
                                        } else {
                                          return getErrorMessage(
                                              skillsSnap.data);
                                        }
                                      },
                                    );
                                  } else {
                                    return getErrorMessage(snapshot.error);
                                  }
                                },
                              );
                            } else {
                              return getErrorMessage(snapshot.error);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
