import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/controller/web_auth_controller.dart';
import 'package:skill_chain/web/utils/widgets/custom_profile.dart';

import '../../../../models/institute_user_model.dart';
import '../../../../utils/buttons/primary_button.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/font_manager.dart';
import '../../../../utils/ui_element.dart';
import '../../../../utils/widgets/custom_textfield.dart';
import '../../../../utils/widgets/widgets.dart';

addInstitute(context, {InstituteUserModel? data, bool isEdit = false}) {
  List<String> access = [
    "10th",
    "12th",
    "Degree",
    "Extra Skills",
    "Experience",
  ];

  WebAuthController webAuth = Get.find();

  webAuth.name.text = data?.instituteName ?? "";
  webAuth.email.text = data?.instituteEmail ?? "";
  webAuth.address.text = data?.instituteAddress ?? "";
  webAuth.verificationId.text = data?.instituteId ?? "";
  webAuth.selectedAccess.value = data?.instituteAccess;
  webAuth.password.text = data?.password ?? "";
  webAuth.selectedInstituteLogo.value = null;

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
                      "Institute Details",
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
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCustomFont(
                          "Institute Name",
                          17,
                          fontWeight: bold,
                          fontColor: colorGrey1,
                        ),
                        vSpace(5),
                        CustomTextField(
                          controller: webAuth.name,
                          enable: isEdit,
                        ),
                        vSpace(15),
                        getCustomFont(
                          "Institute Address",
                          17,
                          fontWeight: bold,
                          fontColor: colorGrey1,
                        ),
                        vSpace(5),
                        CustomTextField(
                          maxLine: 3,
                          height: null,
                          controller: webAuth.address,
                          enable: isEdit,
                        ),
                        vSpace(15),
                        getCustomFont(
                          "Verification Id",
                          17,
                          fontWeight: bold,
                          fontColor: colorGrey1,
                        ),
                        vSpace(5),
                        CustomTextField(
                          controller: webAuth.verificationId,
                          enable: isEdit,
                        ),
                        vSpace(15),
                        getCustomFont(
                          "Email Id",
                          17,
                          fontWeight: bold,
                          fontColor: colorGrey1,
                        ),
                        vSpace(5),
                        CustomTextField(
                          controller: webAuth.email,
                          enable: data == null,
                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Obx(
                                  () => SizedBox(
                                    width: 160,
                                    height: 160,
                                    child: ClipOval(
                                      child: Container(
                                        color: brown1,
                                        child: webAuth.selectedInstituteLogo
                                                    .value !=
                                                null
                                            ? Image.memory(webAuth
                                                .selectedInstituteLogo.value!)
                                            : data?.logo == null
                                                ? Image.asset(
                                                    assetImage("profile_dummy"))
                                                : NetImage(data?.logo ?? ""),
                                      ),
                                    ),
                                  ),
                                ),
                                if (isEdit)
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        webAuth.pickImages(isForIndustry: true);
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
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                                  ),
                              ],
                            ),
                          ],
                        ),
                        vSpace(30),
                        getCustomFont(
                          "Access",
                          17,
                          fontWeight: bold,
                          fontColor: colorGrey1,
                        ),
                        vSpace(5),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1),
                                ),
                                child: Obx(
                                  () => DropdownButton<String>(
                                    items: access.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: getCustomFont(
                                            value,
                                            17,
                                            fontWeight: medium,
                                            fontColor: colorGrey1,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: isEdit
                                        ? (value) {
                                            webAuth.selectedAccess.value =
                                                value;
                                          }
                                        : null,
                                    value: webAuth.selectedAccess.value,
                                    isExpanded: true,
                                    underline: Container(),
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        vSpace(15),
                        getCustomFont(
                          "Password",
                          17,
                          fontWeight: bold,
                          fontColor: colorGrey1,
                        ),
                        vSpace(5),
                        CustomTextField(
                          hide: true,
                          enable: data == null,
                          controller: webAuth.password,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              vSpace(isEdit ? 30 : 15),
              if (isEdit)
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        "Save",
                        buttonColor: brown,
                        onTap: () {
                          webAuth.addInstitute(data: data);
                        },
                        radius: 10,
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

class CustomIcons extends StatelessWidget {
  final InstituteUserModel data;

  CustomIcons(this.data);

  Widget getIcon(IconData icon, {Color? color, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          icon,
          color: color ?? colorGrey1,
          size: 20,
        ),
      ),
    );
  }

  WebAuthController webAuth = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getIcon(
            Icons.remove_red_eye_rounded,
            onTap: () {
              addInstitute(context, data: data, isEdit: false);
            },
          ),
          getIcon(Icons.edit, onTap: () {
            addInstitute(context, data: data, isEdit: true);
          }),
          getIcon(Icons.delete, color: orange, onTap: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) => AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                elevation: 0,
                content: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      getCustomFont("Are you sure you want to delete?", 18,
                          fontWeight: FontWeight.w600),
                      vSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              "Cancel",
                              onTap: () {
                                Get.back();
                              },
                              radius: 10,
                              textColor: brown,
                              borderColor: brown,
                              isNeedBorder: true,
                              padding: EdgeInsets.all(5),
                            ),
                          ),
                          hSpace(10),
                          Expanded(
                            child: PrimaryButton(
                              "Delete",
                              onTap: () {
                                webAuth.deleteIndustry(data);
                              },
                              radius: 10,
                              buttonColor: orange,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            );
          }),
        ],
      ),
    );
  }
}
