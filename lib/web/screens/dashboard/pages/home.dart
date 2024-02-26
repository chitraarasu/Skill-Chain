import 'package:flutter/material.dart';
import 'package:skill_chain/web/screens/dashboard/pages/verification.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../utils/color_manager.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget statText(String text, String subText) {
    return Expanded(
      child: Column(
        children: [
          getCustomFont(text, 35,
              fontColor: Colors.white, fontWeight: semiBold),
          getCustomFont(subText, 12,
              fontColor: Colors.white.withOpacity(.7), fontWeight: semiBold),
        ],
      ),
    );
  }

  Widget circleText(Color color, String subText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          hSpace(25),
          getCustomFont(
            subText,
            15,
            fontColor: Colors.white,
            fontWeight: semiBold,
          )
        ],
      ),
    );
  }

  Widget bottomBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Container(
            height: 156,
            width: 156,
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSpace(15),
                  getCustomFont("This Day", 16, fontWeight: semiBold),
                  Spacer(),
                  getCustomFont("133 ", 35, fontWeight: bold),
                ],
              ),
            ),
          ),
          Positioned(
            top: -24,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont("Performance", 20,
                                fontColor: Colors.white, fontWeight: semiBold),
                            vSpace(10),
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      statText("76%", "Income"),
                                      SizedBox(
                                        height: 40,
                                        child: VerticalDivider(
                                          thickness: 1,
                                          color: Colors.white.withOpacity(.5),
                                        ),
                                      ),
                                      statText("44%", "Spending"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            circleText(orange, "Lorem Ipsum is dummy text"),
                            circleText(lightBlue, "Lorem Ipsum is dummy text"),
                            circleText(brown, "Lorem Ipsum is dummy text"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                hSpace(25),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Verification(
                      isFromHome: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          vSpace(25),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: brown,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont("Engagement", 24, fontWeight: semiBold),
                          Spacer(),
                          getCustomFont(
                            "General statistics of\nuser engagement\nprocess.",
                            15,
                            fontWeight: medium,
                          ),
                        ],
                      ),
                      hSpace(60),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              bottomBox(),
                              bottomBox(),
                              bottomBox(),
                              bottomBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
