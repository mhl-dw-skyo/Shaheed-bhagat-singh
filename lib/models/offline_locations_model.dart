import '../core.dart';

class OfflineLocationsModel {
  List<OfflineLocationsItem> data = [];

  OfflineLocationsModel();

  OfflineLocationsModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] != null ? parseData(json["data"]) : [];
  }

  static List<OfflineLocationsItem> parseData(attributesJson) {
    List list = attributesJson;
    List<OfflineLocationsItem> attrList = list.map((data) => OfflineLocationsItem.fromJson(data)).toList();
    return attrList;
  }

  static List<DetailAttributes> parseAttributes(attributesJson) {
    List list = attributesJson;
    List<DetailAttributes> attrList = list.map((data) => DetailAttributes.fromJson(data)).toList();
    return attrList;
  }
}

class OfflineLocationsItem {
  int locationId = 0;
  String locationName = '';
  List serialNo = [];
  DetailModel locationDetail = DetailModel();

  OfflineLocationsItem();

  OfflineLocationsItem.fromJson(Map<String, dynamic> json) {
    locationId = json["location_id"] ?? 0;
    locationName = json["location_name"] ?? '';
    serialNo = json["serial_no"] == null || json["serial_no"] == '' ? [] : json["serial_no"];
    locationDetail = (json["location_detail"] != null && json["location_detail"] != "") ? DetailModel.fromJson(json["location_detail"]) : DetailModel();
  }

  static List<DetailModel> parseDetailModel(attributesJson) {
    List list = attributesJson;
    List<DetailModel> attrList = list.map((data) => DetailModel.fromJson(data)).toList();
    return attrList;
  }
}
