import 'package:get/get.dart';
import 'package:punjab_tourism/controllers/permmisions_controller.dart';

class PermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PermissionsController());
  }
}
