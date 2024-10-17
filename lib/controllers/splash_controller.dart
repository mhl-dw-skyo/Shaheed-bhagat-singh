import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:permission_handler/permission_handler.dart';

import '../core.dart';

class SplashController extends GetxController {
  double bottomPad = 15;
  DashboardController dashboardController = Get.find();
  CategoryTypeController categoryTypeController = Get.find();
  DetailController detailController = Get.find();
  NearByController nearByController = Get.find();
  GuestController guestController = Get.find();
  bool checkPermission = false;
  String mobileNumber = '';
  late Timer timer;
  CommonService commonService = Get.find();
  late Stream<String> _tokenStream;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
    dashboardController.fetchLabelData();
  }

  permission() async {
    if (Platform.isAndroid) {
      try {
        Location location = new Location();
        bool _serviceEnabled;
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            debugPrint('Location Denied once');
          }
        }
      } catch (e) {
        print("Location Enabled Exception: $e");
      }
    }
    // await FirebaseMessaging.instance.requestPermission(
    //   announcement: true,
    //   carPlay: true,
    //   criticalAlert: true,
    // );
    final status = await ph.Permission.storage.status;
    if (!status.isGranted) {
      await ph.Permission.storage.request();
    }

    var status3 = await ph.Permission.bluetooth.status;
    if (!status3.isGranted) {
      await ph.Permission.bluetooth.request();
    }

    var status4 = await ph.Permission.bluetoothConnect.status;
    if (!status4.isGranted) {
      await ph.Permission.bluetoothConnect.request();
    }

    if (await ph.Permission.bluetoothConnect.status.isPermanentlyDenied) {
      ph.openAppSettings();
    }

    var status5 = await ph.Permission.bluetoothScan.status;
    if (!status5.isGranted) {
      await ph.Permission.bluetoothScan.request();
    }

    if (await ph.Permission.bluetoothScan.status.isPermanentlyDenied) {
      ph.openAppSettings();
    }

    await ph.Permission.bluetoothScan.request();
    await ph.Permission.bluetoothAdvertise.request();

    if (await ph.Permission.bluetooth.status.isPermanentlyDenied) {
      ph.openAppSettings();
    }

    //Permission for location...
    final locationStatus = await ph.Permission.location.status;
    if (locationStatus == ph.PermissionStatus.denied) {
      await ph.Permission.location.request();
    } else if (locationStatus == ph.PermissionStatus.permanentlyDenied) {
      await ph.openAppSettings();
    }
  }

  // pushNotifications() async {
  //   FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //     print('A new onMessageOpenedApp event was published!');
  //     if (message != null) {
  //       print(333333);
  //       // Helper.onBackgroundSound(message);
  //     }
  //   });
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     print('B new onMessageOpenedApp event was published!');
  //     print(44444);
  //     RemoteNotification? notification = message.notification;
  //     print(notification);
  //     if (notification != null) {
  //       String qrStatus = message.data['qr_status'] ?? '';
  //       print(qrStatus);
  //       GuestController guestController = Get.find();
  //       commonService.qrStatus.value = int.parse(qrStatus);
  //       commonService.qrStatus.refresh();
  //       guestController.forUser.refresh();
  //       await Future.delayed(Duration(seconds: 2));
  //       Get.toNamed('/thank-you');
  //       // Helper.onBackgroundSound(message);
  //     }
  //   });
  // }
  //
  // Future<void> updateFCMToken() async {
  //   FirebaseMessaging.instance.getToken(vapidKey: 'BJujnbaevDAIiUInLIMli_8LgyoUQ-bW9O0oDKT8OeB5V84D1bfOtdyH4kIbdNyFRyA0Gw0BlCj1Jyq-jX3n6cc').then(setToken);
  //   _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
  //   _tokenStream.listen(setToken);
  // }

  void setToken(String? token) async {
    print('FCM Token: $token');
    if (token != "" && token != null) {
      await GetStorage().write('fcm_token', token);
      GuestApi guestApi = Get.find();
      guestApi.updateFCMToken(token ?? '');
    }
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 3));
    bool check = GetStorage().read('EULA_agree') ?? false;
    if (!check) {
      Get.toNamed('/eula');
    } else {
      if (GetStorage().read('token') != null &&
          GetStorage().read('token') != '') {
        if (GetStorage().read('language_id') == "" ||
            GetStorage().read('language_id') == null) {
          Get.offNamed('/language');
        } else {
          dashboardController.fetchLabelData();
          dashboardController.fetchDashboardData();
          categoryTypeController.fetchTrailsData();
          detailController.getOfflineLocationsData();
          nearByController.getNearByData();
          if (GetStorage().read('user_type') != "U") {
            guestController.page = 1;
            guestController.showLoadMore = true;
            guestController.forUser.value = false;
            guestController.forUser.refresh();
            guestController.fetchGuestInformationHistory();
            Get.offNamed('/emp_dashboard');
          } else {
            Get.offNamed('/dashboard');
            await dashboardController.fetchBeaconData();
          }
        }
      } else {
        dashboardController.fetchLabelData();
        if (GetStorage().read('welcomeAudioPlayed') == null ||
            GetStorage().read('welcomeAudioPlayed') == '') {
          Helper.playWelcomeSound();
        }
        Get.offNamed('/login');
      }
    }
  }
}
