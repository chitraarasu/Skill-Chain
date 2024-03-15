import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/screens/dashboard/pages/users.dart';
import 'package:skill_chain/web/utils/buttons/primary_button.dart';
import 'package:skill_chain/web/utils/loading_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/custom_textfield.dart';

import '../../../controller/web_auth_controller.dart';
import '../../../controller/web_verification_controller.dart';
import '../../../models/skills_model.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/font_manager.dart';
import '../../../utils/widgets/custom_profile.dart';
import '../../../utils/widgets/widgets.dart';

class Verification extends StatelessWidget {
  final bool isFromHome;
  final bool isForAddSkill;

  Verification({
    this.isFromHome = false,
    this.isForAddSkill = false,
  });

  @override
  Widget build(BuildContext context) {
    WebAuthController webAuth = Get.find();

    return Padding(
      padding: isFromHome ? EdgeInsets.zero : EdgeInsets.all(40.0),
      child: Container(
        decoration: BoxDecoration(
          color: isForAddSkill ? brown : lightBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: isFromHome
                    ? EdgeInsets.only(left: 15, top: 15, bottom: 15)
                    : EdgeInsets.only(left: 30, top: 30, bottom: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomTextField(
                                // borderRadius: 20,
                                isNeedborder: false,
                                hint:
                                    "Enter comma separated public id. Like id1, id2....",
                                height: null,
                              ),
                            ),
                          ),
                        ),
                        hSpace(10),
                        Container(
                          height: 47.5,
                          width: 47.5,
                          decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("skills")
                            .orderBy(
                              'created_time',
                            )
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return kLoading;
                          } else if (snapshot.hasData) {
                            print(snapshot.data?.docs.first.data());
                            List<SkillsModel> data = skillsModelFromJson(
                              snapshot.data?.docs
                                      .map((e) => e.data())
                                      .toList() ??
                                  [],
                            );
                            print(data.length);
                            return isForAddSkill &&
                                    webAuth.customLoggedInUser.value != null
                                ? Builder(builder: (context) {
                                    String skill = "";
                                    String skillKey = "";
                                    print(webAuth.customLoggedInUser.value
                                        ?.instituteAccess);
                                    switch (webAuth.customLoggedInUser.value
                                        ?.instituteAccess) {
                                      case "10th":
                                        skill = "School";
                                        skillKey = "1";
                                        break;
                                      case "12th":
                                        skill = "School";
                                        skillKey = "2";
                                        break;
                                      case "Degree":
                                        skill = "College";
                                        skillKey = "3";
                                        break;
                                      case "Extra Skills":
                                        skill = "Extra Skills";
                                        skillKey = "4";
                                        break;
                                    }

                                    return SizedBox(
                                      height: double.infinity,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            GetSkill(
                                              isFromHome,
                                              skill,
                                              data
                                                          .where((e) =>
                                                              e.accessId ==
                                                              skillKey)
                                                          .toList()
                                                      as List<SkillsModel>? ??
                                                  [],
                                              forAddSkill: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                                : Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: double.infinity,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                GetSkill(
                                                  isFromHome,
                                                  "School",
                                                  data
                                                              .where((e) =>
                                                                  e.category ==
                                                                  "school")
                                                              .toList()
                                                          as List<
                                                              SkillsModel>? ??
                                                      [],
                                                ),
                                                vSpace(10),
                                                GetSkill(
                                                  isFromHome,
                                                  "College",
                                                  data
                                                              .where((e) =>
                                                                  e.category ==
                                                                  "college")
                                                              .toList()
                                                          as List<
                                                              SkillsModel>? ??
                                                      [],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      hSpace(15),
                                      Expanded(
                                        child: SizedBox(
                                          height: double.infinity,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                GetSkill(
                                                  isFromHome,
                                                  "Skills",
                                                  data
                                                              .where((e) =>
                                                                  e.category ==
                                                                  "ec")
                                                              .toList()
                                                          as List<
                                                              SkillsModel>? ??
                                                      [],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
            ),
            Expanded(
              child: Padding(
                padding: isFromHome ? EdgeInsets.all(15) : EdgeInsets.all(30.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorWhite.withOpacity(.6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: isFromHome
                        ? EdgeInsets.all(15.0)
                        : EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              decoration: BoxDecoration(
                                color: colorWhite.withOpacity(.8),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CustomProfile(
                                      radius: isFromHome ? 20 : 25,
                                      width: null,
                                    ),
                                    hSpace(10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getCustomFont(
                                            "User Name",
                                            isFromHome ? 15 : 17,
                                            fontColor: Colors.black,
                                            fontWeight: semiBold,
                                          ),
                                          getCustomFont(
                                            "PublicId",
                                            isFromHome ? 14 : 15,
                                            fontColor: colorGrey1,
                                            fontWeight: semiBold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
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
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                isForAddSkill ? "Add Skill" : "Verify",
                                buttonColor: darkBlue,
                                radius: 10,
                                onTap: () {
                                  if (isForAddSkill) {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,
                                        content: SingleChildScrollView(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Spacer(),
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
                                                SizedBox(
                                                  width: 300,
                                                  height: 300,
                                                  child: Image(
                                                    image: AssetImage(
                                                      assetImage(
                                                          "skills_added"),
                                                    ),
                                                    width: 300,
                                                  ),
                                                ),
                                                vSpace(15),
                                                getCustomFont(
                                                  "Skills Added Successfully!",
                                                  24,
                                                  fontWeight: bold,
                                                  fontColor: darkBlue,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,
                                        content: SingleChildScrollView(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: getCustomFont(
                                                        "Verification Details",
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
                                                ...List.generate(
                                                  4,
                                                  (index) => UsersTile(
                                                      isFromVerifySkill: true),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetSkill extends StatelessWidget {
  final bool isFromHome;
  final String topic;
  List<SkillsModel> list;
  final bool forAddSkill;

  GetSkill(this.isFromHome, this.topic, this.list, {this.forAddSkill = false});

  WebVerificationController webVerifyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vSpace(15),
        getCustomFont(
          topic,
          isFromHome ? 15 : 17,
          fontColor: Colors.black,
          fontWeight: semiBold,
        ),
        vSpace(15),
        ...list.map(
          (item) => GestureDetector(
            onTap: () {
              if (forAddSkill) {
                webVerifyController.verifySkills.value = [];
                webVerifyController.verifySkills.add(item);
              } else {
                if (webVerifyController.verifySkills.contains(item)) {
                  webVerifyController.verifySkills.remove(item);
                } else {
                  webVerifyController.verifySkills.add(item);
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: getCustomFont(
                          item.name ?? "",
                          isFromHome ? 15 : 17,
                          fontColor: Colors.black,
                          fontWeight: semiBold,
                        ),
                      ),
                      webVerifyController.verifySkills.contains(item)
                          ? Icon(Icons.check_circle_outline_rounded)
                          : Icon(Icons.radio_button_unchecked_rounded)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
