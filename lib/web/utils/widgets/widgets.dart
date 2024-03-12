import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/font_manager.dart';

import '../resizer/fetch_pixels.dart';

Widget getCustomFont(String text, double fontSize,
    {Color? fontColor,
    int? maxLine,
    String fontFamily = firstFont,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight,
    bool horFactor = false}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: fontColor,
      fontFamily: firstFont,
      height: txtHeight,
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaler:
        TextScaler.linear(FetchPixels.getTextScale(horFactor: horFactor)),
  );
}
