import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../core.dart';

class GuestApi extends GetConnect {
  Future updateFCMToken(String token) async {
    print(GetStorage().read('token'));
    Uri uri = Helper.getUri('EntryQrController/update_fcm');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${GetStorage().read('token') ?? ''}",
    };
    print(jsonEncode({
      'fcm_token': token,
    }));
    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'fcm_token': token,
      }),
    );
    print(response.body);
    return jsonDecode(response.body);
  }

  Future saveGuestInformation(String name, String guests) async {
    Uri uri = Helper.getUri('EntryQrController/store_entry_qr_data');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${GetStorage().read('token') ?? ''}",
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'name': name,
        'guests': guests.toString(),
      }),
    );
    print(response.body);
    return jsonDecode(response.body);
  }

  Future deleteGuestInformation(int id) async {
    Uri uri = Helper.getUri('EntryQrController/delete_guest_request');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${GetStorage().read('token') ?? ''}",
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'id': id.toString(),
      }),
    );
    print(response.body);
    return jsonDecode(response.body);
  }

  Future scanQR(String qr) async {
    print(qr);
    Uri uri = Helper.getUri('EntryQrController/scanQrCode');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${GetStorage().read('token') ?? ''}",
    };
    print(uri);
    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'qr_value': qr.toString(),
      }),
    );
    print(response.body);
    return jsonDecode(response.body);
  }

  Future fetchGuestInformationHistory(int page, int limit, bool forUser) async {
    CommonService commonService = Get.find();
    print(GetStorage().read('token'));
    Uri uri = Helper.getUri('EntryQrController/fetch_entry_qr_data');

    Map<String, String> headers = {'Accept': 'application/json;', 'Content-Type': 'application/json;'};
    if (forUser) {
      headers['Authorization'] = "Bearer ${GetStorage().read('token') ?? ''}";
    }
    print({
      'page': page.toString(),
      'limit': limit.toString(),
    });
    var response = await get(
      uri.toString(),
      query: {'page': page.toString(), 'limit': limit.toString(), 'type': !forUser ? commonService.dateType.value : ''},
      headers: headers,
    );
    print(response.body);
    return response.body;
  }
}
