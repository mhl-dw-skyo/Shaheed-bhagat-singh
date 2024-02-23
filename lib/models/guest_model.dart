class GuestModel {
  int total = 0;
  int totalGuests = 0;
  List<GuestItem> data = [];
  GuestModel();
  GuestModel.fromJSON(Map<String, dynamic> json) {
    total = json["total_records"] ?? 0;
    totalGuests = json["total_guests"] ?? 0;
    data = json["data"] != null ? parseData(json["data"]) : [];
  }

  static List<GuestItem> parseData(jsonData) {
    List list = jsonData;
    List<GuestItem> attrList = list.map((data) => GuestItem.fromJSON(data)).toList();
    return attrList;
  }
}

class GuestItem {
  int id = 0;
  int guests = 0;
  int iScanned = 0;
  String name = '';
  String qrUrl = '';
  String date = '';
  String time = '';
  int isScanned = 0;
  GuestItem();
  GuestItem.fromJSON(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    guests = json["guests"] ?? 0;
    iScanned = json["is_scanned"] ?? 0;
    name = json["name"] ?? '';
    qrUrl = json["qr_url"] ?? '';
    date = json["date"] ?? '';
    time = json["time"] ?? '';
    isScanned = json["is_scanned"] ?? 0;
  }
}
