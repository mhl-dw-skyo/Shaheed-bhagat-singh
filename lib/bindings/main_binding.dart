import 'package:get/get.dart';

import '../core.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => ConfigApi());
    Get.lazyPut(() => DashboardApi());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => DetailApi());
    Get.lazyPut(() => DetailController());
    Get.lazyPut(() => CategoryTypeController());
    Get.lazyPut(() => NearByController());
    Get.lazyPut(() => GuestApi());
    Get.lazyPut(() => GuestController());
  }
}
