import '../core.dart';

class DetailModel {
  String moduleName = "";
  String moduleAlias = "";
  String moduleVisibility = "";
  int languageId = 0;
  int moduleType = 0;
  int moduleLayout = 0;
  int moduleLayoutId = 0;
  int noOfRecords = 0;
  int isLatest = 0;
  int moduleCategoryId = 0;
  DetailAttributes attributes = DetailAttributes();

  DetailModel();

  DetailModel.fromJson(Map<String, dynamic> json) {
    moduleName = json["module_name"] ?? '';
    moduleAlias = json["module_alias"] ?? '';
    moduleVisibility = json["module_visibility"] ?? '';
    languageId = json["language_id"] ?? 0;
    moduleType = json["module_type"] ?? 0;
    moduleLayout = json["module_layout"] ?? 0;
    moduleLayoutId = json["module_layout_id"] ?? 0;
    noOfRecords = json["no_of_records"] ?? 0;
    isLatest = json["is_latest"] ?? 0;
    moduleCategoryId = json["module_category_id"] ?? 0;
    attributes = (json["attributes"] != null && json["attributes"] != "") ? DetailAttributes.fromJson(json["attributes"]) : DetailAttributes();
  }

  static List<DetailAttributes> parseAttributes(attributesJson) {
    List list = attributesJson;
    List<DetailAttributes> attrList = list.map((data) => DetailAttributes.fromJson(data)).toList();
    return attrList;
  }
}

class DetailAttributes {
  String title = "";
  int id = 0;
  String type = "";
  int locationId = 0;
  String locationName = "";
  String description = "";
  List<Description> content = [];
  List<BeaconListing> baconListing = [];
  String shortDescription = "";
  String latitude = "";
  String longitude = "";
  String wLatitude = "";
  String wLongitude = "";
  String mapIcon = "";
  String imagePath = "";
  String city = "";
  String state = "";
  String country = "";
  String iconPath = "";
  String icon = "";
  String distance = "";
  String facing = "";
  String facingTitle = "";
  String area = "";
  String rulesRegulations = "";
  String ratingScore = "";
  String ratingTitle = "";
  String ratingDescription = "";
  String reviewAddText = "";
  String photoApiUrl = "";
  String vrApiUrl = "";
  String videoApiUrl = "";
  String video360ApiUrl = "";
  String categoryName = "";
  int categoryId = 0;
  String address = "";
  bool isFav = false;
  bool isVisited = false;
  String voiceTest = '';
  String facilityType = "";
  String wifiAvailability = "";
  String wifiAvailText = "";
  String visitedText = "";
  String gameImage = "";
  String audio = "";
  bool isAudioAutoPlay = false;
  List<WorkingHours> workingHour = [];
  List<Audios> shortAudios = [];
  List<Audios> longAudios = [];
  List<RefLinks> refLinks = [];
  bool isPhotosContentAvailable = false;
  bool isVideosContentAvailable = false;
  bool isVRContentAvailable = false;
  bool is360ContentAvailable = false;
  bool isGameAvailable = false;
  bool isQuizAvailable = false;
  String typeData = "";
  String listViewIcon = "";
  List serialNo = [];

  DetailAttributes();

  DetailAttributes.fromJson(Map<String, dynamic> json) {
    title = json["title"] ?? '';
    id = json["id"] ?? 0;
    type = json["type"] ?? '';
    locationId = json["location_id"] ?? 0;
    isAudioAutoPlay = json["is_audio_auto_play"] == 0 || json["is_audio_auto_play"] == null ? false : true;
    locationName = json["location_name"] ?? '';
    description = json["description2"] ?? '';
    content = json["description"] != null ? parseDescription(json["description"]) : [];
    baconListing = json["beacon_listing"] != null ? parseBeaconsList(json["beacon_listing"]) : [];
    shortDescription = json["short_description"] ?? '';
    latitude = json["latitude"] ?? '';
    longitude = json["longitude"] ?? '';
    wLatitude = json["wlatitude"] ?? '';
    wLongitude = json["wlongitude"] ?? '';
    mapIcon = json["map_icon"] ?? '';
    imagePath = json["image_path"];
    city = json["city_name"] ?? '';
    state = json["state_name"] ?? '';
    country = json["country_name"] ?? '';
    iconPath = json["icon_path"] ?? '';
    distance = json["distance"] ?? '';
    facing = json["facing"] ?? '';
    facingTitle = json["facing_title"] ?? '';
    area = json["area_name"] ?? '';
    rulesRegulations = json["rules_regulations"] ?? '';
    ratingScore = json["rating_score"] ?? '';
    ratingTitle = json["rating_title"] ?? '';
    ratingDescription = json["rating_desciption"] ?? '';
    reviewAddText = json["review_add_text"] ?? '';
    photoApiUrl = json["photo_api_url"] ?? '';
    vrApiUrl = json["vr_api_url"] ?? '';
    videoApiUrl = json["video_api_url"] ?? '';
    video360ApiUrl = json["video360_api_url"];
    icon = json["icon"] ?? '';
    categoryName = json["category_name"] ?? '';
    categoryId = json["category_id"] ?? 0;
    address = json["address"] ?? '';
    isFav = json["is_favorite"] == null || json["is_favorite"] == 0 ? false : true;
    isVisited = json["is_visited"] == null || json["is_visited"] == 0 ? false : true;
    voiceTest = json["voice_test"] ?? '';
    facilityType = json["facility_type"] ?? '';
    wifiAvailability = json["wifi_availability"] ?? '';
    wifiAvailText = json["wifi_avail_text"] ?? '';
    visitedText = json["visited_text"] ?? '';
    gameImage = json["game_image"] ?? "";
    typeData = json["type_data"] ?? "";
    listViewIcon = json["list_view"] ?? "";
    serialNo = json["serial_no"] == null || json["serial_no"] == '' ? [] : json["serial_no"];
    isPhotosContentAvailable = json["is_photo_content_avail"] == null || json["is_photo_content_avail"] == 0 ? false : true;
    isVRContentAvailable = json["is_vr_content_avail"] == null || json["is_vr_content_avail"] == 0 ? false : true;
    isVideosContentAvailable = json["is_video_content_avail"] == null || json["is_video_content_avail"] == 0 ? false : true;
    is360ContentAvailable = json["is_360_content_avail"] == null || json["is_360_content_avail"] == 0 ? false : true;
    isGameAvailable = json["is_game_avail"] == null || json["is_game_avail"] == 0 ? false : true;
    isQuizAvailable = json["is_quiz_avail"] == null || json["is_quiz_avail"] == 0 ? false : true;
    shortAudios = json["short_audio"] != null ? parseAudios(json["short_audio"]) : [];
    longAudios = json["long_audio"] != null ? parseAudios(json["long_audio"]) : [];
    refLinks = json["reference_links"] != null ? parseRefLinks(json["reference_links"]) : [];
    workingHour = json["working_hours"] != null ? parseWorkingHours(json["working_hours"]) : [];
  }

