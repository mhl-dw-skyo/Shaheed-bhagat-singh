import '../core.dart';

class DashboardModel {
  List<DashboardDataModel> data = [];
  DashboardModel();
  DashboardModel.fromJSON(Map<String, dynamic> json) {
    data = json["data"] != null ? parseData(json["data"]) : [];
  }
  static List<DashboardDataModel> parseData(jsonData) {
    List list = jsonData;
    List<DashboardDataModel> attrList = list.map((data) => DashboardDataModel.fromJSON(data)).toList();
    return attrList;
  }
}

class DashboardDataModel {
  String moduleName = '';
  String moduleAlias = '';
  int layout = 0;
  int languageId = 0;
  String mType = '';
  List<Attributes> attributes = [];
  DashboardDataModel();
  DashboardDataModel.fromJSON(Map<String, dynamic> json) {
    moduleName = json["module_name"] ?? '';
    moduleAlias = json["module_alias"] ?? '';
    layout = json["module_layout"] ?? 0;
    languageId = json["language_id"] ?? 0;
    mType = json["mtype"] ?? '';
    attributes = json["attributes"] != null ? parseData(json["attributes"]) : [];
  }

  static List<Attributes> parseData(jsonData) {
    List list = jsonData;
    List<Attributes> attrList = list.map((data) => Attributes.fromJSON(data)).toList();
    return attrList;
  }
}

class Attributes {
  int id = 0;
  int locationId = 0;
  String title = '';
  String imagePath = '';
  String description = '';
  int rank = 0;
  String type = '';
  String link = '';
  List<Attributes> attributeTypes = [];
  Attributes();
  Attributes.fromJSON(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    locationId = json["location_id"] ?? 0;
    title = json["title"] ?? '';
    imagePath = json["image_path"] ?? json["image_link"] ?? json["video_thumb"] ?? '';
    description = json["description"] ?? '';
    rank = json["rank"] ?? 0;
    type = json["type"] ?? '';
    link = json["video_link"] ?? '';
    attributeTypes = json["att_type"] != null ? parseData(json["att_type"]) : [];
  }

  static List<Attributes> parseData(jsonData) {
    List list = jsonData;
    List<Attributes> attrList = list.map((data) => Attributes.fromJSON(data)).toList();
    return attrList;
  }
}
