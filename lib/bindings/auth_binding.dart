import 'package:get/get.dart';

import '../core.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthApi());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => DetailController());
    Get.lazyPut(() => GuestApi());
    Get.lazyPut(() => GuestController());
  }
}
