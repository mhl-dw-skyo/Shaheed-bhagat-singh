import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../core.dart';

class GuestController extends GetxController {
  var scrollController = ScrollController().obs;
  CommonService commonService = Get.find();
  var name = "".obs;
  var guests = "".obs;
  GuestApi guestApi = Get.find();
  int page = 1;
  int limit = 10;
  var forUser = true.obs;
  bool showLoadMore = true;
  late VoidCallback guestScrollListener;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future saveGuestInformation() async {
    FocusManager.instance.primaryFocus?.unfocus();
    EasyLoading.show(status: 'loading...');
    var response = await guestApi.saveGuestInformation(name.value, guests.value);
    EasyLoading.dismiss();
    print(response);
    if (response['status']) {
      page = 1;
      showLoadMore = true;
      name.value = '';
      guests.value = '';
      commonService.qrStatus.value = 3;
      commonService.qrStatus.refresh();
      Fluttertoast.showToast(
        msg: response['msg'],
        backgroundColor: Colors.green,
        gravity: ToastGravity.TOP,
      );
      commonService.guestData.value.id = response['id'];
      commonService.guestData.value.name = response['name'];
      commonService.guestData.value.guests = response['guests'];
      commonService.guestData.value.date = response['date'];
      commonService.guestData.value.time = response['time'];
      commonService.guestData.value.qrUrl = response['qr_url'];
      commonService.guestData.refresh();
      Get.toNamed('/qr');
    } else {
      Fluttertoast.showToast(
        msg: response['msg'],
        backgroundColor: Get.theme.errorColor,
        gravity: ToastGravity.TOP,
      );
    }
  }

  Future deleteGuestInformation(int id) async {
    EasyLoading.show(status: 'loading...');
    var response = await guestApi.deleteGuestInformation(id);
    EasyLoading.dismiss();
    print(response);
    if (response['status']) {
      commonService.qrStatus.value = 3;
      commonService.qrStatus.refresh();
      Fluttertoast.showToast(
        msg: response['message'],
        backgroundColor: Colors.green,
        gravity: ToastGravity.TOP,
      );
      fetchGuestInformationHistory();
    } else {
      Fluttertoast.showToast(
        msg: response['message'],
        backgroundColor: Get.theme.errorColor,
        gravity: ToastGravity.TOP,
      );
    }
  }

  Future scanQR(String qr) async {
    forUser.value = false;
    forUser.refresh();
    EasyLoading.show(status: 'loading...');
    var response = await guestApi.scanQR(qr);
    EasyLoading.dismiss();
    Get.toNamed('/qr');
    if (response['status']) {
      commonService.guestData.value.id = response['id'] ?? 0;
      commonService.guestData.value.name = response['name'] ?? '';
      commonService.guestData.value.guests = response['guests'] ?? 0;
      commonService.guestData.value.date = response['date'] ?? '';
      commonService.guestData.value.time = response['time'] ?? '';
      commonService.guestData.refresh();
      commonService.qrStatus.value = response['qr_status'];
      commonService.qrStatus.refresh();
    } else {
      commonService.qrStatus.value = response['qr_status'];
      commonService.qrStatus.refresh();
    }
    if(response['fcm_token']!=null&&response['fcm_token']!=""){
    Map<String, dynamic> notification = {
      "body": "",
      "title": "",
      "click_action": 'FLUTTER_NOTIFICATION_CLICK',
    };
    Map<String, dynamic> data = {
      "qr_status": commonService.qrStatus.value.toString(),
      "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      "fcm_token": GetStorage().read('fcm_token') ?? '',
    };
    Helper.sendNotification(response['fcm_token'], notification, data);
    }
  }

  Future<void> fetchGuestInformationHistory() async {
    EasyLoading.show(status: 'loading...');
    var response = await guestApi.fetchGuestInformationHistory(page, limit, forUser.value);
    EasyLoading.dismiss();
    if (response['status']) {
      if (page == 1) {
        scrollController.value = ScrollController();
        scrollController.refresh();
        commonService.guestInformationData.value = GuestModel.fromJSON(response);
      } else {
        commonService.guestInformationData.value.data.addAll(GuestModel.fromJSON(response).data);
      }
      commonService.guestInformationData.refresh();
      if (commonService.guestInformationData.value.data.length >= commonService.guestInformationData.value.total) {
        showLoadMore = false;
      }
      if (page == 1) {
        guestScrollListener = () {
          if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent) {
            if (commonService.guestInformationData.value.data.length != commonService.guestInformationData.value.total && showLoadMore) {
              page = page + 1;
              fetchGuestInformationHistory();
            }
          }
        };
        scrollController.value.addListener(guestScrollListener);
        scrollController.refresh();
      }
    }
  }
}
