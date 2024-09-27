import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
// import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core.dart';

class EmpDashboardView extends GetView<GuestController> {
  EmpDashboardView({Key? key}) : super(key: key);
  late DateTime currentBackPressTime;
  GlobalKey<ScaffoldState> scaffoldDashboardKey =
      GlobalKey<ScaffoldState>(debugLabel: '_scaffoldDashboardKey');
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Get.theme.primaryColor,
          statusBarIconBrightness: Brightness.dark),
    );
    return UpgradeAlert(
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      upgrader: Upgrader(),
      child: Container(
        color: Get.theme.primaryColor,
        child: SafeArea(
          child: Scaffold(
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
                    Get.textTheme.headline1!.copyWith(
                      color: Get.theme.indicatorColor,
                    ),
                  )
                  .make(),
              actions: [
                InkWell(
                  onTap: () {
                    scaffoldDashboardKey.currentState?.openEndDrawer();
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
                onRefresh: () {
                  controller.page = 1;
                  controller.showLoadMore = true;
                  controller.forUser.value = false;
                  controller.forUser.refresh();
                  controller.fetchGuestInformationHistory();
                  return Future.value(true);
                },
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonService
                                      .labelData.value.data.today.text.center
                                      .textStyle(
                                        Get.textTheme.headline3!.copyWith(
                                          color: commonService.dateType.value ==
                                                  "T"
                                              ? Get.theme.colorScheme.primary
                                              : Get.theme.indicatorColor,
                                          fontWeight:
                                              commonService.dateType.value ==
                                                      "T"
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                        ),
                                      )
                                      .make()
                                      .pOnly(right: 20)
                                      .onTap(() {
                                    commonService.dateType.value = 'T';
                                    commonService.dateType.refresh();
                                    controller.page = 1;
                                    controller.showLoadMore = true;
                                    controller.forUser.value = false;
                                    controller.forUser.refresh();
                                    controller.fetchGuestInformationHistory();
                                  }),
                                  commonService
                                      .labelData.value.data.weekly.text.center
                                      .textStyle(
                                        Get.textTheme.headline3!.copyWith(
                                          color: commonService.dateType.value ==
                                                  "W"
                                              ? Get.theme.colorScheme.primary
                                              : Get.theme.indicatorColor,
                                          fontWeight:
                                              commonService.dateType.value ==
                                                      "W"
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                        ),
                                      )
                                      .make()
                                      .pOnly(right: 20)
                                      .onTap(() {
                                    commonService.dateType.value = 'W';
                                    commonService.dateType.refresh();
                                    controller.page = 1;
                                    controller.showLoadMore = true;
                                    controller.forUser.value = false;
                                    controller.forUser.refresh();
                                    controller.fetchGuestInformationHistory();
                                  }),
                                  commonService
                                      .labelData.value.data.monthly.text.center
                                      .textStyle(
                                        Get.textTheme.headline3!.copyWith(
                                          color: commonService.dateType.value ==
                                                  "M"
                                              ? Get.theme.colorScheme.primary
                                              : Get.theme.indicatorColor,
                                          fontWeight:
                                              commonService.dateType.value ==
                                                      "M"
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                        ),
                                      )
                                      .make()
                                      .onTap(() {
                                    commonService.dateType.value = 'M';
                                    commonService.dateType.refresh();
                                    controller.page = 1;
                                    controller.showLoadMore = true;
                                    controller.forUser.value = false;
                                    controller.forUser.refresh();
                                    controller.fetchGuestInformationHistory();
                                  })
                                ],
                              ),
                            ),
                            // SizedBox(width: 20,),
                            InkWell(
                              onTap: () async {
                                String barcodeScanRes =
                                    await FlutterBarcodeScanner.scanBarcode(
                                        '#ff6666',
                                        'Cancel',
                                        true,
                                        ScanMode.BARCODE);
                                if (barcodeScanRes.isNotEmpty) {
                                  controller.scanQR(barcodeScanRes);
                                }
                              },
                              child: SvgPicture.asset(
                                "assets/images/scan.svg",
                                color: Get.theme.colorScheme.primary,
                                width: 25,
                              ),
                            ).objectCenterRight(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  commonService
                                      .labelData.value.data.totalGuests.text
                                      .textStyle(
                                        Get.textTheme.headline2!.copyWith(
                                          color: Get.theme.highlightColor,
                                        ),
                                      )
                                      .make(),
                                  SvgPicture.asset(
                                    "assets/images/gender.svg",
                                    color: Get.theme.highlightColor,
                                    width: 60,
                                  ),
                                ],
                              ).pSymmetric(h: 20, v: 15),
                              commonService
                                  .guestInformationData.value.totalGuests.text
                                  .textStyle(
                                    Get.textTheme.headline1!.copyWith(
                                      color: Get.theme.highlightColor,
                                      fontSize: 40,
                                    ),
                                  )
                                  .make()
                                  .pOnly(left: 22),
                            ],
                          ),
                        ).pOnly(bottom: 20),
                        commonService.guestInformationData.value.data.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  commonService.labelData.value.data
                                      .guestsEntered.text.center
                                      .textStyle(
                                        Get.textTheme.headline4!.copyWith(
                                          color: Get.theme.indicatorColor,
                                        ),
                                      )
                                      .make(),
                                  commonService.labelData.value.data.viewAll
                                      .text.underline.center
                                      .textStyle(
                                        Get.textTheme.headline5!.copyWith(
                                          color: Get.theme.colorScheme.primary,
                                        ),
                                      )
                                      .make()
                                      .onTap(() {
                                    if (commonService.guestInformationData.value
                                        .data.isNotEmpty) {
                                      controller.scrollController.value
                                          .removeListener(
                                              controller.guestScrollListener);
                                    }
                                    controller.page = 1;
                                    controller.forUser.value = false;
                                    controller.forUser.refresh();
                                    controller.fetchGuestInformationHistory();
                                    Get.toNamed('/guest-information-history');
                                  })
                                ],
                              ).pOnly(bottom: 10)
                            : SizedBox(),
                        if (commonService
                            .guestInformationData.value.data.isNotEmpty)
                          ...commonService.guestInformationData.value.data
                              .take(5)
                              .mapIndexed((currentValue, index) {
                            return SizedBox(
                              width: Get.width,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Get.theme.highlightColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Get.theme.indicatorColor
                                          .withOpacity(0.5),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            commonService.labelData.value.data
                                                .name.text.center
                                                .textStyle(
                                                  Get.textTheme.headline4!
                                                      .copyWith(
                                                    color: Get.theme.colorScheme
                                                        .primary,
                                                  ),
                                                )
                                                .make()
                                                .pOnly(right: 15),
                                            ":"
                                                .text
                                                .center
                                                .textStyle(
                                                  Get.textTheme.headline4!
                                                      .copyWith(
                                                    color: Get.theme.colorScheme
                                                        .primary,
                                                  ),
                                                )
                                                .make()
                                                .pOnly(right: 15),
                                            currentValue.name.text.center
                                                .textStyle(
                                                  Get.textTheme.bodyMedium!
                                                      .copyWith(
                                                    color: Get
                                                        .theme.indicatorColor,
                                                  ),
                                                )
                                                .make(),
                                          ],
                                        ).pOnly(bottom: 10),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            commonService.labelData.value.data
                                                .guests.text.center
                                                .textStyle(
                                                  Get.textTheme.headline4!
                                                      .copyWith(
                                                    color: Get.theme.colorScheme
                                                        .primary,
                                                  ),
                                                )
                                                .make()
                                                .pOnly(right: 15),
                                            ":"
                                                .text
                                                .center
                                                .textStyle(
                                                  Get.textTheme.headline4!
                                                      .copyWith(
                                                    color: Get.theme.colorScheme
                                                        .primary,
                                                  ),
                                                )
                                                .make()
                                                .pOnly(right: 15),
                                            currentValue.guests.text.center
                                                .textStyle(
                                                  Get.textTheme.bodyMedium!
                                                      .copyWith(
                                                    color: Get
                                                        .theme.indicatorColor,
                                                  ),
                                                )
                                                .make(),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child:
                                          "${currentValue.date}  ${currentValue.time}"
                                              .text
                                              .center
                                              .textStyle(
                                                Get.textTheme.bodyMedium!
                                                    .copyWith(
                                                  color:
                                                      Get.theme.indicatorColor,
                                                ),
                                              )
                                              .make(),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(
                                        currentValue.isScanned == 1
                                            ? Icons.check_circle
                                            : Icons.timelapse,
                                        color: currentValue.isScanned == 1
                                            ? Colors.green
                                            : Colors.pink,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ).pSymmetric(h: 15, v: 15),
                              ),
                            ).pOnly(bottom: 15);
                          }).toList(),
                      ],
                    ).pOnly(bottom: 60, left: 20, right: 20),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavWidget(
              onTap: (int index) async {
                Helper.onBottomBarClick(controller, index);
              },
            ),
            floatingActionButton: SpeedDialWidget(),
          ),
        ),
      ),
    );
  }
}
