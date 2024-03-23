import 'package:dio/dio.dart';

import 'service.dart';

String? _url;

Future<String?> fetchBaseUrl() async {
  var response = await Dio()
      .get('https://chitraarasu.github.io/Skill-Chain/lib/path.json');
  print(response.data.toString());
  if (response.data["active"]) {
    _url = response.data["url"];
  }
  return _url;
}

extension URLExtension on APIRequest {
  String getBaseURL() {
    switch (type) {
      default:
        return _url ?? 'http://localhost:3000';
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
      case EAPIRequest.updateProfile:
        return "/update_profile";
    }
  }
}
