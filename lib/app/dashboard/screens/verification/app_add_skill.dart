import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/loading_manager.dart';

import '../../../../web/models/institute_user_model.dart';
import '../../../../web/models/skills_model.dart';
import '../../../../web/utils/buttons/primary_button.dart';
import '../../../../web/utils/color_manager.dart';
import '../../../../web/utils/font_manager.dart';
import '../../../../web/utils/ui_element.dart';
import '../../../../web/utils/widgets/widgets.dart';
import '../../../app_controller/app_controller.dart';

class AppAddSkill extends StatelessWidget {
  const AppAddSkill({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouteController appRouteController = Get.find();

    Rxn<InstituteUserModel> selectedInstitute = Rxn();
    Rxn<List<SkillsModel>> skillList = Rxn();
    Rxn<SkillsModel> selectedSkill = Rxn();
    Rxn<PlatformFile> pickedFile = Rxn();

    return Scaffold(
      appBar: AppBar(
        title: getCustomFont("Add Skill", 20, fontWeight: bold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection("users").get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return kLoading;
              } else if (snapshot.hasData) {
                List<InstituteUserModel> insData = snapshot.data?.docs
                        .map((e) => InstituteUserModel.fromJson(e.data()))
                        .toList() ??
                    [];
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont(
                              "Select Institute",
                              16,
                              fontWeight: semiBold,
                              fontColor: colorGrey1,
                            ),
                            vSpace(10),
                            Obx(
                              () => CustomDropDown<InstituteUserModel>(
                                selectedItem: selectedInstitute.value,
                                items: insData,
                                onChange: (item) async {
                                  selectedInstitute.value = item;
                                  selectedSkill.value = null;
                                  skillList.value = [];
                                  QuerySnapshot<Map<String, dynamic>> res =
                                      await FirebaseFirestore.instance
                                          .collection("skills")
                                          .get();
                                  print(res.docs.map((e) => e.data()).toList());
                                  List<SkillsModel> skillData =
                                      skillsModelFromJson(res.docs
                                          .map((e) => e.data())
                                          .toList());
                                  skillList.value = skillData
                                      .where(
                                          (e) => e.accessId == item?.accessId)
                                      .toList();
                                },
                              ),
                            ),
                            vSpace(15),
                            getCustomFont(
                              "Select Skill",
                              16,
                              fontWeight: semiBold,
                              fontColor: colorGrey1,
                            ),
                            vSpace(10),
                            Obx(
                              () => CustomDropDown<SkillsModel>(
                                selectedItem: selectedSkill.value,
                                items: skillList.value,
                                onChange: (item) async {
                                  selectedSkill.value = item;
                                },
                              ),
                            ),
                            vSpace(15),
                            getCustomFont(
                              "Select Certificate",
                              16,
                              fontWeight: semiBold,
                              fontColor: colorGrey1,
                            ),
                            vSpace(10),
                            GestureDetector(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  PlatformFile file = result.files.single;
                                  pickedFile.value = file;
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        Expanded(
                                          child: getCustomFont(
                                            pickedFile.value != null
                                                ? pickedFile.value?.name ?? ""
                                                : "Select File",
                                            15,
                                            fontWeight: medium,
                                          ),
                                        ),
                                        Icon(Icons.add_box_outlined),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              "Add Skill",
                              borderColor: orange,
                              isNeedBorder: true,
                              textColor: orange,
                              radius: 10,
                              onTap: () async {
                                if (selectedInstitute.value == null) {
                                  toastPlatform("Select an institute!");
                                  return;
                                }
                                if (selectedSkill.value == null) {
                                  toastPlatform("Select your skill!");
                                  return;
                                }
                                if (pickedFile.value == null) {
                                  toastPlatform("Select a certificate!");
                                  return;
                                }
                                LoadingManager.shared.showLoading();
                                Reference storageReference =
                                    FirebaseStorage.instance.ref().child(
                                        'request_certificates/${selectedInstitute.value?.uid}-${selectedSkill.value?.skillId}-${appRouteController.loggedInUser.value?.publicId}.pdf');

                                UploadTask uploadTask = storageReference
                                    .putFile(File(pickedFile.value!.path!));

                                await uploadTask.whenComplete(() async {
                                  String? docUrl =
                                      await storageReference.getDownloadURL();
                                  print('Image URL: $docUrl');

                                  FirebaseFirestore.instance
                                      .collection("requests")
                                      .add({
                                    "industry_id": selectedInstitute.value?.uid,
                                    "skill_id": selectedSkill.value?.skillId,
                                    "user_id": appRouteController
                                        .loggedInUser.value?.publicId,
                                    "certificate_url": docUrl,
                                    "status": "Pending"
                                  });
                                  LoadingManager.shared.hideLoading();
                                  Get.back();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      vSpace(10),
                    ],
                  ),
                );
              } else {
                return getErrorMessage(snapshot.error);
              }
            },
          ),
        ),
      ),
    );
  }
}

abstract class NamedItem {
  String get name;
}

class CustomDropDown<T extends NamedItem> extends StatelessWidget {
  final T? selectedItem;
  final List<T>? items;
  final Function(T?)? onChange;

  const CustomDropDown({
    this.selectedItem,
    this.items,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: DropdownButton(
        value: selectedItem,
        hint: const Text("Select an item"),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items?.map((T items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items.name),
          );
        }).toList(),
        isExpanded: true,
        borderRadius: BorderRadius.circular(10),
        underline: Container(),
        padding: EdgeInsets.symmetric(horizontal: 15),
        onChanged: onChange,
      ),
    );
  }
}
