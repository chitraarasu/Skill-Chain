import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../web/utils/color_manager.dart';

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
            vSpace(10),
            getCustomFont("Dashboard", 20, fontWeight: bold),
            vSpace(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        "Markus D",
                        18,
                        fontWeight: semiBold,
                      ),
                      vSpace(5),
                      getCustomFont(
                        "BCA Degree",
                        14,
                        fontWeight: medium,
                        fontColor: colorGrey1,
                      ),
                      vSpace(5),
                      getCustomFont(
                        "2 Skills",
                        14,
                        fontWeight: medium,
                        fontColor: colorGrey1,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
