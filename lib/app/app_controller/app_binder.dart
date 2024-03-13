import 'package:get/get.dart';

import 'app_controller.dart';

class AppBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AppRouteController());
  }
}
