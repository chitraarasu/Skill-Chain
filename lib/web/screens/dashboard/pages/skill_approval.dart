import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/buttons/secondary_button.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../utils/buttons/primary_button.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/top_categories.dart';

class SkillApproval extends StatelessWidget {
  List<String> topics = [
    "SI NO",
    "Institute",
    "Skill Details",
    "Reg No",
    "Certificate",
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.link,
                                  size: 17,
                                ),
                                hSpace(5),
                                getCustomFont(
                                  "Open",
                                  13,
                                  fontColor: colorGrey1,
                                  fontWeight: medium,
                                  maxLine: 1,
                                  textAlign: TextAlign.center,
                                  txtHeight: 0,
                                ),
                              ],
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
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,
                                        content: SingleChildScrollView(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: getCustomFont(
                                                        "Skill Approval",
                                                        24,
                                                        fontWeight: bold,
                                                        fontColor: Colors.black,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor: brown,
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                vSpace(15),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          getCustomFont(
                                                            "Institute",
                                                            17,
                                                            fontWeight: bold,
                                                            fontColor:
                                                                colorGrey1,
                                                          ),
                                                          vSpace(5),
                                                          CustomTextField(
                                                            enable: false,
                                                            controller:
                                                                TextEditingController(
                                                              text:
                                                                  "University Name",
                                                            ),
                                                          ),
                                                          vSpace(15),
                                                          getCustomFont(
                                                            "Skill Details",
                                                            17,
                                                            fontWeight: bold,
                                                            fontColor:
                                                                colorGrey1,
                                                          ),
                                                          vSpace(5),
                                                          CustomTextField(
                                                            enable: false,
                                                            controller:
                                                                TextEditingController(
                                                              text: "BCA",
                                                            ),
                                                          ),
                                                          vSpace(15),
                                                          getCustomFont(
                                                            "Reg Id",
                                                            17,
                                                            fontWeight: bold,
                                                            fontColor:
                                                                colorGrey1,
                                                          ),
                                                          vSpace(5),
                                                          CustomTextField(
                                                            enable: false,
                                                            controller:
                                                                TextEditingController(
                                                              text:
                                                                  "1234567890",
                                                            ),
                                                          ),
                                                          vSpace(15),
                                                          getCustomFont(
                                                            "Score",
                                                            17,
                                                            fontWeight: bold,
                                                            fontColor:
                                                                colorGrey1,
                                                          ),
                                                          vSpace(5),
                                                          CustomTextField(
                                                            enable: false,
                                                            controller:
                                                                TextEditingController(
                                                              text: "98%",
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    hSpace(20),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 70,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "https://images.unsplash.com/photo-1593085512500-5d55148d6f0d"),
                                                              ),
                                                              hSpace(10),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    getCustomFont(
                                                                      "Name",
                                                                      17,
                                                                      fontWeight:
                                                                          bold,
                                                                      fontColor:
                                                                          colorGrey1,
                                                                    ),
                                                                    vSpace(5),
                                                                    CustomTextField(
                                                                      enable:
                                                                          false,
                                                                      controller:
                                                                          TextEditingController(
                                                                        text:
                                                                            "User 1",
                                                                      ),
                                                                    ),
                                                                    vSpace(15),
                                                                    getCustomFont(
                                                                      "Email",
                                                                      17,
                                                                      fontWeight:
                                                                          bold,
                                                                      fontColor:
                                                                          colorGrey1,
                                                                    ),
                                                                    vSpace(5),
                                                                    CustomTextField(
                                                                      enable:
                                                                          false,
                                                                      controller:
                                                                          TextEditingController(
                                                                        text:
                                                                            "test@gmail.com",
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          vSpace(10),
                                                          getCustomFont(
                                                            "Mobile",
                                                            17,
                                                            fontWeight: bold,
                                                            fontColor:
                                                                colorGrey1,
                                                          ),
                                                          vSpace(5),
                                                          CustomTextField(
                                                            enable: false,
                                                            controller:
                                                                TextEditingController(
                                                              text:
                                                                  "1234567890",
                                                            ),
                                                          ),
                                                          vSpace(15),
                                                          getCustomFont(
                                                            "Public Id",
                                                            17,
                                                            fontWeight: bold,
                                                            fontColor:
                                                                colorGrey1,
                                                          ),
                                                          vSpace(5),
                                                          CustomTextField(
                                                            enable: false,
                                                            controller:
                                                                TextEditingController(
                                                              text:
                                                                  "1234567890",
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                vSpace(30),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: PrimaryButton(
                                                        "Reject",
                                                        // buttonColor: orange,
                                                        radius: 10,
                                                        textColor: orange,
                                                        isNeedBorder: true,
                                                        borderColor: orange,
                                                      ),
                                                    ),
                                                    hSpace(20),
                                                    Expanded(
                                                      child: PrimaryButton(
                                                        "Approve",
                                                        buttonColor: darkGreen,
                                                        radius: 10,
                                                        textColor: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
