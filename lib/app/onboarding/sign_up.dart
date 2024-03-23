import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/app/app_controller/app_controller.dart';

import '../../web/utils/buttons/primary_button.dart';
import '../../web/utils/color_manager.dart';
import '../../web/utils/font_manager.dart';
import '../../web/utils/ui_element.dart';
import '../../web/utils/widgets/custom_textfield.dart';
import '../../web/utils/widgets/widgets.dart';

class SignUp extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();

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
                  "Sign Up",
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
                CustomTextField(
                  height: 44,
                  controller: name,
                  keyboardType: TextInputType.text,
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
                  controller: mobile,
                  keyboardType: TextInputType.number,
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
                  height: 44,
                  controller: emailId,
                  keyboardType: TextInputType.emailAddress,
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
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  hide: true,
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
                  controller: address,
                  keyboardType: TextInputType.streetAddress,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        "Sign Up",
                        onTap: () {
                          if (name.text.isEmpty) {
                            toastPlatform("Enter your name!");
                            return;
                          }
                          if (!mobile.text.isPhoneNumber) {
                            toastPlatform("Enter valid mobile number!");
                            return;
                          }
                          if (!emailId.text.isEmail) {
                            toastPlatform("Enter valid email!");
                            return;
                          }
                          if (password.text.length > 6) {
                            toastPlatform(
                                "Password should be above 6 characters!");
                            return;
                          }
                          if (address.text.isEmpty) {
                            toastPlatform("Enter your address!");
                            return;
                          }
                          AppRouteController.to.signUp(
                            name: name.text,
                            address: address.text,
                            mobileNo: mobile.text,
                            email: emailId.text,
                            password: password.text,
                          );
                        },
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
