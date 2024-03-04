import 'package:dio/dio.dart';
import 'package:skill_chain/web/api/additional.dart';
import 'package:skill_chain/web/api/url.dart';

enum EAPIRequest {
  login,
}

abstract class AAPIRequest {
  String get baseURL;

  String get endPoint;

  Map<String, String> get header;

  String get method;

  get parameter;
}

class APIRequest implements AAPIRequest {
  final EAPIRequest type;
  final String additional;
  final dynamic param;
  CancelToken? cancelToken;

  APIRequest(
    this.type, {
    this.param = const {},
    this.cancelToken,
    this.additional = '',
  });

  @override
  String get baseURL => getBaseURL();

  @override
  String get endPoint => getEndPoint(additional: additional);

  @override
  Map<String, String> get header => getHeader();

  @override
  String get method => getMethod();

  @override
  get parameter => param;
}
