import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:punjab_tourism/models/label_model.dart';

import '../core.dart';

class DashboardController extends GetxController {
  ScrollController scrollController = ScrollController();
  var buttonLoader = false.obs;
  var loader = false.obs;
  CommonService commonService = Get.find();
  var name = "".obs;
  var phoneNo = "".obs;
  var title = "".obs;
  var message = "".obs;
  var skipFirstTimeSteamData = true.obs;
  List<Beacon> beaconsJsonData = [];
  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;
  var catId = 0.obs;
  final _beacons = <Beacon>[];
  final GlobalKey<FormState> complaintFormKey = GlobalKey<FormState>();
  @override
  Future<void> onInit() async {
    super.onInit();

  }
  @override
  void onReady() {
    super.onReady();

  }

  startWelcomeSound(){

    // print(GetStorage().read('welcomeAudioPlayed'));
    // if (GetStorage().read('welcomeAudioPlayed') == null ||
    //     GetStorage().read('welcomeAudioPlayed') == '') {
      Helper.playWelcomeSound();
    // }
  }
  initBeaconService() async {
    // if (BluetoothState.stateOff.value == "STATE_OFF") {
    //   if (Platform.isAndroid) {
    //     try {
    //       await flutterBeacon.openBluetoothSettings;
    //     } on PlatformException catch (e) {
    //       print("Bluetooth Error: $e");
    //     }
    //   }
    // }
    print("3333333333");
    try {
      _streamBluetooth = flutterBeacon.bluetoothStateChanged().listen((BluetoothState state) async {
        print("stateddd $state");
        streamController.add(state);
        switch (state.value) {
          case 'STATE_ON':
            print("Bluetooth On");
            initScanBeacon();
            break;
          case 'STATE_OFF':
            print("Bluetooth Off");
            await pauseScanBeacon();
            await checkAllRequirements();
            break;
        }
      });
    } catch (e) {
      print("Exception $e");
    }
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    if (_beacons.isNotEmpty) {
      _beacons.clear();
    }
  }

  checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    final bluetoothEnabled = bluetoothState == BluetoothState.stateOn;
    await flutterBeacon.authorizationStatus.then((element) async {
      final authorizationStatusOk = element.value == "ALLOWED" || element.value == "ALWAYS" || element.value == "WHEN_IN_USE";
      final locationServiceEnabled = await flutterBeacon.checkLocationServicesIfEnabled;

      // setState(() {
      this.authorizationStatusOk = authorizationStatusOk;
      this.locationServiceEnabled = locationServiceEnabled;
      this.bluetoothEnabled = bluetoothEnabled;
      print("this.authorizationStatusOk ${this.authorizationStatusOk}");
      print("this.locationServiceEnabled ${this.locationServiceEnabled}");
      print("this.bluetoothEnabled ${this.bluetoothEnabled}");
      // });
    });
  }

  initScanBeacon() async {
    try {
      print("initializeScanning");
      // if you want to manage manual checking about the required permissions
      await flutterBeacon.initializeScanning;
    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      print("EXEPPPPPPP $e");
    }
    await checkAllRequirements();
    print("$authorizationStatusOk -- $locationServiceEnabled -- $bluetoothEnabled");
    if (!authorizationStatusOk || !locationServiceEnabled || !bluetoothEnabled) {
      return;
    }
    List<Region> regions = [];
    if (Platform.isAndroid) {
      for (var item in commonService.macAddresses) {
        regions.add(Region(
          identifier: item,
          macAddress: item,
        ));
      }
    } else {
      for (var item in commonService.uuid) {
        regions.add(Region(
          identifier: item,
          proximityUUID: item,
        ));
      }
    }

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    if (regions.isNotEmpty) {
      List<Region> regionsList = regions;
      if (Platform.isAndroid) {
        regionsList = [regions.first];
      }
      // print(regionsList);
      _streamRanging = flutterBeacon.ranging(regionsList).listen((RangingResult result) async {
        // print("Entered");
        // print(result);
        if (result != null && result.beacons.isNotEmpty) {
          beaconsJsonData = result.beacons;
          beaconsJsonData?.sort((m1, m2) {
            var r = m2.rssi.compareTo(m1.rssi);
            if (r != 0) return r;
            return m2.rssi.compareTo(m1.rssi);
          });
        }
        Timer(const Duration(seconds: 1), () async {
          beaconExecutionAlgorithm();
        });
      });
    }
  }

  beaconExecutionAlgorithm() async {
    if (beaconsJsonData.isNotEmpty) {
      Beacon beaconItem = beaconsJsonData.first;
      if (commonService.beaconsData.value.data.isNotEmpty) {
        double deviceDistanceInMeter = 99999999999999;
        if (beaconItem.rssi != 0) {
          deviceDistanceInMeter = double.parse(pow(10, (((beaconItem.rssi).abs() - (-59).abs()) / (10 * 2))).toStringAsFixed(2).toString());
        }
        int deviceInOurRangeIndex = -1;
        if (Platform.isAndroid) {
          deviceInOurRangeIndex = commonService.beaconsData.value.data.indexWhere((element) {
            return (element.macAddress.toLowerCase() == beaconItem.macAddress.toString().toLowerCase()) && (element.startRange <= deviceDistanceInMeter && deviceDistanceInMeter <= element.endRange);
          });
          //print("111MacAddress : ${beaconItem.macAddress} --- RSSI : ${beaconItem.rssi} --- Distance : $deviceDistanceInMeter");
        } else {
          deviceInOurRangeIndex = commonService.beaconsData.value.data.indexWhere((element) {
            return (element.uuid.toLowerCase() == beaconItem.proximityUUID.toString().toLowerCase()) && (element.startRange <= deviceDistanceInMeter && deviceDistanceInMeter <= element.endRange);
          });
          //print("proximityUUID : ${beaconItem.proximityUUID} --- RSSI : ${beaconItem.rssi} --- Distance : $deviceDistanceInMeter");
        }

        if (deviceInOurRangeIndex > -1) {
          BeaconItem beaconItemObj = commonService.beaconsData.value.data.elementAt(deviceInOurRangeIndex);
          if (Platform.isAndroid) {
            print("Detected 111MacAddress : ${beaconItem.macAddress} --- RSSI : ${beaconItem.rssi} --- Distance : $deviceDistanceInMeter");
          } else {
            print("Detected 111proximityUUID : ${beaconItem.proximityUUID} --- RSSI : ${beaconItem.rssi} --- Distance : $deviceDistanceInMeter --- ${beaconItemObj.startRange}:${beaconItemObj.endRange}");
          }
          if (beaconItemObj.action == '2') {
            commonService.inMuseum.value = false;
            commonService.inMuseum.refresh();
            AssetsAudioPlayer.allPlayers().forEach((key, value) {
              //value.stop();
            });
            commonService.assetsAudioPlayer.value.dispose();
            commonService.assetsAudioPlayer.value = AssetsAudioPlayer();
            commonService.sameCategoryBeacons.value = [];
            commonService.sameCategoryBeacons.refresh();
            commonService.lastPlayedMacAddress.value = '';
            commonService.lastPlayedMacAddress.refresh();
            return;
          } else {
            commonService.inMuseum.value = true;
            commonService.inMuseum.refresh();
            if (Platform.isAndroid) {
              if (commonService.lastPlayedMacAddress.value != beaconItemObj.macAddress) {
                commonService.selectedBeacon.value = beaconItemObj;
                commonService.selectedBeacon.refresh();
                if (commonService.selectedFileType.value == "V") {
                  print("Sarita ${beaconItemObj.locationId}");
                  if (!commonService.isPopSVPopupOpen.value) {
                    Helper.skipVideoConfirmation(beaconItemObj.locationId);
                  }
                  commonService.isPopSVPopupOpen.value = true;
                  commonService.isPopSVPopupOpen.refresh();
                } else {
                  DetailController detailController = Get.find();
                  detailController.getLocationDetailData(beaconItemObj.locationId);
                  if (Get.currentRoute != "/detail") {
                    Get.toNamed('/detail');
                  }
                }
                catId.value = beaconItemObj.type;
              }
            } else {
              if (commonService.lastPlayedMacAddress.value != beaconItemObj.uuid) {
                commonService.selectedBeacon.value = beaconItemObj;
                commonService.selectedBeacon.refresh();
                if (commonService.selectedFileType.value == "V") {
                  if (!commonService.isPopSVPopupOpen.value) {
                    Helper.skipVideoConfirmation(beaconItemObj.locationId);
                  }
                  commonService.isPopSVPopupOpen.value = true;
                  commonService.isPopSVPopupOpen.refresh();
                } else {
                  DetailController detailController = Get.find();
                  detailController.getLocationDetailData(beaconItemObj.locationId);
                  if (Get.currentRoute != "/detail") {
                    Get.toNamed('/detail');
                  }
                }
                catId.value = beaconItemObj.type;
              }
            }

            for (var element in commonService.beaconsData.value.data) {
              if (element.type == beaconItemObj.type && element.locationId > 0) {
                int sameTypeBeaconIndex = commonService.sameCategoryBeacons.indexWhere((ele) => ele.locationId == element.locationId);
                if (sameTypeBeaconIndex == -1) {
                  commonService.sameCategoryBeacons.add(element);
                  commonService.sameCategoryBeacons.refresh();
                }
              }
            }
          }
          commonService.lastPlayedMacAddress.value = Platform.isAndroid ? beaconItemObj.macAddress : beaconItemObj.uuid;
          commonService.lastPlayedMacAddress.refresh();
        }
      }
    }
  }

  Future<void> fetchEmpDashboardData() async {
    String file = "dashboard.json";
    if (GetStorage().read('language_id') != '' || GetStorage().read('language_id') != null) {
      switch (GetStorage().read('language_id')) {
        case 1:
          file = "dashboard.json";
          break;
        case 2:
          file = "dashboard_hi.json";
          break;
        case 3:
          file = "dashboard_pu.json";
          break;
      }
    }
    try {
      final String data = await rootBundle.loadString('assets/data_files/$file');
      var response = jsonDecode(data);
      if (response['status']) {
        commonService.dashboardData.value = DashboardModel.fromJSON(response);
        commonService.dashboardData.refresh();
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  Future<void> fetchDashboardData() async {
    String file = "dashboard.json";
    if (GetStorage().read('language_id') != '' || GetStorage().read('language_id') != null) {
      switch (GetStorage().read('language_id')) {
        case 1:
          file = "dashboard.json";
          break;
        case 2:
          file = "dashboard_hi.json";
          break;
        case 3:
          file = "dashboard_pu.json";
          break;
      }
    }
    try {
      final String data = await rootBundle.loadString('assets/data_files/$file');
      var response = jsonDecode(data);
      if (response['status']) {
        commonService.dashboardData.value = DashboardModel.fromJSON(response);
        commonService.dashboardData.refresh();
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  Future<void> fetchLabelData() async {
    String file = "label.json";
    if (GetStorage().read('language_id') != '' || GetStorage().read('language_id') != null) {
      switch (GetStorage().read('language_id')) {
        case 1:
          file = "label.json";
          break;
        case 2:
          file = "label_hi.json";
          break;
        case 3:
          file = "label_pu.json";
          break;
      }
    }
    try {
      final String data = await rootBundle.loadString('assets/data_files/$file');
      var response = jsonDecode(data);
      if (response['status']) {
        commonService.labelData.value = LabelModel.fromJSON(response);
        commonService.labelData.refresh();
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  Future<void> fetchBeaconData() async {
    String file = "beacon.json";
    String folderName = "english";
    if (GetStorage().read('language_id') != '' || GetStorage().read('language_id') != null) {
      switch (GetStorage().read('language_id')) {
        case 1:
          file = "beacon.json";
          folderName = "english";
          break;
        case 2:
          file = "beacon_hi.json";
          folderName = "hindi";
          break;
        case 3:
          file = "beacon_pu.json";
          folderName = "punjabi";
          break;
      }
    }
    try {
      final String data = await rootBundle.loadString('assets/data_files/$file');
      var response = jsonDecode(data);
      if (response['status'] == 200) {
        commonService.soundFiles.value = [];
        commonService.soundFiles.refresh();
        commonService.beaconsData.value = BeaconModel.fromJSON(response);
        commonService.beaconsData.refresh();
        for (var element in commonService.beaconsData.value.data) {
          if (!commonService.soundFiles.contains(element.soundFile) && element.soundFile.isNotEmpty && element.id > 10) {
            commonService.soundFiles.add(element.soundFile);
          }
          if (!commonService.macAddresses.contains(element.macAddress) && element.macAddress.length == 17) {
            commonService.macAddresses.add(element.macAddress);
          }
          if (!commonService.uuid.contains(element.uuid)) {
            commonService.uuid.add(element.uuid);
          }
        }
        commonService.soundFiles.refresh();
        commonService.macAddresses.refresh();
        commonService.uuid.refresh();
        Directory appDocDir;
        if (Platform.isAndroid) {
          appDocDir = await getExternalStorageDirectory();
        } else {
          appDocDir = await getApplicationDocumentsDirectory();
        }
        String outputDirectory = '${appDocDir.path}/$folderName';
        await Directory(outputDirectory).create(recursive: true);
        Helper.downloadAudios(folderName);
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  categoryTypesWidget() {
    Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Inside Virasat e khalsa"
            .text
            .textStyle(
              Get.textTheme.headline2.copyWith(
                color: Get.theme.indicatorColor.withOpacity(0.5),
              ),
            )
            .make()
            .pSymmetric(h: 20),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: Get.width,
          height: 60,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                LocationModel locationModel = LocationModel(image: 'assets/images/1.jpg');
                return SmallLocationViewWidget(
                  data: locationModel,
                );
              }),
        ).pSymmetric(h: 20)
      ],
    );
  }

  Future<void> submitComplaint() async {
    DashboardApi dashboardApi = Get.find();
    EasyLoading.show(status: 'loading...');
    Map data = {
      'username': name.value,
      'mobile_no': phoneNo.value,
      'title': title.value,
      'description': message.value,
    };
    var response = await dashboardApi.submitComplaint(data);
    EasyLoading.dismiss();
    if (response['status'] == 200) {
      Fluttertoast.showToast(
        msg: response['message'],
        backgroundColor: Colors.green,
        gravity: ToastGravity.TOP,
      );
      Get.back();
    } else {
      Fluttertoast.showToast(
        msg: response['message'],
        backgroundColor: Get.theme.errorColor,
        gravity: ToastGravity.TOP,
      );
    }
  }
}
