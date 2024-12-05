import 'package:flutter/material.dart';

import '../core.dart';

class LocationModel {
  int id = 0;
  String title = '';
  String shortDescription = '';
  String description = '';
  String image = '';
  LocationModel({this.id = 0, this.title = "", this.shortDescription = "", this.description = "", this.image = ""});
  LocationModel.fromJSON(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    title = json["title"] ?? '';
    shortDescription = json["short_description"] ?? '';
    description = json["description"] ?? '';
    image = json["image"] ?? '';
  }
}
