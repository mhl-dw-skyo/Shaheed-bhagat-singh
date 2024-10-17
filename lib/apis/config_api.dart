import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../core.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConfigApi {
  CommonService commonService = Get.find();
  Future deleteAccount() async {
    Uri uri = Helper.getUri('appconfig/account_delete');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": GetStorage().read('token') ?? '',
    };

    var response = await http.post(
      uri,
      headers: headers,
    );
    print(response.body);
    Fluttertoast.showToast(
      msg: commonService.labelData.value.data.deleteMsg,
      backgroundColor: Colors.green,
      gravity: ToastGravity.TOP,
    );
    return jsonDecode(response.body);
  }
}
