import 'package:flutter/material.dart';

import '../font_manager.dart';
import '../resizer/fetch_pixels.dart';
import '../widgets/widgets.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double? radius;
  final EdgeInsets? padding;
  final Color? buttonColor;
  final Function()? onTap;

  PrimaryButton(this.title,
      {this.radius, this.padding, this.onTap, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: buttonColor,
        // side: const BorderSide(color: Colors.white, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 30.0),
        ),
        textStyle: const TextStyle(color: Colors.white),
      ),
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: FetchPixels.getPixelHeight(12),
          horizontal: FetchPixels.getPixelWidth(17),
        ),
        child: getCustomFont(
          title,
          16,
          fontColor: Colors.white,
          maxLine: 1,
          fontWeight: bold,
        ),
      ),
    );
  }
}
