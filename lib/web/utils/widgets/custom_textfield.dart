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
  final double? height;
  final int? hintSize;
  final double? borderRadius;

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
    this.height = 35,
    this.hintSize,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
    );

    return SizedBox(
      height: (height ?? 0) * (maxLine ?? 1),
      child: TextFormField(
        textAlign: textAlign,
        minLines: maxLine ?? 1,
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
        cursorHeight: 15,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        cursorColor: brown,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: colorGrey1,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          enabledBorder: isNeedborder ? border : InputBorder.none,
          disabledBorder: isNeedborder ? border : InputBorder.none,
          focusedBorder: isNeedborder ? border : InputBorder.none,
          border: isNeedborder ? border : InputBorder.none,
          focusedErrorBorder: isNeedborder ? border : InputBorder.none,
          errorBorder: isNeedborder ? border : InputBorder.none,
        ),
      ),
    );
  }
}
