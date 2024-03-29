import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/toast_manager.dart';

import 'loading_manager.dart';

String assetImage(String name, {String ext = 'png'}) {
  return 'assets/images/$name.$ext';
}

String svgImage(String name) {
  return 'assets/images/$name.svg';
}

String lottieAsset(String name) {
  return 'assets/lottie/$name.json';
}

String gifAsset(String name) {
  return 'assets/animation/$name.gif';
}

const double designWidth = 414;

double get scaleWidth {
  final width = Get.width;
  return width;
}

Widget vSpace(double value) {
  return SizedBox(height: value);
}

Widget hSpace(double value) {
  return SizedBox(width: value);
}

hideKeyboard() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}

unFocus(PointerDownEvent event) {
  hideKeyboard();
}

abstract class Screens {
  static const root = '/';
  static const dashboard = '/dashboard';
  static const verification = '/verification';
  static const addSkill = '/addSkill';
  static const institute = '/institute';
  static const skillApproval = '/skillApproval';
  static const users = '/users';
  static const settings = '/settings';
}

const packageName = "com.skill.chain";

final loadingManager = LoadingManager();

double toastBottomSpace40 = 45;
double toastBottomSpace65 = 65;

showToast(String msg, {isSuccess = true, double? bottomSpace}) {
  ToastManager.shared.show(
    msg == "null"
        ? "Something went wrong! please try again later"
        : msg.toString().contains("subtype")
            ? "Something went wrong! please try again later"
            : msg,
    isSuccess: isSuccess,
    bottomSpace: bottomSpace,
  );
}

void showCustomToast(String texts, BuildContext context) {
  Fluttertoast.showToast(
    msg: texts,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 12.0,
  );
}

void webToast(String texts) {
  Fluttertoast.showToast(
    msg: texts,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    fontSize: 16.0,
    webShowClose: true,
    webBgColor: "linear-gradient(to right, #EC5938, #EC5938)",
  );
}

void toastPlatform(String texts) {
  if (kIsWeb) {
    webToast(texts);
  } else {
    showToast(texts);
  }
}
