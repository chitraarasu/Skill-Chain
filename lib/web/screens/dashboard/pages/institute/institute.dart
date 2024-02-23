import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/color_manager.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../../../../utils/widgets/custom_textfield.dart';

class Institute extends StatelessWidget {
  List<String> topics = [
    "Logo",
    "Name",
    "Details",
    "Verification",
    "Access",
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
          CustomTextField(
            borderRadius: 20,
            isNeedborder: false,
          ),
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
                        child: getCustomFont(e, 16,
                            fontColor: colorGrey1, fontWeight: bold),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
