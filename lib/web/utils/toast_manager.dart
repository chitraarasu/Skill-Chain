import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'color_manager.dart';
import 'font_manager.dart';

class ToastManager {
  static final shared = ToastManager();
  OverlayEntry? entry;
  final debounce = Debouncer(delay: const Duration(seconds: 2));

  show(
    String msg, {
    bool isSuccess = true,
    double? bottomSpace,
  }) {
    final state = Overlay.of(Get.overlayContext!);
    removeIfNeeded();
    entry = OverlayEntry(
        builder: (context) => ToastView(
              msg: msg,
              isSuccess: isSuccess,
              isNeedBottomSpace: bottomSpace,
            ));
    state.insert(entry!);
    handleTimer();
  }

  handleTimer() {
    debounce.call(() {
      removeIfNeeded();
    });
  }

  removeIfNeeded() {
    if (entry == null) return;
    entry?.remove();
    entry = null;
  }
}

class ToastView extends StatelessWidget {
  const ToastView({
    super.key,
    required this.msg,
    required this.isSuccess,
    required this.isNeedBottomSpace,
  });

  final String msg;
  final bool isSuccess;
  final double? isNeedBottomSpace;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Padding(
                padding: EdgeInsets.only(bottom: isNeedBottomSpace ?? 0),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 250),
                  decoration: BoxDecoration(
                    color: orange.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: firstFont,
                      fontWeight: isSuccess ? semiBold : regular,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
