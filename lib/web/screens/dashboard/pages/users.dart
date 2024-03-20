import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/loading_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../controller/web_verification_controller.dart';
import '../../../models/bc_user_model.dart';
import '../../../utils/widgets/custom_profile.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/top_categories.dart';

class Users extends StatelessWidget {
  List<String> topics = [
    "Profile",
    "Details",
    "",
    "Contact",
    "Public Id",
    "Status",
    "Options",
  ];

  @override
  Widget build(BuildContext context) {
    WebVerificationController webVerify = Get.find();

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
          //             "Add Users",
          //             buttonColor: Colors.white,
          //             radius: 20,
          //             textColor: colorGrey1,
          //             padding: EdgeInsets.symmetric(
          //               vertical: 20,
          //               horizontal: 5,
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
            child: FutureBuilder(
              future: webVerify.fetchUsers(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<BcUser>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return kLoading;
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UsersTile(data: snapshot.data?[index]);
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
    );
  }
}

class UsersTile extends StatelessWidget {
  final bool isFromVerifySkill;
  final BcUser? data;
  final bool? active;
  final bool? isForAddSkill;

  UsersTile(
      {this.isFromVerifySkill = false,
      this.data,
      this.active,
      this.isForAddSkill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
          child: Row(
            children: [
              CustomProfile(
                image: data?.imageUrl,
              ),
              hSpace(25),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont(
                      data?.name ?? "Lorem ipsum",
                      15,
                      fontColor: Colors.black,
                      fontWeight: bold,
                      maxLine: 1,
                    ),
                    getCustomFont(
                      data?.address ??
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                      12,
                      fontColor: colorGrey1,
                      fontWeight: medium,
                      maxLine: 3,
                      textAlign: TextAlign.justify,
                      txtHeight: 0,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    getCustomFont(
                      data?.mobileNo ?? "1234567890",
                      13,
                      fontColor: colorGrey1,
                      fontWeight: semiBold,
                      maxLine: 1,
                      textAlign: TextAlign.justify,
                      txtHeight: 0,
                    ),
                    getCustomFont(
                      data?.emailId ?? "test@gmail.com",
                      13,
                      fontColor: colorGrey1,
                      fontWeight: semiBold,
                      maxLine: 1,
                      textAlign: TextAlign.justify,
                      txtHeight: 0,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: getCustomFont(
                    data?.publicId ?? "123456",
                    13,
                    fontColor: colorGrey1,
                    fontWeight: bold,
                    maxLine: 1,
                    textAlign: TextAlign.justify,
                    txtHeight: 0,
                  ),
                ),
              ),
              if (isFromVerifySkill)
                Expanded(
                  child: Center(
                    child: getCustomFont(
                      (active ?? false)
                          ? (isForAddSkill ?? false)
                              ? "Pass"
                              : "Skill Added"
                          : (isForAddSkill ?? false)
                              ? "Fail"
                              : "Skill Already Exist",
                      13,
                      fontColor: colorGrey1,
                      fontWeight: medium,
                      maxLine: 1,
                      textAlign: TextAlign.justify,
                      txtHeight: 0,
                    ),
                  ),
                ),
              if (isFromVerifySkill)
                Expanded(
                  child: Center(
                    child: Image(
                      image: AssetImage(
                        assetImage(
                            (active ?? false) ? "check" : "remove"), // remove
                      ),
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              if (!isFromVerifySkill)
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.5, color: darkGreen),
                        color: lightGreen,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: getCustomFont(
                          "Active",
                          12,
                          fontColor: darkGreen,
                          fontWeight: bold,
                          maxLine: 1,
                          textAlign: TextAlign.justify,
                          txtHeight: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              if (!isFromVerifySkill)
                Expanded(
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        userDetailsPopUp(context, data);
                      },
                      icon: Icon(Icons.remove_red_eye_rounded),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  userDetailsPopUp(BuildContext context, BcUser? data) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width * .6,
          height: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: getCustomFont(
                      "User Details",
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
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomProfile(
                                    width: 140, image: data?.imageUrl ?? ""),
                                hSpace(10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          text: data?.name ?? "User 1",
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
                                          text:
                                              data?.emailId ?? "test@gmail.com",
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
                                text: data?.mobileNo ?? "1234567890",
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
                                text: data?.publicId ?? "1234567890",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    hSpace(20),
                    Expanded(
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("skills")
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
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
                                  List userDocs = userSnap.data?.docs
                                          .map((item) => item.data())
                                          .toList() ??
                                      [];
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                        "Skills",
                                        17,
                                        fontWeight: bold,
                                        fontColor: colorGrey1,
                                      ),
                                      vSpace(5),
                                      Expanded(
                                        child: AutoHeightGridView(
                                          itemCount: data?.skills?.length ?? 0,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: const EdgeInsets.all(12),
                                          shrinkWrap: true,
                                          builder: (context, index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    getCustomFont(
                                                      userDocs
                                                          .where((element) =>
                                                              element["uid"] ==
                                                              data
                                                                  ?.skills?[
                                                                      index]
                                                                  .instituteId)
                                                          .first["institute_name"],
                                                      17,
                                                      fontWeight: bold,
                                                      fontColor: colorGrey1,
                                                    ),
                                                    getCustomFont(
                                                      skillDocs
                                                          .where((element) =>
                                                              element[
                                                                  "skill_id"] ==
                                                              data
                                                                  ?.skills?[
                                                                      index]
                                                                  .skillId)
                                                          .first["name"],
                                                      17,
                                                      fontWeight: medium,
                                                      fontColor: colorGrey1,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        openDoc(
                                                            context,
                                                            data?.skills?[index]
                                                                    .skillDoc ??
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
                                                            fontColor:
                                                                colorGrey1,
                                                            fontWeight: medium,
                                                            maxLine: 1,
                                                            textAlign: TextAlign
                                                                .center,
                                                            txtHeight: 0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return getErrorMessage(userSnap.error);
                                }
                              },
                            );
                          } else {
                            return getErrorMessage(skillsSnap.data);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

openDoc(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * .65,
        height: MediaQuery.of(context).size.height * .95,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SfPdfViewer.network(url),
      ),
    ),
  );
}
