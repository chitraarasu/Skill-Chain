import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final Color? background;
  final int? maxLine;
  final TextEditingController? controller;
  final bool hide;
  final Function(String)? onChange;
  final double? width;
  final TextAlign textAlign;
  final bool isNeedTick;
  final isNeedborder;
  final enable;
  final keyboardType;
  String? Function(String?)? validate;
  final bool isBorderBlue;
  final double height;
  final int? hintSize;

  CustomTextField({
    this.hint,
    this.background,
    this.maxLine,
    this.controller,
    this.hide = false,
    this.textAlign = TextAlign.start,
    this.onChange,
    this.width,
    this.isNeedTick = true,
    this.isNeedborder = true,
    this.enable = true,
    this.validate,
    this.isBorderBlue = true,
    this.keyboardType,
    this.height = 40,
    this.hintSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlign: textAlign,
        maxLines: maxLine ?? 1,
        controller: controller,
        enabled: enable && isNeedTick,
        obscureText: hide,
        obscuringCharacter: '*',
        validator: validate,
        keyboardType: keyboardType,
        onChanged: (val) {
          if (onChange != null) {
            onChange!(val);
          }
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: colorGrey1,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
