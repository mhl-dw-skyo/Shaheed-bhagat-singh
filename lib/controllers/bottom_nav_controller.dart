import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BottomNavController extends GetxController {
  var indexSelected = 0.obs; // Using .obs makes it observable

  @override
  void onInit() {
    super.onInit();
    // Initialize indexSelected based on user type
    indexSelected.value = GetStorage().read('user_type') != "U" ? 1 : 2;
  }

  updateIndex() {
    indexSelected.value = GetStorage().read('user_type') != "U" ? 1 : 2;
  }

  void changeIndex(int newIndex) {
    indexSelected.value = newIndex;
  }
}

enum UserType{
  user,
  gate_keeper,
}
