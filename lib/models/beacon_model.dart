import '../core.dart';

class BeaconModel {
  List<BeaconItem> data = [];
  BeaconModel();
  BeaconModel.fromJSON(Map<String, dynamic> json) {
    data = json["data"] != null ? parseData(json["data"]) : [];
  }

  static List<BeaconItem> parseData(jsonData) {
    List list = jsonData;
    List<BeaconItem> attrList = list.map((data) => BeaconItem.fromJSON(data)).toList();
    return attrList;
  }
}

class BeaconItem {
  int id = 0;
  String name = '';
  String macAddress = '';
  String uuid = '';
  int startRange = 0;
  int endRange = 0;
  int locationId = 0;
  String soundFile = '';
  String locationName = '';
  String locationImage = '';
  String action = '';
  int type = 0;
  BeaconItem();
  BeaconItem.fromJSON(Map<String, dynamic> json) {
    id = json["beacon_id"] ?? 0;
    name = json["beacon_name"] ?? '';
    macAddress = json["mac_address"] ?? '';
    uuid = json["uuid"] ?? '';
    startRange = json["start_range"] ?? 0;
    endRange = json["end_range"] ?? 0;
    soundFile = json["soundfile"] ?? '';
    locationId = json["location_id"] ?? 0;
    locationName = json["location_name"] ?? '';
    locationImage = json["location_image"] ?? '';
    action = json["beacon_actions"] ?? '';
    type = json["beacon_type"] ?? 0;
  }
}
