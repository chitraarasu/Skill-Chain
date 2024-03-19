import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/loading_manager.dart';

import '../../../../web/models/institute_user_model.dart';
import '../../../../web/utils/buttons/primary_button.dart';
import '../../../../web/utils/color_manager.dart';
import '../../../../web/utils/font_manager.dart';
import '../../../../web/utils/ui_element.dart';
import '../../../../web/utils/widgets/widgets.dart';

class AppAddSkill extends StatelessWidget {
  const AppAddSkill({super.key});

  @override
  Widget build(BuildContext context) {
    Rxn<InstituteUserModel> selectedInstitute = Rxn();
    return Scaffold(
      appBar: AppBar(
        title: getCustomFont("Add Skill", 20, fontWeight: bold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection("users").get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return kLoading;
              } else if (snapshot.hasData) {
                List<InstituteUserModel> insData = snapshot.data?.docs
                        .map((e) => InstituteUserModel.fromJson(e.data()))
                        .toList() ??
                    [];
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont(
                              "Select Institute",
                              16,
                              fontWeight: semiBold,
                              fontColor: colorGrey1,
                            ),
                            vSpace(10),
                            Obx(
                              () => CustomDropDown<InstituteUserModel>(
                                selectedItem: selectedInstitute.value,
                                items: insData,
                                onChange: (item) {
                                  selectedInstitute.value = item;
                                },
                              ),
                            ),
                            vSpace(15),
                            getCustomFont(
                              "Select Skill",
                              16,
                              fontWeight: semiBold,
                              fontColor: colorGrey1,
                            ),
                            vSpace(10),
                            CustomDropDown(),
                            vSpace(15),
                            getCustomFont(
                              "Select Certificate",
                              16,
                              fontWeight: semiBold,
                              fontColor: colorGrey1,
                            ),
                            vSpace(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: getCustomFont(
                                        "Select File",
                                        15,
                                        fontWeight: medium,
                                      ),
                                    ),
                                    Icon(Icons.add_box_outlined),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              "Add Skill",
                              borderColor: orange,
                              isNeedBorder: true,
                              textColor: orange,
                              radius: 10,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      vSpace(10),
                    ],
                  ),
                );
              } else {
                return getErrorMessage(snapshot.error);
              }
            },
          ),
        ),
      ),
    );
  }
}

abstract class NamedItem {
  String get name;
}

class CustomDropDown<T extends NamedItem> extends StatelessWidget {
  final T? selectedItem;
  final List<T>? items;
  final Function(T?)? onChange;

  const CustomDropDown({
    this.selectedItem,
    this.items,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: DropdownButton(
        value: selectedItem,
        hint: const Text("Select an item"),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items?.map((T items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items.name),
          );
        }).toList(),
        isExpanded: true,
        borderRadius: BorderRadius.circular(10),
        underline: Container(),
        padding: EdgeInsets.symmetric(horizontal: 15),
        onChanged: onChange,
      ),
    );
  }
}
