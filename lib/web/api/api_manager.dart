// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:skill_chain/web/utils/ui_element.dart';

import '../utils/loading_manager.dart';
import 'service.dart';

class APIManager {
  static final shared = APIManager();
  final dio = Dio();

  APIManager() {
    final printInterceptor = PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90);
    dio.interceptors.add(printInterceptor);
  }

  Future response(
    APIRequest request, {
    Map<String, String>? header,
    isNeedLoading = false,
    isNeedErrorAlert = false,
  }) async {
    // AuthController authController = Get.find();

    final finalURL = '${request.baseURL}${request.endPoint}';
    var getResponse;
    // print(authController.authData?.data?.apiToken);
    if (isNeedLoading) LoadingManager.shared.showLoading();
    try {
      if (request.method == 'POST' || request.method == 'PUT') {
        getResponse = await dio.request(
          finalURL,
          data: request.parameter,
          options: Options(
            method: request.method,
            headers: header ?? request.header,
            receiveTimeout: Duration(seconds: 40),
          ),
        );
      } else {
        getResponse = await dio.request(
          finalURL,
          // queryParameters: request.parameter,
          options: Options(
            method: request.method,
            headers: header ?? request.header,
            receiveTimeout: Duration(seconds: 40),
          ),
        );
      }
    } on DioError catch (e) {
      String errorMsg = "Something went wrong! Please try again later.";
      if (e.response?.statusCode == 401) {
        // if (request.type != EAPIRequest.logout &&
        //     request.type != EAPIRequest.login) {
        // authController.logout();
        // }
      }
      if (isNeedErrorAlert) {
        if (e.toString().contains("timeout")) {
          webToast(errorMsg);
        } else if (e.response?.statusCode == 422) {
          if (e.response!.toString().contains("mobile_no")) {
            // cController.showToast(e.response!.data["mobile_no"][0]);
            return Future.error(e.response!.data["mobile_no"][0]);
          }
        }
        if (e.message.toString().contains("SocketException")) {
          webToast("Check you internet connection!");
        } else {
          if (e.response != null) {
            webToast(e.response!.data["message"]);
          } else {
            webToast("Something went wrong!");
          }
        }
        return Future.error(e.message.toString());
      }
      return Future.error(e.message.toString());
    } finally {
      if (isNeedLoading) LoadingManager.shared.hideLoading();
    }
    return getResponse;
  }
}
