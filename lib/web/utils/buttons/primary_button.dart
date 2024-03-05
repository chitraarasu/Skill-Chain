import 'package:flutter/material.dart';

import '../font_manager.dart';
import '../widgets/widgets.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double? radius;
  final EdgeInsets? padding;
  final Color? buttonColor;
  final Function()? onTap;
  final Color? textColor;
  final Color? borderColor;
  final bool isNeedBorder;

  PrimaryButton(
    this.title, {
    this.radius,
    this.padding,
    this.onTap,
    this.buttonColor,
    this.textColor = Colors.white,
    this.isNeedBorder = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: buttonColor,
        side: !isNeedBorder
            ? BorderSide.none
            : BorderSide(color: borderColor ?? Colors.white, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 30.0),
        ),
        textStyle: const TextStyle(color: Colors.white),
      ),
      onPressed: onTap,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 17,
            ),
        child: getCustomFont(
          title,
          16,
          fontColor: textColor,
          maxLine: 1,
          fontWeight: bold,
        ),
      ),
    );
  }
}
