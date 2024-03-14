import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../../web/utils/buttons/secondary_button.dart';
import '../../../../web/utils/color_manager.dart';
import 'open_certificate.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpace(20),
            getCustomFont("Dashboard", 20, fontWeight: bold),
            vSpace(12.5),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSpace(12.5),
                    Container(
                      decoration: BoxDecoration(
                        color: lightBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1593085512500-5d55148d6f0d"),
                                ),
                                hSpace(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                        "Markus D",
                                        18,
                                        fontWeight: semiBold,
                                        fontColor: Colors.black,
                                      ),
                                      vSpace(5),
                                      getCustomFont(
                                        "BCA Degree",
                                        14,
                                        fontWeight: medium,
                                        fontColor: Colors.black,
                                      ),
                                      vSpace(5),
                                      getCustomFont(
                                        "2 Skills",
                                        14,
                                        fontWeight: medium,
                                        fontColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            vSpace(20),
                            Divider(
                              height: 0,
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                            vSpace(20),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: SecondaryButton(
                                title: "Add Skill",
                                isNeedBorder: false,
                                radius: 10,
                                backgroundColor: darkBlue.withOpacity(0.75),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    vSpace(25),
                    getCustomFont("Public Id", 18, fontWeight: bold),
                    vSpace(15),
                    Container(
                      decoration: BoxDecoration(
                        color: brown,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            getCustomFont(
                              "1234567890",
                              15,
                              fontWeight: semiBold,
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.copy),
                            ),
                          ],
                        ),
                      ),
                    ),
                    vSpace(25),
                    getCustomFont("Skills", 18, fontWeight: bold),
                    vSpace(15),
                    ...List.generate(
                      5,
                      (index) => GestureDetector(
                        onTap: () {
                          Get.to(() => const OpenCertificate());
                        },
                        child: SkillCard(false),
                      ),
                    ).toList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final bool isNeedStatus;

  SkillCard(this.isNeedStatus);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.75, color: colorGrey1),
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/b/b9/Tamil_Nadu_Emblem.png",
                  ),
                ),
                hSpace(20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        "Tamil nadu state government.",
                        14,
                        fontWeight: semiBold,
                        maxLine: 2,
                      ),
                      vSpace(5),
                      getCustomFont(
                        "Skills",
                        13,
                        fontWeight: medium,
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (isNeedStatus)
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: getCustomFont(
                      "Pending",
                      13,
                      fontWeight: medium,
                      fontColor: orange,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
