import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core.dart';

class NearByController extends GetxController {
  ScrollController scrollController = ScrollController();
  var buttonLoader = false.obs;
  var loader = false.obs;
  CommonService commonService = Get.find();
  var name = "".obs;
  var phoneNo = "".obs;
  var title = "".obs;
  var message = "".obs;
  var selectedDirection = DirectionModel().obs;
  List<DirectionModel> directions = [];
  var selectedDropDown = NearByItem().obs;
  var isSwap = false.obs;
  var fromLat = 0.0.obs;
  var fromLng = 0.0.obs;
  var toLat = 0.0.obs;
  var toLng = 0.0.obs;
  var distance = ''.obs;
  var firstSelected = DirectionModel().obs;
  var secondSelected = NearByItem().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // getUserLocation('from');
    DirectionModel directionModel1 = DirectionModel(id: 1, name: 'Bhagat Singh Museum');
    directions.add(directionModel1);
    DirectionModel directionModel2 = DirectionModel(id: 2, name: 'Current Location');
    directions.add(directionModel2);
  }

  calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    distance.value = "${(12742 * asin(sqrt(a))).toStringAsFixed(1)} km";
    distance.refresh();
    loader.value = false;
    loader.refresh();
  }

  launchMapsUrl() async {
    final url = Uri.parse('https://www.google.com/maps/dir/?api=1&origin=${fromLat.value},${fromLng.value}&destination=${toLat.value},${toLng.value}&travelmode=driving&dir_action=navigate');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> getUserLocation(String type) async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    } else {
      _locationData = await location.getLocation();
      if (type == "from") {
        fromLat.value = _locationData.latitude;
        fromLng.value = _locationData.longitude;
      } else {
        toLat.value = _locationData.latitude;
        toLng.value = _locationData.longitude;
      }
      if (fromLat.value != 0.0 && fromLng.value != 0.0 && toLat.value != 0.0 && toLng.value != 0.0) {
        calculateDistance(fromLat.value, fromLng.value, toLat.value, toLng.value);
      }
    }
  }

  Future<void> getNearByData() async {
    String file = "";
    switch (GetStorage().read('language_id')) {
      case 1:
        file = "nearby.json";
        break;
      case 2:
        file = "nearby_hi.json";
        break;
      case 3:
        file = "nearby_pu.json";
        break;
    }
    try {
      final String data = await rootBundle.loadString('assets/data_files/$file');
      var response = jsonDecode(data);
      if (response['status']) {
        commonService.nearByData.value = NearByModel.fromJSON(response);
        commonService.nearByData.refresh();
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}
