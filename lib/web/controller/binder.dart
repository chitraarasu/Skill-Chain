import 'package:get/get.dart';
import 'package:skill_chain/web/controller/web_auth_controller.dart';
import 'package:skill_chain/web/controller/web_verification_controller.dart';

class WebBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(WebAuthController());
    Get.put(WebVerificationController());
  }
}
