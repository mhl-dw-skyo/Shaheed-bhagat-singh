import 'dart:async';
import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../core.dart';
import 'package:http/http.dart' as http;

class CategoryTypeController extends GetxController with GetTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionsListener;
  CommonService commonService = Get.find();
  var buttonLoader = false.obs;
  var loader = false.obs;
  var firstVisibleItemIndex = 0.obs;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  final List<StreamSubscription> audioSubscriptions = [];
  TabController tabController;
  var isBufferingStream = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
  }

  Future<void> initService() async {
    tabController = TabController(length: commonService.trailData.isNotEmpty ? commonService.trailData.length : 0, vsync: this);
    itemPositionsListener.itemPositions.addListener(() async {
      if (itemPositionsListener.itemPositions.value.isNotEmpty) {
        firstVisibleItemIndex.value =
            itemPositionsListener.itemPositions.value.where((ItemPosition position) => position.itemTrailingEdge > 0).reduce((ItemPosition min, ItemPosition position) => position.itemTrailingEdge < min.itemTrailingEdge ? position : min).index;
      }
    });
  }

  Future<void> fetchTrailsData() async {
    String file = "";
    switch (GetStorage().read('language_id')) {
      case 1:
        file = "category_trails.json";
        break;
      case 2:
        file = "category_trails_hi.json";
        break;
      case 3:
        file = "category_trails_pu.json";
        break;
    }
    try {
      final String data = await rootBundle.loadString('assets/data_files/$file');
      var response = jsonDecode(data);
      if (response['status']) {
        commonService.offlineCategoriesData.value = TrailModel.fromJSON(response);
        commonService.offlineCategoriesData.refresh();
        // initService();
        // print(response['data']);
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}
