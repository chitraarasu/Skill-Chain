import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/app/app_controller/app_controller.dart';
import 'package:skill_chain/app/onboarding/sign_up.dart';
import 'package:skill_chain/web/utils/buttons/primary_button.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/custom_textfield.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../web/utils/color_manager.dart';

class Login extends StatelessWidget {
  TextEditingController publicId = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSpace(15),
                getCustomFont(
                  "Sign In",
                  20,
                  fontWeight: bold,
                  fontColor: Colors.black,
                ),
                getCustomFont(
                  "Nice to see you again",
                  16,
                  fontColor: Colors.black,
                  fontWeight: medium,
                ),
                SizedBox(
                  height: 300,
                  child: Center(
                    child: Image.asset(
                      assetImage("auth"),
                      width: double.infinity,
                    ),
                  ),
                ),
                vSpace(10),
                getCustomFont(
                  "Public Id",
                  16,
                  fontWeight: semiBold,
                  fontColor: colorGrey1,
                ),
                vSpace(10),
                CustomTextField(height: 44, controller: publicId),
                vSpace(10),
                getCustomFont(
                  "Password",
                  16,
                  fontWeight: semiBold,
                  fontColor: colorGrey1,
                ),
                vSpace(10),
                CustomTextField(height: 44, controller: password),
                vSpace(50),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        "Login",
                        onTap: () {
                          if (publicId.text.isEmpty) {
                            toastPlatform("Enter the public id!");
                            return;
                          }
                          if (password.text.length > 6) {
                            toastPlatform(
                                "Password should be above 6 characters!");
                            return;
                          }
                          AppRouteController.to.login(
                            publicId: publicId.text,
                            password: password.text,
                          );
                        },
                        buttonColor: darkBlue,
                        radius: 10,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                vSpace(20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => SignUp());
                    },
                    child: getCustomFont(
                      "Didn't have account? Sign Up",
                      14,
                      fontWeight: medium,
                      fontColor: colorGrey1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                vSpace(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
