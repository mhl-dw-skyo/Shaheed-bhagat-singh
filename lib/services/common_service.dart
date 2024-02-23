import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../core.dart';

class CommonService extends GetxService {
  var dashboardData = DashboardModel().obs;
  var offlineCategoriesData = TrailModel().obs;
  var trailData = <TrailAttributes>[].obs;
  var offlineLocationDetailData = OfflineLocationsModel().obs;
  var locationDetailData = DetailModel().obs;
  var nearByData = NearByModel().obs;
  var beaconsData = BeaconModel().obs;
  var sameCategoryBeacons = <BeaconItem>[].obs;
  var selectedBeacon = BeaconItem().obs;
  var detectedBeacons = [].obs;
  var macAddresses = <String>[].obs;
  var uuid = <String>[].obs;
  var isAudioPlaying = false.obs;
  var soundFiles = [].obs;
  var assetsAudioPlayer = AssetsAudioPlayer().obs;
  var lastPlayedMacAddress = "".obs;
  var selectedCategoryName = "".obs;
  var selectedLocationId = 0.obs;
  var selectedLocationName = "".obs;
  var selectedAudioFile = "".obs;
  var selectedFileType = "".obs;
  var isPopSVPopupOpen = false.obs;
  var isBluetoothPermissionPopupOpened = false.obs;
  var ytpController = YoutubePlayerController().obs;
  var inMuseum = false.obs;
  var labelData = LabelModel().obs;
  var guestInformationData = GuestModel().obs;
  var guestData = GuestItem().obs;
  var qrStatus = 3.obs;
  var dateType = "T".obs;
}
