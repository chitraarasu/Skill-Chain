import 'package:flutter/material.dart';

import '../../../../web/utils/buttons/primary_button.dart';
import '../../../../web/utils/color_manager.dart';
import '../../../../web/utils/font_manager.dart';
import '../../../../web/utils/ui_element.dart';
import '../../../../web/utils/widgets/widgets.dart';

class AppAddSkill extends StatelessWidget {
  const AppAddSkill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getCustomFont("Add Skill", 20, fontWeight: bold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
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
                      CustomDropDown(),
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
                                  "Seelct File",
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
          ),
        ),
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'Item 1';

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: DropdownButton(
        value: dropdownvalue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        isExpanded: true,
        borderRadius: BorderRadius.circular(10),
        underline: Container(),
        padding: EdgeInsets.symmetric(horizontal: 15),
        onChanged: (String? newValue) {},
      ),
    );
  }
}
