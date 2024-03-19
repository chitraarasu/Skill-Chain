import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skill_chain/web/models/bc_user_model.dart';
import 'package:skill_chain/web/utils/ui_element.dart';

import '../../api/api_manager.dart';
import '../../api/service.dart';
import '../dashboard/dashboard.dart';

class AppRouteController extends GetxController {
  static AppRouteController to = Get.find();

  RxInt currentPos = RxInt(0);

  Rxn<BcUser> loggedInUser = Rxn();
  Rxn<String> token = Rxn();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    setAuthData(isInit: true);
    setProfileData(isInit: true);
    box.listenKey('authData', (value) {
      print(value);
      setAuthData();
    });
    box.listenKey('profileData', (value) {
      print(value);
      setProfileData();
    });
  }

  setAuthData({isInit = false}) {
    if (box.read("authData") != null) {
      token.value = box.read("authData");
    } else {
      token.value = null;
    }
    if (!isInit) update();
  }

  setProfileData({isInit = false}) {
    if (box.read("profileData") != null) {
      loggedInUser.value = BcUser.fromJson(box.read("profileData"));
    } else {
      loggedInUser.value = null;
    }
    if (!isInit) update();
  }

  Future signUp({
    required String name,
    required String address,
    required String mobileNo,
    required String email,
    required String password,
  }) async {
    var res = await APIManager.shared.response(
      APIRequest(EAPIRequest.signUp, param: {
        "name": name,
        "address": address,
        "image_url": "",
        "mobile_no": mobileNo,
        "email_id": email,
        "status": true,
        "password": password,
      }),
      isNeedLoading: true,
      isNeedErrorAlert: true,
    );

    if (res is Error) return null;

    if (res.data["status"]) {
      box.write("authData", res.data["data"]["token"]);
      await profile(true);
      Get.offAll(() => Dashboard());
    } else {
      toastPlatform(
          res.data["message"].toString().contains("email_id already exists")
              ? "Email already exist!"
              : "Something went wrong! please try again later.");
    }
  }

  Future login({
    required String publicId,
    required String password,
  }) async {
    var res = await APIManager.shared.response(
      APIRequest(EAPIRequest.signIn, param: {
        "public_id": publicId,
        "password": password,
      }),
      isNeedLoading: true,
      isNeedErrorAlert: true,
    );

    if (res is Error) return null;

    if (res.data["status"]) {
      print(res.data["data"]["token"]);
      box.write("authData", res.data["data"]["token"]);
      await profile(true);
      Get.offAll(() => Dashboard());
    } else {
      toastPlatform(res.data["message"].toString().contains("Invalid")
          ? res.data["message"]
          : "Something went wrong! please try again later.");
    }
  }

  Future profile(bool isNeedLoading) async {
    var res = await APIManager.shared.response(
      APIRequest(EAPIRequest.profile),
      isNeedLoading: isNeedLoading,
      isNeedErrorAlert: isNeedLoading,
    );

    if (res is Error) return null;

    if (res.data["status"]) {
      box.write("profileData", res.data["data"]);
    } else {
      toastPlatform("Something went wrong! please try again later.");
    }
  }

  logout() {
    box.remove("authData");
    box.remove("profileData");
  }
}
