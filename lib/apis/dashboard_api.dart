import '../core.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardApi {
  Future submitComplaint(Map data) async {
    Uri uri = Helper.getUri('feedback/add_feedback');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );
    print(response.body);
    return jsonDecode(response.body);
  }
}
