import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import '../color_manager.dart';
import '../font_manager.dart';

class TopCategories extends StatelessWidget {
  List<String> topics;

  TopCategories(this.topics);

  Widget AddCenter({required bool isNeedCenter, required Widget child}) {
    return isNeedCenter ? Center(child: child) : child;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
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
    );
  }
}
