import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsController extends GetxController {
  Rx<PermissionStatus> location = Rx(PermissionStatus.restricted);
  Rx<PermissionStatus> storage = Rx(PermissionStatus.restricted);
  Rx<PermissionStatus> ble = Rx(PermissionStatus.restricted);
  Rx<PermissionStatus> bleConnect = Rx(PermissionStatus.restricted);
  Rx<PermissionStatus> bleScan = Rx(PermissionStatus.restricted);
  RxString status = "".obs;

  @override
  void onInit() {
    super.onInit();
    checkDefault(init: true);
  }

  Future<void> checkDefault({required bool init}) async {
    var loc = await Permission.location.status;
    var sto = await Permission.storage.status;
    var bleD = await Permission.bluetooth.status;
    var bleConnectD = await Permission.bluetoothConnect.status;
    var bleScanD = await Permission.bluetoothScan.status;

    if (loc == PermissionStatus.granted) {
      location.value = PermissionStatus.granted;
    } else {
      location.value = PermissionStatus.restricted;
    }
    if (sto == PermissionStatus.granted) {
      storage.value = PermissionStatus.granted;
    } else {
      storage.value = PermissionStatus.restricted;
    }
    if (bleD == PermissionStatus.granted) {
      ble.value = PermissionStatus.granted;
    } else {
      ble.value = PermissionStatus.restricted;
    }

    if (bleConnectD == PermissionStatus.granted) {
      bleConnect.value = PermissionStatus.granted;
    } else {
      bleConnect.value = PermissionStatus.restricted;
    }
    if (bleScanD == PermissionStatus.granted) {
      bleScan.value = PermissionStatus.granted;
    } else {
      bleScan.value = PermissionStatus.restricted;
    }
  }

  askForLocation() async {
    try {
      location.value = await Permission.location.request();
      validate();
    } catch (ee) {
      print(ee);
    }
  }

  askForStorage() async {
    storage.value = await Permission.storage.request();
  }

  askForBluetooth() async {
    ble.value = await Permission.bluetooth.request();
    validate();
  }

  askForBluetoothConnect() async {
    bleConnect.value = await Permission.bluetoothConnect.request();
    validate();
  }

  askForBluetoothScan() async {
    bleScan.value = await Permission.bluetoothScan.request();
    bleConnect.value = await Permission.bluetoothConnect.request();
    validate();
  }

  validate() {
    if (granted()) {
      Get.back(result: true);
    }
  }

  bool granted() {
    if (Platform.isAndroid)
      return bleConnect.value == PermissionStatus.granted && bleScan.value == PermissionStatus.granted &&
       location.value == PermissionStatus.granted;
    else
      return ble.value == PermissionStatus.granted &&
          location.value == PermissionStatus.granted;
  }
}
