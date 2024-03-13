import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../web/utils/buttons/primary_button.dart';
import '../../web/utils/color_manager.dart';
import '../../web/utils/font_manager.dart';
import '../../web/utils/ui_element.dart';
import '../../web/utils/widgets/custom_textfield.dart';
import '../../web/utils/widgets/widgets.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_rounded),
                ),
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
                vSpace(30),
                getCustomFont(
                  "Name",
                  16,
                  fontWeight: semiBold,
                  fontColor: colorGrey1,
                ),
                vSpace(10),
                CustomTextField(height: 44),
                vSpace(10),
                getCustomFont(
                  "Mobile number",
                  16,
                  fontWeight: semiBold,
                  fontColor: colorGrey1,
                ),
                vSpace(10),
                CustomTextField(height: 44),
                vSpace(10),
                getCustomFont(
                  "Email id",
                  16,
                  fontWeight: semiBold,
                  fontColor: colorGrey1,
                ),
                vSpace(10),
                CustomTextField(height: 44),
                vSpace(10),
                getCustomFont(
                  "Password",
                  16,
                  fontWeight: semiBold,
                  fontColor: colorGrey1,
                ),
                vSpace(10),
                CustomTextField(height: 44),
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
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        "Sign Up",
                        onTap: () {},
                        buttonColor: darkBlue,
                        radius: 10,
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
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
                      Get.back();
                    },
                    child: getCustomFont(
                      "Already have account? Sign In",
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
