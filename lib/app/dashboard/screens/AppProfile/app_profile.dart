import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skill_chain/app/onboarding/onboarding_screen.dart';

import '../../../../web/utils/buttons/primary_button.dart';
import '../../../../web/utils/color_manager.dart';
import '../../../../web/utils/font_manager.dart';
import '../../../../web/utils/ui_element.dart';
import '../../../../web/utils/widgets/custom_textfield.dart';
import '../../../../web/utils/widgets/widgets.dart';

class AppProfile extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            vSpace(20),
            getCustomFont("Profile", 20, fontWeight: bold),
            vSpace(12.5),
            vSpace(7.5),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 7.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        "Name",
                        16,
                        fontWeight: semiBold,
                        fontColor: colorGrey1,
                      ),
                      vSpace(10),
                      CustomTextField(
                        height: 44,
                        enable: false,
                      ),
                      vSpace(10),
                      getCustomFont(
                        "Mobile number",
                        16,
                        fontWeight: semiBold,
                        fontColor: colorGrey1,
                      ),
                      vSpace(10),
                      CustomTextField(
                        height: 44,
                        enable: false,
                      ),
                      vSpace(10),
                      getCustomFont(
                        "Email id",
                        16,
                        fontWeight: semiBold,
                        fontColor: colorGrey1,
                      ),
                      vSpace(10),
                      CustomTextField(
                        enable: false,
                        height: 44,
                      ),
                      vSpace(10),
                      getCustomFont(
                        "Password",
                        16,
                        fontWeight: semiBold,
                        fontColor: colorGrey1,
                      ),
                      vSpace(10),
                      CustomTextField(
                        height: 44,
                        enable: false,
                      ),
                      vSpace(10),
                      getCustomFont(
                        "Address",
                        16,
                        fontWeight: semiBold,
                        fontColor: colorGrey1,
                      ),
                      vSpace(10),
                      CustomTextField(
                        height: 44,
                        maxLine: 3,
                        enable: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    "Logout",
                    borderColor: orange,
                    isNeedBorder: true,
                    textColor: orange,
                    radius: 10,
                    onTap: () {
                      box.write("isSkipped", false);
                      Get.offAll(() => OnBoardingPage());
                    },
                  ),
                ),
              ],
            ),
            vSpace(10),
          ],
        ),
      ),
    );
  }
}
