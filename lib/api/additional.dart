import 'package:get/get.dart';

import '../app/app_controller/app_controller.dart';
import 'service.dart';

extension AdditionalExtension on APIRequest {
  String getMethod() {
    switch (type) {
      case EAPIRequest.getUserFromPublicIds:
      case EAPIRequest.addSkill:
      case EAPIRequest.signIn:
      case EAPIRequest.signUp:
        return 'POST';
      case EAPIRequest.allUsers:
      case EAPIRequest.profile:
        return 'GET';
    }
  }

  Map<String, String> getHeader() {
    AppRouteController authController = Get.find();
    switch (type) {
      default:
        if (authController.token.value == null) {
          return {};
        } else {
          return {
            "Authorization": 'Bearer ${authController.token.value}',
          };
        }
    }
  }
}
