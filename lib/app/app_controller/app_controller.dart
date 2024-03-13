import 'package:get/get.dart';

class AppRouteController extends GetxController {
  static AppRouteController to = Get.find();

  RxInt currentPos = RxInt(0);
}
