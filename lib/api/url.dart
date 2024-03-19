import 'service.dart';

extension URLExtension on APIRequest {
  String getBaseURL() {
    switch (type) {
      default:
        return 'http://localhost:3000';
    }
  }

  String getEndPoint({String additional = ''}) {
    switch (type) {
      case EAPIRequest.getUserFromPublicIds:
        return "/user_from_public_id";
      case EAPIRequest.addSkill:
        return "/add_skill";
      case EAPIRequest.allUsers:
        return "";
      case EAPIRequest.signIn:
        return "/login";
      case EAPIRequest.signUp:
        return "/signup";
      case EAPIRequest.profile:
        return "/profile";
    }
  }
}
