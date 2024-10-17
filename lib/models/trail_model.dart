import '../core.dart';

class TrailModel {
  List<TrailDataModel> data = [];
  TrailModel();
  TrailModel.fromJSON(Map<String, dynamic> json) {
    data = json["data"] != null ? parseData(json["data"]) : [];
  }

  static List<TrailDataModel> parseData(jsonData) {
    List list = jsonData;
    List<TrailDataModel> attrList = list.map((data) => TrailDataModel.fromJSON(data)).toList();
    return attrList;
  }
}

class TrailDataModel {
  int id = 0;
  String title = '';
  List<TrailAttributes> attributes = [];
  TrailDataModel();
  TrailDataModel.fromJSON(Map<String, dynamic> json) {
    id = json["category_type_id"] ?? '';
    title = json["category_type_name"] ?? '';
    attributes = json["attributes"] != null ? parseData(json["attributes"]) : [];
  }

  static List<TrailAttributes> parseData(jsonData) {
    List list = jsonData;
    List<TrailAttributes> attrList = list.map((data) => TrailAttributes.fromJSON(data)).toList();
    return attrList;
  }
}

class TrailAttributes {
  int id = 0;
  String title = '';
  String subtitle = '';
  int categoryTypeId = 0;
  String typeView = '';
  List<LocationListing> locationListing = [];
  TrailAttributes();
  TrailAttributes.fromJSON(Map<String, dynamic> json) {
    id = json["category_id"] ?? 0;
    title = json["category_name"] ?? '';
    subtitle = json["subtitle"] ?? 'Petal';
    categoryTypeId = json["category_type_id"] ?? 0;
    typeView = json["type_view"] ?? '';
    locationListing = json["location_listing"] != null ? parseData(json["location_listing"]) : [];
  }

  static List<LocationListing> parseData(jsonData) {
    List list = jsonData;
    List<LocationListing> attrList = list.map((data) => LocationListing.fromJSON(data)).toList();
    return attrList;
  }
}

class LocationListing {
  int id = 0;
  String title = '';
  String description = '';
  String imagePath = '';
  LocationListing();
  LocationListing.fromJSON(Map<String, dynamic> json) {
    id = json["location_id"] ?? 0;
    title = json["location_name"] ?? '';
    description = json["description"] ?? '';
    imagePath = json["image_path"] ?? '';
  }
}
