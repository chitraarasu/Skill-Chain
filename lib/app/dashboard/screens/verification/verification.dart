import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../web/utils/font_manager.dart';
import '../../../../web/utils/ui_element.dart';
import '../../../../web/utils/widgets/widgets.dart';
import '../app_home/app_home.dart';
import 'app_add_skill.dart';

class AppVerification extends StatelessWidget {
  const AppVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpace(20),
            Row(
              children: [
                Expanded(
                  child: getCustomFont(
                    "Verification Request",
                    20,
                    fontWeight: bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => AppAddSkill());
                  },
                  icon: Icon(Icons.add_box_outlined),
                ),
              ],
            ),
            vSpace(12.5),
            vSpace(7.5),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 7.5),
                  child: Column(
                    children: List.generate(
                      12,
                      (index) => GestureDetector(
                        onTap: () {
                          // Get.to(() => const OpenCertificate());
                        },
                        child: SkillCard(true),
                      ),
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
