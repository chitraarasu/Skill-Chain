import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/controller/web_auth_controller.dart';

import '../../../../utils/buttons/primary_button.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/font_manager.dart';
import '../../../../utils/ui_element.dart';
import '../../../../utils/widgets/custom_textfield.dart';
import '../../../../utils/widgets/widgets.dart';

addInstitute(context) {
  List<String> access = [
    "10th",
    "12th",
    "Degree",
    "Extra Skills",
    "Experience",
  ];

  WebAuthController webAuth = Get.find();

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
                        ),
                        vSpace(15),
                        getCustomFont(
                          "Verification Id",
                          17,
                          fontWeight: bold,
                          fontColor: colorGrey1,
                        ),
                        vSpace(5),
                        CustomTextField(controller: webAuth.verificationId),
                        vSpace(15),
                        getCustomFont(
                          "Email Id",
                          17,
                          fontWeight: bold,
                          fontColor: colorGrey1,
                        ),
                        vSpace(5),
                        CustomTextField(controller: webAuth.email),
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
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1593085512500-5d55148d6f0d"),
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
                                    onChanged: (value) {
                                      webAuth.selectedAccess.value = value;
                                    },
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
                          controller: webAuth.password,
                        ),
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
                      "Save",
                      buttonColor: brown,
                      onTap: webAuth.addInstitute,
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
  const CustomIcons({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getIcon(
            Icons.remove_red_eye_rounded,
            onTap: () {},
          ),
          getIcon(Icons.edit),
          getIcon(Icons.delete, color: orange),
        ],
      ),
    );
  }
}
