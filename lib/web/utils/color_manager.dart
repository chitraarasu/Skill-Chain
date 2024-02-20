import 'package:flutter/material.dart';

const Color colorGrey1 = Color(0xFF565E67);
const Color colorGrey2 = Color(0xFFEDEEF1);
const Color colorGrey3 = Color(0xFFA8AAB0);
const Color brown = Color(0xFFD1B8A4);
const Color brown1 = Color(0xFFF2F0EF);
const Color darkBlue = Color(0xFF101421);
const Color lightBlue = Color(0xFFA0CED6);
const Color orange = Color(0xFFEC5938);
const Color colorWhite = Color(0xFFF9F5F1);

const LinearGradient gradientColors = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFFF6D3D5),
    Color(0xFFFBDADC),
    Color(0xFFD2E6F5),
    Color(0xFFF2E8D3)
  ],
  tileMode: TileMode.clamp,
);

// Widget CNetImage(String url, {BoxFit boxFit = BoxFit.fill}) {
//   return CachedNetworkImage(
//     imageUrl: url,
//     fit: boxFit,
//     width: double.infinity,
//     height: double.infinity,
//     fadeInDuration: Duration(milliseconds: 200),
//     placeholder: (context, url) => Container(color: expireGrey1),
//     errorWidget: (context, url, error) => Icon(Icons.error),
//   );
// }
