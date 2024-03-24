import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/models/institute_user_model.dart';
import 'package:skill_chain/web/utils/buttons/primary_button.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/loading_manager.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../../utils/widgets/custom_profile.dart';
import '../../../../utils/widgets/custom_textfield.dart';
import 'custom_icons.dart';

class Institute extends StatelessWidget {
  List<String> topics = [
    "Logo",
    "Details",
    "",
    "Verification",
    "Access",
    "Options",
  ];

  Widget AddCenter({required bool isNeedCenter, required Widget child}) {
    return isNeedCenter ? Center(child: child) : child;
  }

  Widget getIcon(IconData icon, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon(
        icon,
        color: color ?? colorGrey1,
        size: 20,
      ),
    );
  }

  RxList docs = RxList();
  RxList filteredDoc = RxList();

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
                      "Add Institute",
                      onTap: () {
                        addInstitute(context, isEdit: true);
                      },
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
                      onChange: (value) {
                        filteredDoc.value = docs
                            .where((element) => element["institute_name"]
                                .toString()
                                .toLowerCase()
                                .contains(value))
                            .toList();
                        // print(data.length);
                        // filteredDoc.value = data
                        //     .map((e) => InstituteUserModel.fromJson(e))
                        //     .toList();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          vSpace(15),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
              child: Row(
                children: topics
                    .map(
                      (e) => Expanded(
                        flex: topics.indexOf(e) == 0 ? 0 : 1,
                        child: AddCenter(
                          isNeedCenter: topics.indexOf(e) > 1,
                          child: SizedBox(
                            width: topics.indexOf(e) == 0 ? 80 : null,
                            child: getCustomFont(e, 16,
                                fontColor: colorGrey1, fontWeight: bold),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          vSpace(10),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .orderBy(
                    'created_at',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return kLoading;
                } else if (snapshot.hasData) {
                  print(snapshot.data?.docs);
                  docs.value =
                      snapshot.data?.docs.map((item) => item.data()).toList() ??
                          [];
                  filteredDoc.value =
                      snapshot.data?.docs.map((item) => item.data()).toList() ??
                          [];

                  return Obx(
                    () => ListView.builder(
                      itemCount: filteredDoc.length,
                      itemBuilder: (BuildContext context, int index) {
                        InstituteUserModel model =
                            InstituteUserModel.fromJson(filteredDoc[index]);

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
                                  CustomProfile(image: model.logo),
                                  hSpace(25),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getCustomFont(
                                          model.instituteName ?? "",
                                          15,
                                          fontColor: Colors.black,
                                          fontWeight: bold,
                                          maxLine: 1,
                                        ),
                                        getCustomFont(
                                          model.instituteAddress ?? "",
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
                                    child: Center(
                                      child: getCustomFont(
                                        model.instituteId ?? "",
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.5, color: darkGreen),
                                          color: lightGreen,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 12),
                                          child: getCustomFont(
                                            model.instituteAccess ?? "",
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
                                  CustomIcons(model),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return getErrorMessage(snapshot.error);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
