import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_chain/web/utils/ui_element.dart';

class LoadingManager {
  static final shared = LoadingManager();
  OverlayEntry? entry;
  OverlayEntry loadingOverlayEntry() {
    return OverlayEntry(builder: (BuildContext context) {
      return const CircularProgressIndicator();
    });
  }

  showLoading() async {
    await Future.delayed(Duration.zero);
    final state = Overlay.of(Get.overlayContext!);
    if (entry == null) {
      entry = loadingOverlayEntry();
      state.insert(entry!);
    }
  }

  hideLoading() {
    if (entry != null) {
      entry?.remove();
      entry = null;
    }
  }
}

Widget commonSpace = vSpace(0);
