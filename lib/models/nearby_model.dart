import '../core.dart';

class NearByModel {
  List<NearByItem> data = [];
  NearByModel();
  NearByModel.fromJSON(Map<String, dynamic> json) {
    data = json["data"] != null ? parseData(json["data"]) : [];
  }

  static List<NearByItem> parseData(jsonData) {
    List list = jsonData;
    List<NearByItem> attrList = list.map((data) => NearByItem.fromJSON(data)).toList();
    return attrList;
  }
}

class NearByItem {
  String title = '';
  String image = '';
  String latitude = '0.0';
  String longitude = '0.0';
  String distance = '';
  NearByItem();
  NearByItem.fromJSON(Map<String, dynamic> json) {
    title = json["title"] ?? '';
    image = json["image_link"] ?? '';
    latitude = json["latitude"] ?? '0.0';
    longitude = json["longitude"] ?? '0.0';
    distance = json["distance"] ?? '';
  }
}
