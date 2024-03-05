import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

import 'font_manager.dart';

class LoadingManager {
  static final shared = LoadingManager();
  OverlayEntry? entry;

  OverlayEntry loadingOverlayEntry() {
    return OverlayEntry(builder: (BuildContext context) {
      return LoadingView1();
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

class LoadingView1 extends StatelessWidget {
  const LoadingView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: const Center(
          child: SizedBox(
            height: 50,
            width: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.lineScale,
              colors: [
                Colors.blue,
                Colors.red,
                Colors.yellow,
                Colors.green,
                Colors.orange
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const kLoading = Center(
  child: SizedBox(
    height: 50,
    width: 100,
    child: LoadingIndicator(
      indicatorType: Indicator.lineScale,
      colors: [
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.green,
        Colors.orange
      ],
    ),
  ),
);

getErrorMessage(msg) {
  return Center(
    child: getCustomFont(
      msg == null || msg == "null" || msg.toString().contains("subtype")
          ? "Your offers are waiting ! Steal the deals after some time."
          : msg.toString().contains("SocketException")
              ? "Please check your internet connection!"
              : msg.toString().contains("Exception")
                  ? "Your offers are waiting ! Steal the deals after some time."
                  : msg.toString(),
      16,
      fontColor: Colors.black,
      fontWeight:
          msg.toString().contains("brand is coming soon") ? semiBold : regular,
      textAlign: TextAlign.center,
    ),
  );
}
