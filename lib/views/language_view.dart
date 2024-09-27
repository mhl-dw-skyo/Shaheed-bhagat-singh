import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/bottom_nav_controller.dart';
import '../core.dart';

class LanguageView extends GetView {
  LanguageView({Key? key}) : super(key: key);
  late DateTime currentBackPressTime;
  CategoryTypeController categoryTypeController = Get.find();
  DetailController detailController = Get.find();
  NearByController nearByController = Get.find();
  DashboardController dashboardController = Get.find();
  GuestController guestController = Get.find();
  CommonService commonService = Get.find();
  BottomNavController controller= Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Get.theme.primaryColor,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: Get.theme.primaryColorDark,
      appBar: AppBar(
        bottomOpacity: 0,
        shadowColor: Colors.transparent,
        foregroundColor: Get.theme.indicatorColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading:
            (GetStorage().read('isBackToHomeLangPage') == '' ||
                    GetStorage().read('isBackToHomeLangPage') == null)
                ? false
                : true,
        centerTitle: false,
      ),
      body: WillPopScope(
        onWillPop: () {
          if (GetStorage().read('isBackToHomeLangPage') == '' ||
              GetStorage().read('isBackToHomeLangPage') == null) {
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime) >
                    const Duration(seconds: 2)) {
              currentBackPressTime = now;
              Fluttertoast.showToast(msg: "Tap again to exit an app.");
              return Future.value(false);
            }
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          } else {
            Get.back();
          }
          return Future.value(true);
        },
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login-bg.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              commonService.labelData.value.data.selectLanguage.text
                  .textStyle(
                    Get.textTheme.headline1!.copyWith(
                      color: Get.theme.indicatorColor,
                      fontSize: 35,
                    ),
                  )
                  .shadow(1, 1, 5, Get.theme.highlightColor)
                  .make()
                  .pOnly(bottom: 10),
              commonService.labelData.value.data.selectLangDesc.text
                  .textStyle(
                    Get.textTheme.bodyText1!.copyWith(
                      color: Get.theme.indicatorColor.withOpacity(0.5),
                      fontSize: 18,
                    ),
                  )
                  .center
                  .shadow(1, 1, 5, Get.theme.highlightColor)
                  .make()
                  .centered()
                  .pOnly(bottom: 25),
              InkWell(
                onTap: () async {
                  await GetStorage().write('language_id', 3);
                  dashboardController.fetchLabelData();
                  dashboardController.fetchDashboardData();
                  categoryTypeController.fetchTrailsData();
                  detailController.getOfflineLocationsData();
                  nearByController.getNearByData();
                  controller.updateIndex();
                  if (GetStorage().read('user_type') != "U") {
                    Get.toNamed('/emp_dashboard');
                    guestController.page = 1;
                    guestController.showLoadMore = true;
                    guestController.forUser.value = false;
                    guestController.forUser.refresh();
                    guestController.fetchGuestInformationHistory();
                  } else {
                    Get.toNamed('/dashboard');
                    await dashboardController.fetchBeaconData();
                    dashboardController.initBeaconService();
                  }
                },
                child: Container(
                  width: Get.width * 0.4,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                        colors: [
                          Get.theme.colorScheme.primary,
                          Get.theme.colorScheme.secondary,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: "ਪੰਜਾਬੀ"
                      .text
                      .textStyle(
                        Get.textTheme.headline3!.copyWith(
                          color: Get.theme.highlightColor,
                        ),
                      )
                      .make()
                      .centered(),
                ),
              ).pOnly(bottom: 30),
              InkWell(
                onTap: () async {
                  await GetStorage().write('language_id', 2);
                  dashboardController.fetchLabelData();
                  dashboardController.fetchDashboardData();
                  categoryTypeController.fetchTrailsData();
                  detailController.getOfflineLocationsData();
                  nearByController.getNearByData();
                  controller.updateIndex();

                  if (GetStorage().read('user_type') != "U") {
                    Get.toNamed('/emp_dashboard');
                    guestController.page = 1;
                    guestController.showLoadMore = true;
                    guestController.forUser.value = false;
                    guestController.forUser.refresh();
                    guestController.fetchGuestInformationHistory();
                  } else {
                    Get.toNamed('/dashboard');
                    await dashboardController.fetchBeaconData();
                    dashboardController.initBeaconService();
                  }
                },
                child: Container(
                  width: Get.width * 0.4,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                        colors: [
                          Get.theme.colorScheme.primary,
                          Get.theme.colorScheme.secondary,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: "हिन्दी"
                      .text
                      .textStyle(
                        Get.textTheme.headline3!.copyWith(
                          color: Get.theme.highlightColor,
                        ),
                      )
                      .make()
                      .centered(),
                ),
              ).pOnly(bottom: 30),
              InkWell(
                onTap: () async {
                  await GetStorage().write('language_id', 1);
                  dashboardController.fetchLabelData();
                  dashboardController.fetchDashboardData();
                  categoryTypeController.fetchTrailsData();
                  detailController.getOfflineLocationsData();
                  nearByController.getNearByData();
                  controller.updateIndex();

                  if (GetStorage().read('user_type') != "U") {
                    Get.toNamed('/emp_dashboard');
                    guestController.page = 1;
                    guestController.showLoadMore = true;
                    guestController.forUser.value = false;
                    guestController.forUser.refresh();
                    guestController.fetchGuestInformationHistory();
                  } else {
                    Get.toNamed('/dashboard');
                    await dashboardController.fetchBeaconData();
                    dashboardController.initBeaconService();
                  }
                },
                child: Container(
                  width: Get.width * 0.4,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                        colors: [
                          Get.theme.colorScheme.primary,
                          Get.theme.colorScheme.secondary,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: "English"
                      .text
                      .textStyle(
                        Get.textTheme.headline3!.copyWith(
                          color: Get.theme.highlightColor,
                        ),
                      )
                      .make()
                      .centered(),
                ),
              ),
            ],
          ).pSymmetric(h: 30),
        ),
      ),
    );
  }
}
