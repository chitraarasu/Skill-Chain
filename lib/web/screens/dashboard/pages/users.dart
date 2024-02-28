import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/buttons/primary_button.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../utils/resizer/fetch_pixels.dart';
import '../../../utils/widgets/custom_profile.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/top_categories.dart';

class Users extends StatelessWidget {
  List<String> topics = [
    "Profile",
    "Details",
    "",
    "Contact",
    "Public Id",
    "Status",
    "Options",
  ];

  List<String> access = [
    "Active",
    "Edit",
    "Manage",
    "View",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    PrimaryButton(
                      "Add Users",
                      buttonColor: Colors.white,
                      radius: 20,
                      textColor: colorGrey1,
                      padding: EdgeInsets.symmetric(
                        vertical: FetchPixels.getPixelHeight(20),
                        horizontal: FetchPixels.getPixelWidth(5),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField(
                      // borderRadius: 20,
                      isNeedborder: false,
                      hint: "Search",
                      height: null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          vSpace(15),
          TopCategories(topics),
          vSpace(10),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 25),
                      child: Row(
                        children: [
                          CustomProfile(),
                          hSpace(25),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getCustomFont(
                                  "Lorem ipsum",
                                  15,
                                  fontColor: Colors.black,
                                  fontWeight: bold,
                                  maxLine: 1,
                                ),
                                getCustomFont(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                  12,
                                  fontColor: colorGrey1,
                                  fontWeight: medium,
                                  maxLine: 3,
                                  textAlign: TextAlign.justify,
                                  txtHeight: 0,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                getCustomFont(
                                  "1234567890",
                                  13,
                                  fontColor: colorGrey1,
                                  fontWeight: semiBold,
                                  maxLine: 1,
                                  textAlign: TextAlign.justify,
                                  txtHeight: 0,
                                ),
                                getCustomFont(
                                  "test@gmail.com",
                                  13,
                                  fontColor: colorGrey1,
                                  fontWeight: semiBold,
                                  maxLine: 1,
                                  textAlign: TextAlign.justify,
                                  txtHeight: 0,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: getCustomFont(
                                "123456",
                                13,
                                fontColor: colorGrey1,
                                fontWeight: bold,
                                maxLine: 1,
                                textAlign: TextAlign.justify,
                                txtHeight: 0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(width: 1.5, color: darkGreen),
                                  color: lightGreen,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child: getCustomFont(
                                    access[Random().nextInt(access.length)],
                                    12,
                                    fontColor: darkGreen,
                                    fontWeight: bold,
                                    maxLine: 1,
                                    textAlign: TextAlign.justify,
                                    txtHeight: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PopupMenuButton<String>(
                                itemBuilder: (context) => ["Block", "Delete"]
                                    .map((e) => PopupMenuItem(
                                          value: "",
                                          child: getCustomFont(
                                            e,
                                            13,
                                            fontColor: colorGrey1,
                                            fontWeight: bold,
                                            maxLine: 1,
                                            textAlign: TextAlign.justify,
                                            txtHeight: 0,
                                          ),
                                        ))
                                    .toList(),
                                onSelected: (value) {},
                                elevation: 0,
                                color: Colors.white,
                                icon: Icon(Icons.more_vert_rounded),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
