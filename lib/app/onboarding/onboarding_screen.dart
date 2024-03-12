import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:skill_chain/web/utils/resizer/fetch_pixels.dart';

import '../../web/utils/ui_element.dart';
import '../../web/utils/widgets/widgets.dart';
import 'login.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({Key? key}) : super(key: key);

  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: 'Sell a home',
                body:
                    'Whether you choose traditional listing or explore innovative selling methods, we\'re here to guide you towards a successful home sale.',
                image: buildImage(assetImage("skill")),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Buy a home',
                body:
                    'Discover your perfect home with us, where comfort meets your vision of a dream property.',
                image: buildImage(assetImage("block_chain")),
                decoration: getPageDecoration(),
              ),
            ],
            done: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: getCustomFont("Next", 18,
                    fontColor: Colors.white, maxLine: 1),
              ),
            ),
            onDone: () => goToPhoneNumberScreen(context),
            showSkipButton: true,
            skip:
                getCustomFont("Skip", 15, fontColor: Colors.black, maxLine: 1),
            onSkip: () => goToPhoneNumberScreen(context),
            skipStyle: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
              Colors.black,
            )),
            next: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            dotsDecorator: getDotDecoration(),
            globalBackgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  void goToPhoneNumberScreen(context) {
    // box.write("isSkipped", true);
    Get.offAll(
      () => Login(),
      transition: Transition.fadeIn,
    );
  }

  Widget buildImage(String path) {
    return Center(
      child: Image.asset(
        path,
        width: double.infinity,
      ),
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.black87,
        activeColor: Colors.black,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        footerPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
      );
}
