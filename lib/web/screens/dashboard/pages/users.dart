import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/buttons/primary_button.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../models/bc_user_model.dart';
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
                        vertical: 20,
                        horizontal: 5,
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
                return UsersTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UsersTile extends StatelessWidget {
  final bool isFromVerifySkill;
  final BcUser? data;
  final bool? active;

  UsersTile({this.isFromVerifySkill = false, this.data, this.active});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
          child: Row(
            children: [
              CustomProfile(
                image: data?.imageUrl,
              ),
              hSpace(25),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont(
                      data?.name ?? "Lorem ipsum",
                      15,
                      fontColor: Colors.black,
                      fontWeight: bold,
                      maxLine: 1,
                    ),
                    getCustomFont(
                      data?.address ??
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
                      data?.mobileNo ?? "1234567890",
                      13,
                      fontColor: colorGrey1,
                      fontWeight: semiBold,
                      maxLine: 1,
                      textAlign: TextAlign.justify,
                      txtHeight: 0,
                    ),
                    getCustomFont(
                      data?.emailId ?? "test@gmail.com",
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
                    data?.publicId ?? "123456",
                    13,
                    fontColor: colorGrey1,
                    fontWeight: bold,
                    maxLine: 1,
                    textAlign: TextAlign.justify,
                    txtHeight: 0,
                  ),
                ),
              ),
              if (isFromVerifySkill)
                Expanded(
                  child: Center(
                    child: getCustomFont(
                      (active ?? false) ? "Skill Added" : "Skill Already Exist",
                      13,
                      fontColor: colorGrey1,
                      fontWeight: medium,
                      maxLine: 1,
                      textAlign: TextAlign.justify,
                      txtHeight: 0,
                    ),
                  ),
                ),
              if (isFromVerifySkill)
                Expanded(
                  child: Center(
                    child: Image(
                      image: AssetImage(
                        assetImage(
                            (active ?? false) ? "check" : "remove"), // remove
                      ),
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              if (!isFromVerifySkill)
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.5, color: darkGreen),
                        color: lightGreen,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: getCustomFont(
                          "Active",
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
              if (!isFromVerifySkill)
                Expanded(
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        userDetailsPopUp(context);
                      },
                      icon: Icon(Icons.remove_red_eye_rounded),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  userDetailsPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width * .6,
          height: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: getCustomFont(
                      "User Details",
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
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1593085512500-5d55148d6f0d"),
                                ),
                                hSpace(10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                        "Name",
                                        17,
                                        fontWeight: bold,
                                        fontColor: colorGrey1,
                                      ),
                                      vSpace(5),
                                      CustomTextField(
                                        enable: false,
                                        controller: TextEditingController(
                                          text: "User 1",
                                        ),
                                      ),
                                      vSpace(15),
                                      getCustomFont(
                                        "Email",
                                        17,
                                        fontWeight: bold,
                                        fontColor: colorGrey1,
                                      ),
                                      vSpace(5),
                                      CustomTextField(
                                        enable: false,
                                        controller: TextEditingController(
                                          text: "test@gmail.com",
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
                              fontColor: colorGrey1,
                            ),
                            vSpace(5),
                            CustomTextField(
                              enable: false,
                              controller: TextEditingController(
                                text: "1234567890",
                              ),
                            ),
                            vSpace(15),
                            getCustomFont(
                              "Public Id",
                              17,
                              fontWeight: bold,
                              fontColor: colorGrey1,
                            ),
                            vSpace(5),
                            CustomTextField(
                              enable: false,
                              controller: TextEditingController(
                                text: "1234567890",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    hSpace(20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                            "Skills",
                            17,
                            fontWeight: bold,
                            fontColor: colorGrey1,
                          ),
                          vSpace(5),
                          Expanded(
                            child: AutoHeightGridView(
                              itemCount: 10,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(12),
                              shrinkWrap: true,
                              builder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        getCustomFont(
                                          "University Name",
                                          17,
                                          fontWeight: bold,
                                          fontColor: colorGrey1,
                                        ),
                                        getCustomFont(
                                          "Reg No: 123456789",
                                          17,
                                          fontWeight: semiBold,
                                          fontColor: colorGrey1,
                                        ),
                                        getCustomFont(
                                          "Skill: BCA",
                                          17,
                                          fontWeight: medium,
                                          fontColor: colorGrey1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
