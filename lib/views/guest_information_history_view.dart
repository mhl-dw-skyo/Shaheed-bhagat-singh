import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:punjab_tourism/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core.dart';

class GuestInformationHistoryView extends GetView<GuestController> {
  GuestInformationHistoryView({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldDashboardKey =
      GlobalKey<ScaffoldState>(debugLabel: '_scaffoldDashboardKey');
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    return Container(
      color: Get.theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          key: scaffoldDashboardKey,
          backgroundColor: Get.theme.primaryColor,
          appBar: AppBar(
            bottomOpacity: 0,
            shadowColor: Colors.transparent,
            foregroundColor: Get.theme.indicatorColor,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                controller.page = 1;
                controller.showLoadMore = true;
                controller.fetchGuestInformationHistory();
                if (commonService.guestInformationData.value.data.isNotEmpty) {
                  controller.scrollController.value
                      .removeListener(controller.guestScrollListener);
                }
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Get.theme.indicatorColor,
                size: 25,
              ),
            ),
            centerTitle: false,
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
              controller.page = 1;
              controller.showLoadMore = true;
              controller.fetchGuestInformationHistory();
              if (commonService.guestInformationData.value.data.isNotEmpty) {
                controller.scrollController.value
                    .removeListener(controller.guestScrollListener);
              }
              Get.back();
              return Future.value(true);
            },
            child: Obx(
              () => SingleChildScrollView(
                controller: controller.scrollController.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.forUser.value
                        ? commonService.labelData.value.data.history.text.center
                            .textStyle(
                              headline2().copyWith(
                                color: Get.theme.indicatorColor,
                              ),
                            )
                            .make()
                            .pOnly(bottom: 15)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonService.labelData.value.data.guestsEntered
                                  .text.center
                                  .textStyle(
                                    headline2().copyWith(
                                      color: Get.theme.indicatorColor,
                                    ),
                                  )
                                  .make(),
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
                              ),
                            ],
                          ).pOnly(bottom: 10),
                    if (commonService
                        .guestInformationData.value.data.isNotEmpty)
                      ...commonService.guestInformationData.value.data
                          .mapIndexed((currentValue, index) {
                        return InkWell(
                          onTap: () {
                            if (currentValue.isScanned == 0) {
                              commonService.qrStatus.value = 3;
                              commonService.qrStatus.refresh();
                              commonService.guestData.value.name =
                                  currentValue.name;
                              commonService.guestData.value.guests =
                                  currentValue.guests;
                              commonService.guestData.value.date =
                                  currentValue.date;
                              commonService.guestData.value.time =
                                  currentValue.time;
                              commonService.guestData.value.qrUrl =
                                  currentValue.qrUrl;
                              commonService.guestData.refresh();
                              Get.toNamed('/qr');
                            }
                          },
                          child: SizedBox(
                            width: Get.width,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Get.theme.highlightColor.withOpacity(
                                    currentValue.isScanned == 1 ? 0.8 : 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Get.theme.indicatorColor.withOpacity(
                                        currentValue.isScanned == 1
                                            ? 0.2
                                            : 0.5),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                headline4()
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
                                                headline4()
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
                                                  color:
                                                      Get.theme.indicatorColor,
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
                                                headline4()
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
                                                headline4()
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
                                                  color:
                                                      Get.theme.indicatorColor,
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
                                              Get.textTheme.bodyMedium!.copyWith(
                                                color: Get.theme.indicatorColor,
                                              ),
                                            )
                                            .make(),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Row(
                                      children: [
                                        currentValue.isScanned == 0
                                            ? SvgPicture.asset(
                                                "assets/images/pending.svg",
                                                // color: Get.theme.indicatorColor,
                                              ).pOnly(right: 5)
                                            : Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                        currentValue.isScanned == 0
                                            ? InkWell(
                                                onTap: () {
                                                  AwesomeDialog(
                                                    dialogBackgroundColor: Get
                                                        .theme
                                                        .colorScheme
                                                        .primary,
                                                    context: Get.context!,
                                                    animType: AnimType.scale,
                                                    dialogType:
                                                        DialogType.question,
                                                    body: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10,
                                                              left: 5,
                                                              right: 5),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          commonService
                                                              .labelData
                                                              .value
                                                              .data
                                                              .delete
                                                              .text
                                                              .center
                                                              .textStyle(headline1()
                                                                  .copyWith(
                                                                      color: Get
                                                                          .theme
                                                                          .highlightColor,
                                                                      fontSize:
                                                                          25))
                                                              .make()
                                                              .centered()
                                                              .pOnly(
                                                                  bottom: 10),
                                                          commonService
                                                              .labelData
                                                              .value
                                                              .data
                                                              .deleteRequestDesc
                                                              .text
                                                              .center
                                                              .textStyle(bodyText1
                                                                  .copyWith(
                                                                      color: Get
                                                                          .theme
                                                                          .highlightColor))
                                                              .make()
                                                              .centered()
                                                              .pOnly(
                                                                  bottom: 20),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () =>
                                                                      Get.back(),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Get
                                                                          .theme
                                                                          .highlightColor,
                                                                    ),
                                                                    child: commonService
                                                                        .labelData
                                                                        .value
                                                                        .data
                                                                        .cancel
                                                                        .text
                                                                        .size(
                                                                            18)
                                                                        .center
                                                                        .color(Get
                                                                            .theme
                                                                            .indicatorColor)
                                                                        .make()
                                                                        .centered()
                                                                        .pSymmetric(
                                                                            h: 10,
                                                                            v: 10),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Get.back();
                                                                    controller.deleteGuestInformation(
                                                                        currentValue
                                                                            .id);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Get
                                                                          .theme
                                                                          .colorScheme
                                                                          .secondary,
                                                                    ),
                                                                    child: commonService
                                                                        .labelData
                                                                        .value
                                                                        .data
                                                                        .delete
                                                                        .text
                                                                        .size(
                                                                            18)
                                                                        .center
                                                                        .color(Get
                                                                            .theme
                                                                            .highlightColor)
                                                                        .make()
                                                                        .centered()
                                                                        .pSymmetric(
                                                                            h: 10,
                                                                            v: 10),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ).show();
                                                },
                                                child: Icon(
                                                  Icons.delete_forever_rounded,
                                                  color: Get.theme.colorScheme
                                                      .primary,
                                                  size: 22,
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ],
                              ).pSymmetric(h: 15, v: 15),
                            ),
                          ).pOnly(bottom: 15),
                        );
                      }).toList()
                    else
                      SizedBox(
                        child: "No any history"
                            .text
                            .center
                            .textStyle(Get.theme.textTheme.bodyMedium!
                                .copyWith(color: Get.theme.indicatorColor))
                            .make()
                            .centered(),
                      )
                  ],
                ).pOnly(bottom: 60, left: 20, right: 20),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavWidget(onTap: (int index) async {
            Helper.onBottomBarClick(controller, index);
          }),
          floatingActionButton: SpeedDialWidget(),
        ),
      ),
    );
  }
}
