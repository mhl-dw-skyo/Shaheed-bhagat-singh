import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core.dart';

class AuthApi {
  Future verifyMobileNo(String phone) async {
    Uri uri = Helper.getUri('login/login_missedcall');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'mobile_no': phone.toString(),
      }),
    );
    return jsonDecode(response.body);
  }

  Future sendOtpToEmail(String email) async {
    Uri uri = Helper.getUri('registration/verify_userinput');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'user_input': email,
      }),
    );
    return jsonDecode(response.body);
  }

  Future verifyOtp(String email, String otp) async {
    Uri uri = Helper.getUri('registration/verify_userinput_otp');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'user_input': email,
        'user_otp': otp,
      }),
    );
    return jsonDecode(response.body);
  }

  Future loginWithSocialMedia(Map data) async {
    Uri uri = Helper.getUri('registration/create_user_account');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print(uri);
    print(data);
    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(
        data,
      ),
    );
    print(response.body);
    return jsonDecode(response.body);
  }
}
