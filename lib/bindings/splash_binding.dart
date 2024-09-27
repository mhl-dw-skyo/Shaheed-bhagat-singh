import 'package:get/get.dart';

import '../core.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthApi());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => ConfigApi());
    // Get.lazyPut(() => ConfigController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => CategoryTypeController());
    Get.lazyPut(() => DetailController());
    Get.lazyPut(() => DashboardApi());
    Get.lazyPut(() => NearByController());
    Get.lazyPut(() => GuestApi());
    Get.lazyPut(() => GuestController());
  }
}
