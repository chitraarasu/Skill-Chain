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
import '../../../app_controller/app_controller.dart';

class AppProfile extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    AppRouteController appRouteController = Get.find();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Obx(
                        () => CircleAvatar(
                          radius: 49,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              appRouteController.profileImage.value != null
                                  ? FileImage(
                                      appRouteController.profileImage.value!)
                                  : NetworkImage(appRouteController
                                          .loggedInUser.value?.imageUrl ??
                                      "") as ImageProvider,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        appRouteController.pickProfileImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 15,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                        controller: TextEditingController(
                            text: appRouteController.loggedInUser.value?.name),
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
                        controller: TextEditingController(
                            text: appRouteController
                                .loggedInUser.value?.mobileNo),
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
                        controller: TextEditingController(
                            text:
                                appRouteController.loggedInUser.value?.emailId),
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
                        controller: TextEditingController(
                            text:
                                appRouteController.loggedInUser.value?.address),
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
                      box.remove("authData");
                      box.remove("profileData");
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
