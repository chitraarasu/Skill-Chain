import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/buttons/secondary_button.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../utils/widgets/top_categories.dart';

class SkillApproval extends StatelessWidget {
  List<String> topics = [
    "SI NO",
    "Institute",
    "Skill Details",
    "Reg No",
    "Score",
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Row(
          //         children: [
          //           PrimaryButton(
          //             "Add Institute",
          //             buttonColor: Colors.white,
          //             radius: 20,
          //             textColor: colorGrey1,
          //             padding: EdgeInsets.symmetric(
          //               vertical: FetchPixels.getPixelHeight(20),
          //               horizontal: FetchPixels.getPixelWidth(5),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //           child: CustomTextField(
          //             // borderRadius: 20,
          //             isNeedborder: false,
          //             hint: "Search",
          //             height: null,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // vSpace(15),
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
                          SizedBox(
                            width: 55,
                            child: Center(
                              child: getCustomFont(
                                index.toString(),
                                14,
                                fontColor: Colors.black,
                                fontWeight: medium,
                                maxLine: 1,
                              ),
                            ),
                          ),
                          hSpace(25),
                          Expanded(
                            child: getCustomFont(
                              "University Name",
                              15,
                              fontColor: colorGrey1,
                              fontWeight: bold,
                              maxLine: 1,
                              textAlign: TextAlign.justify,
                              txtHeight: 0,
                            ),
                          ),
                          Expanded(
                            child: getCustomFont(
                              "BCA",
                              13,
                              fontColor: colorGrey1,
                              fontWeight: semiBold,
                              maxLine: 1,
                              textAlign: TextAlign.center,
                              txtHeight: 0,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: getCustomFont(
                                "123456",
                                13,
                                fontColor: colorGrey1,
                                fontWeight: medium,
                                maxLine: 1,
                                textAlign: TextAlign.justify,
                                txtHeight: 0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: getCustomFont(
                              "98%",
                              13,
                              fontColor: colorGrey1,
                              fontWeight: medium,
                              maxLine: 1,
                              textAlign: TextAlign.center,
                              txtHeight: 0,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20),
                                child: SecondaryButton(
                                  title: "View",
                                  color: brown,
                                ),
                              ),
                            ),
                          )
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