  static List<BeaconListing> parseBeaconsList(jsonData) {
    List _list = jsonData;
    List<BeaconListing> _data = _list.map((data) => BeaconListing.fromJson(data)).toList();
    return _data;
  }

  static List<WorkingHours> parseWorkingHours(jsonData) {
    if (jsonData != null) {
      List _list = jsonData;
      List<WorkingHours> _workHrsList = _list.map((data) => WorkingHours.fromJson(data)).toList();
      return _workHrsList;
    } else {
      return [];
    }
  }

  static List<Description> parseDescription(jsonData) {
    List _list = jsonData;
    List<Description> _data = _list.map((data) => Description.fromJson(data)).toList();
    return _data;
  }

  static List<Audios> parseAudios(jsonData) {
    List _list = jsonData;
    List<Audios> _data = _list.map((data) => Audios.fromJson(data)).toList();
    return _data;
  }

  static List<RefLinks> parseRefLinks(jsonData) {
    List _list = jsonData;
    List<RefLinks> _data = _list.map((data) => RefLinks.fromJson(data)).toList();
    return _data;
  }
}

class BeaconListing {
  int id = 0;
  int isPrimary = 0;
  String englishSoundFile = '';
  String hindiSoundFile = '';
  String punjabiSoundFile = '';
  String fileType = '';

  BeaconListing();

  BeaconListing.fromJson(Map<String, dynamic> json) {
    id = json["beacon_id"] == null || json["beacon_id"] == '' ? 0 : int.parse(json["beacon_id"]);
    isPrimary = json["is_primary"] ?? 0;
    englishSoundFile = json["english_sound_file"] ?? '';
    hindiSoundFile = json["hindi_sound_file"] ?? '';
    punjabiSoundFile = json["punjabi_sound_file"] ?? '';
    fileType = json["sound_type"] ?? '';
  }
}

class WorkingHours {
  String weekDays = '';
  String availability = '';
  String startTime = '';
  String closeTime = '';

  WorkingHours();

  WorkingHours.fromJson(Map<String, dynamic> json) {
    weekDays = json["week_days"] ?? '';
    availability = json["availability"] ?? '';
    startTime = json["starttime"] ?? '';
    closeTime = json["closetime"] ?? '';
  }
}

class Description {
  int languageId = 0;
  String languageName = "";
  String description = "";

  Description();

  Description.fromJson(Map<String, dynamic> json) {
    languageId = json["language_id"] ?? 0;
    languageName = json["language_name"] ?? '';
    description = json["description"] ?? '';
  }
}

class Audios {
  int languageId = 0;
  String languageName = "";
  String description = "";
  String audio = "";
  String serialNo = "";

  Audios();

  Audios.fromJson(Map<String, dynamic> json) {
    languageId = json["language_id"] ?? 0;
    languageName = json["language_name"] ?? '';
    description = json["description"] ?? '';
    audio = json["audio_file_name"] ?? '';
    serialNo = json["serial_no"] ?? '';
  }
}

class RefLinks {
  String title = "";
  String link = "";

  RefLinks();

  RefLinks.fromJson(Map<String, dynamic> json) {
    title = json["ref_title"] ?? '';
    link = json["ref_link"] ?? '';
  }
}
