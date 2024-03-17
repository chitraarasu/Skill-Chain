import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skill_chain/web/screens/dashboard/pages/users.dart';
import 'package:skill_chain/web/utils/buttons/primary_button.dart';
import 'package:skill_chain/web/utils/loading_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/custom_textfield.dart';

import '../../../controller/web_auth_controller.dart';
import '../../../controller/web_verification_controller.dart';
import '../../../models/bc_user_model.dart';
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

  TextEditingController uIds = TextEditingController();

  bool validateUniqueNumbers(String numbersString) {
    List<String> numbers = numbersString.split(", ");
    Set<String> uniqueNumbers = Set.from(numbers);
    return numbers.length == uniqueNumbers.length;
  }

  @override
  Widget build(BuildContext context) {
    WebAuthController webAuth = Get.find();
    WebVerificationController webVerify = Get.find();

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
                                controller: uIds,
                                isNeedborder: false,
                                hint:
                                    "Enter comma separated public id. Like id1, id2....",
                                height: null,
                              ),
                            ),
                          ),
                        ),
                        hSpace(10),
                        GestureDetector(
                          onTap: () {
                            if (uIds.text.isEmpty) {
                              webToast("Enter valid public id's");
                            } else {
                              bool isValid = validateUniqueNumbers(uIds.text);
                              if (isValid) {
                                webVerify.getUserFromPublicId(
                                    uIds.text.split(", "), () {
                                  uIds.clear();
                                });
                              } else {
                                webToast(
                                    "Same public id entered multiple times!");
                              }
                            }
                          },
                          child: Container(
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
                    child: Obx(
                      () => webVerify.selectedUsers.isEmpty
                          ? Lottie.asset(lottieAsset("empty_user"))
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: webVerify.selectedUsers.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        BcUser data =
                                            webVerify.selectedUsers[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: colorWhite.withOpacity(.8),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                CustomProfile(
                                                  radius: isFromHome ? 20 : 25,
                                                  width: null,
                                                  image: data.imageUrl,
                                                ),
                                                hSpace(10),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      getCustomFont(
                                                        data.name ?? "",
                                                        isFromHome ? 15 : 17,
                                                        fontColor: Colors.black,
                                                        fontWeight: semiBold,
                                                      ),
                                                      getCustomFont(
                                                        data.publicId
                                                                ?.toString() ??
                                                            "",
                                                        isFromHome ? 14 : 15,
                                                        fontColor: colorGrey1,
                                                        fontWeight: semiBold,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (isForAddSkill)
                                                  Obx(
                                                    () => IconButton(
                                                      onPressed: () async {
                                                        FilePickerResult?
                                                            result =
                                                            await FilePicker
                                                                .platform
                                                                .pickFiles(
                                                          type: FileType.custom,
                                                          allowedExtensions: [
                                                            "pdf"
                                                          ],
                                                        );
                                                        if (result != null) {
                                                          data.setDocFile(result
                                                              .files
                                                              .single
                                                              .bytes!);
                                                        }
                                                      },
                                                      icon: CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor: data
                                                                    .selectedDoc
                                                                    .value ==
                                                                null
                                                            ? orange
                                                            : brown,
                                                        child: Icon(
                                                          data.selectedDoc
                                                                      .value ==
                                                                  null
                                                              ? Icons.add_box
                                                              : Icons
                                                                  .file_copy_rounded,
                                                          size: 18,
                                                          color: data.selectedDoc
                                                                      .value ==
                                                                  null
                                                              ? Colors.white
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                IconButton(
                                                  onPressed: () {
                                                    webVerify.selectedUsers
                                                        .removeAt(index);
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
                                          ),
                                        );
                                      }),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PrimaryButton(
                                        isForAddSkill ? "Add Skill" : "Verify",
                                        buttonColor: darkBlue,
                                        radius: 10,
                                        onTap: () async {
                                          if (webVerify
                                              .selectedSkills.isEmpty) {
                                            webToast("Please select skill!");
                                            return;
                                          }
                                          if (isForAddSkill) {
                                            if (webAuth
                                                    .customLoggedInUser.value ==
                                                null) {
                                              webToast(
                                                  "Admin can't add skills!");
                                              return;
                                            }

                                            String skillId = webVerify
                                                    .selectedSkills
                                                    .first
                                                    .skillId ??
                                                "";
                                            String instituteId = webAuth
                                                    .customLoggedInUser
                                                    .value
                                                    ?.uid ??
                                                "";

                                            List listOfUnSelectedFile =
                                                webVerify.selectedUsers
                                                    .where((element) =>
                                                        element.selectedDoc
                                                            .value ==
                                                        null)
                                                    .toList();
                                            if (listOfUnSelectedFile.isEmpty) {
                                              LoadingManager.shared
                                                  .showLoading();
                                              webToast("Uploading....");

                                              for (BcUser element
                                                  in webVerify.selectedUsers) {
                                                Reference storageReference =
                                                    FirebaseStorage.instance
                                                        .ref()
                                                        .child(
                                                            'certificates/$instituteId-$skillId-${element.publicId}.pdf');

                                                UploadTask uploadTask =
                                                    storageReference.putData(
                                                        element.selectedDoc
                                                            .value!);

                                                await uploadTask
                                                    .whenComplete(() async {
                                                  String docUrl =
                                                      await storageReference
                                                          .getDownloadURL();
                                                  print('Doc url: $docUrl');
                                                  element.setDocFileUrl(docUrl);
                                                });
                                              }

                                              List<bool> res =
                                                  await webVerify.addSkill(
                                                      skillId, instituteId);
                                              popUp(context, isForAddSkill,
                                                  apiStatus: res);
                                            } else {
                                              webToast(
                                                  "Please select certificates of selected user's");
                                            }
                                          } else {
                                            List<String> selectedSkillIds =
                                                webVerify.selectedSkills
                                                    .map((element) =>
                                                        element.skillId ?? "")
                                                    .toList();
                                            popUp(context, isForAddSkill,
                                                apiStatus: checkSelectedSkills(
                                                    webVerify.selectedUsers,
                                                    selectedSkillIds));
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
            ),
          ],
        ),
      ),
    );
  }

  List<bool> checkSelectedSkills(
      List<BcUser> users, List<String> selectedSkillIds) {
    List<bool> result = [];

    for (BcUser user in users) {
      bool hasAllSkills = true;
      for (String skillId in selectedSkillIds) {
        if (!(user.skills ?? []).any((skill) => skill.skillId == skillId)) {
          hasAllSkills = false;
          break;
        }
      }
      result.add(hasAllSkills);
    }

    return result;
  }

  popUp(BuildContext context, bool isForAddSkill, {List? apiStatus}) {
    WebVerificationController webVerify = Get.find();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * .6,
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
                        isForAddSkill ? "Skill Added" : "Verification Details",
                        24,
                        fontWeight: bold,
                        fontColor: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        webVerify.selectedUsers.value = [];
                        webVerify.selectedSkills.value = [];
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
                  webVerify.selectedUsers.length,
                  (index) => UsersTile(
                    isFromVerifySkill: true,
                    data: webVerify.selectedUsers[index],
                    active: apiStatus?[index],
                    isForAddSkill: !isForAddSkill,
                  ),
                )
              ],
            ),
          ),
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
                webVerifyController.selectedSkills.value = [];
                webVerifyController.selectedSkills.add(item);
              } else {
                if (webVerifyController.selectedSkills.contains(item)) {
                  webVerifyController.selectedSkills.remove(item);
                } else {
                  webVerifyController.selectedSkills.add(item);
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
                      webVerifyController.selectedSkills.contains(item)
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
