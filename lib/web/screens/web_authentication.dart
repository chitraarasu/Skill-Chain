import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/resizer/fetch_pixels.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/custom_textfield.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../utils/buttons/primary_button.dart';
import '../utils/color_manager.dart';
import '../utils/frosted_glass.dart';

class WebAuthentication extends StatelessWidget {
  const WebAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: FrostedGlassBox(
        theWidth: double.infinity,
        theHeight: double.infinity,
        theChild: Center(
          child: Container(
            width: FetchPixels.getWidthPercentSize(35),
            // height: mediaQuery.height * .85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    vSpace(5),
                    const Image(
                      image: AssetImage("assets/app_icon.png"),
                      width: 60,
                    ),
                    vSpace(10),
                    getCustomFont(
                      "Welcome To Skill Chain",
                      30,
                      fontWeight: FontWeight.w600,
                    ),
                    vSpace(10),
                    getCustomFont(
                      "Glad to see you again 👋\nLogin to your account below",
                      14,
                      fontWeight: FontWeight.w600,
                      maxLine: 2,
                      textAlign: TextAlign.center,
                      fontColor: colorGrey1,
                    ),
                    vSpace(15),
                    Divider(
                      thickness: 2,
                    ),
                    vSpace(15),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                            "Email",
                            15,
                            fontWeight: FontWeight.w700,
                            maxLine: 2,
                            textAlign: TextAlign.start,
                            fontColor: colorGrey1,
                          ),
                          vSpace(5),
                          CustomTextField(),
                          vSpace(15),
                          getCustomFont(
                            "Password",
                            15,
                            fontWeight: FontWeight.w700,
                            maxLine: 2,
                            textAlign: TextAlign.start,
                            fontColor: colorGrey1,
                          ),
                          vSpace(5),
                          CustomTextField(),
                          vSpace(30),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              "Login",
                              buttonColor: brown,
                              radius: 10,
                            ),
                          ),
                          vSpace(15),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
