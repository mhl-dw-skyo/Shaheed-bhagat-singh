import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key key}) : super(key: key);
  DateTime currentBackPressTime;
  GlobalKey<ScaffoldState> scaffoldDashboardKey =
      GlobalKey<ScaffoldState>(debugLabel: '_scaffoldDashboardKey');
  CommonService commonService = Get.find();
  GuestController guestController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.startWelcomeSound();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Get.theme.primaryColor,
          statusBarIconBrightness: Brightness.dark),
    );
    return UpgradeAlert(
      upgrader: Platform.isIOS
          ? Upgrader(dialogStyle: UpgradeDialogStyle.cupertino)
          : Upgrader(dialogStyle: UpgradeDialogStyle.material),
      child: Container(
        color: Get.theme.primaryColor,
        child: SafeArea(
          child: Obx(
            () => Scaffold(
              key: scaffoldDashboardKey,
              backgroundColor: Get.theme.primaryColor,
              appBar: AppBar(
                bottomOpacity: 0,
                shadowColor: Colors.transparent,
                backgroundColor: Get.theme.primaryColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: commonService.labelData.value.data.punjabTourism.text
                    .textStyle(
                      Get.textTheme.headline1.copyWith(
                        color: Get.theme.indicatorColor,
                      ),
                    )
                    .make(),
                actions: [
                  InkWell(
                    onTap: () {
                      scaffoldDashboardKey.currentState.openEndDrawer();
                    },
                    child: SvgPicture.asset(
                      "assets/images/menu.svg",
                      color: Get.theme.indicatorColor,
                    ),
                  ).pOnly(right: 20)
                ],
              ),
              endDrawer: DrawerWidget(),
              body: WillPopScope(
                onWillPop: () {
                  DateTime now = DateTime.now();
                  if (currentBackPressTime == null ||
                      now.difference(currentBackPressTime) >
                          const Duration(seconds: 2)) {
                    currentBackPressTime = now;
                    Fluttertoast.showToast(msg: "Tap again to exit an app.");
                    return Future.value(false);
                  }
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  return Future.value(true);
                },
                child: RefreshIndicator(
                  onRefresh: () => controller.fetchDashboardData(),
                  child: Obx(
                    () => SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonService.labelData.value.data.welcomeTo.text
                                  .textStyle(
                                    Get.textTheme.headline1.copyWith(
                                      color: Get.theme.indicatorColor
                                          .withOpacity(0.5),
                                    ),
                                  )
                                  .make(),
                              const SizedBox(
                                width: 40,
                                height: 40,
                              ),
                              InkWell(
                                onTap: () async {
                                  GuestController guestController = Get.find();
                                  guestController.page = 1;
                                  await guestController
                                      .fetchGuestInformationHistory();
                                  Get.toNamed('/guest-information');
                                },
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                                  child: Row(
                                    children: [
                                      commonService
                                          .labelData.value.data.entryAccess.text
                                          .textStyle(
                                            Get.textTheme.headline4.copyWith(
                                              color: Get.theme.highlightColor,
                                            ),
                                          )
                                          .make()
                                          .pOnly(right: 2),
                                      SvgPicture.asset(
                                        "assets/images/entry.svg",
                                        color: Get.theme.highlightColor,
                                        width: 22,
                                      )
                                    ],
                                  ).pSymmetric(h: 10),
                                ),
                              ),
                            ],
                          ).pSymmetric(h: 20),
                          Transform.translate(
                            offset: Offset(0, -10),
                            child: commonService
                                .labelData.value.data.virastEKhalsa.text
                                .textStyle(
                                  Get.textTheme.headline1.copyWith(
                                    color: Get.theme.indicatorColor,
                                    fontSize: 35,
                                  ),
                                )
                                .make()
                                .pSymmetric(h: 20),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ...commonService.dashboardData.value.data
                              .mapIndexed((currentValue, index) {
                            return currentValue.mType == "markup"
                                ? DashboardSliderWidget(
                                        attributes: currentValue.attributes)
                                    .pOnly(bottom: 30)
                                : DashboardCategoriesWidget(
                                    dashboardDataModel: currentValue,
                                  );
                          }).toList(),
                        ],
                      ).pOnly(bottom: 35),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavWidget(
                onTap: (int index) {
                  Helper.onBottomBarClick(null, index);
                },
              ),
              floatingActionButton: SpeedDialWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
