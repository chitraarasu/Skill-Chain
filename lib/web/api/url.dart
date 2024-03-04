import 'service.dart';

extension URLExtension on APIRequest {
  String getBaseURL() {
    switch (type) {
      default:
        return 'https://api.pauket.com/api/agent';
    }
  }

  String getEndPoint({String additional = ''}) {
    switch (type) {
      case EAPIRequest.login:
        return "/login";
    }
  }
}
