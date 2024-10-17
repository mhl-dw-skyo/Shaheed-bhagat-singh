class ConfigModel {
  List<MainMenuItems> mainMenuData = [];
  List<MainMenuItems> fontData = [];
  List<MainMenuItems> settingData = [];
  String eulaContent = "";
  String primaryColorLight = "";
  String primaryColorDark = "";
  String highlightColorLight = "";
  String highlightColorDark = "";
  String btnColorLight = "";
  String btnColorDark = "";
  String btnTextColorLight = "";
  String btnTextColorDark = "";
  String textColorLight = "";
  String textColorDark = "";
  String logo = "";
  ConfigModel();
  ConfigModel.fromJSON(Map<String, dynamic> json) {
    mainMenuData = json["main_menu"] != null ? parseMenuData(json["main_menu"]) : [];
    fontData = json["font_data"] != null ? parseMenuData(json["font_data"]) : [];
    settingData = json["app_setting"] != null ? parseMenuData(json["app_setting"]) : [];
    eulaContent = json["eula"] ?? '';
    primaryColorLight = json["primary_color_light"] ?? '#ffffff';
    primaryColorDark = json["primary_color_dark"] ?? '#000000';
    highlightColorLight = json["highlight_color_light"] ?? '#46C4B0';
    highlightColorDark = json["highlight_color_dark"] ?? '#46C4B0';
    btnColorLight = json["btn_color_light"] ?? '#46C4B0';
    btnColorDark = json["btn_color_dark"] ?? '#46C4B0';
    btnTextColorLight = json["btn_text_color_light"] ?? '#ffffff';
    btnTextColorDark = json["btn_text_color_dark"] ?? '#ffffff';
    textColorLight = json["text_color_light"] ?? '#000000';
    textColorDark = json["text_color_dark"] ?? '#ffffff';
    logo = json["logo"] ?? '';
  }

  static List<MainMenuItems> parseMenuData(jsonData) {
    List list = jsonData;
    List<MainMenuItems> attrList = list.map((data) => MainMenuItems.fromJSON(data)).toList();
    return attrList;
  }
}

class MainMenuItems {
  int id = 0;
  int languageId = 0;
  String title = '';
  String alias = '';
  MainMenuItems();
  MainMenuItems.fromJSON(Map<String, dynamic> json) {
    id = json["menu_id"] ?? 0;
    languageId = json["language_id"] ?? 0;
    title = json["title"] ?? '';
    alias = json["alias"] ?? '';
  }
}
