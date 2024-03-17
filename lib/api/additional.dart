import 'service.dart';

extension AdditionalExtension on APIRequest {
  String getMethod() {
    switch (type) {
      case EAPIRequest.getUserFromPublicIds:
      case EAPIRequest.addSkill:
        return 'POST';
      case EAPIRequest.allUsers:
        return 'GET';
    }
  }

  Map<String, String> getHeader() {
    // AuthController authController = Get.find();
    switch (type) {
      default:
        // if (authController.authData == null) {
        return {};
      // } else {
      //   return {
      //     "Authorization":
      //         'Bearer ${authController.authData?.data?.apiToken}',
      //   };
      // }
    }
  }
}
