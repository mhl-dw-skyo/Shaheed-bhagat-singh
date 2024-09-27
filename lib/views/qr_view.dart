import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core.dart';

class QRView extends GetView<GuestController> {
  QRView({Key? key}) : super(key: key);
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
                commonService.qrStatus.value = 3;
                commonService.qrStatus.refresh();
                controller.page = 1;
                controller.showLoadMore = true;
                controller.fetchGuestInformationHistory();
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
              commonService.qrStatus.value = 3;
              commonService.qrStatus.refresh();
              controller.fetchGuestInformationHistory();
              Get.back();
              return Future.value(true);
            },
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height * 0.28,
                      width: Get.width,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage("assets/images/qr_bg.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: commonService
                          .labelData.value.data.qrcodeEntryPoint.text.center
                          .textStyle(
                            Get.textTheme.headline1!.copyWith(
                              color: Get.theme.colorScheme.primary,
                            ),
                          )
                          .make()
                          .centered()
                          .pSymmetric(h: 20),
                    ).pSymmetric(h: 40),
                    Container(
                      height: Get.height * 0.55,
                      width: Get.width,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage("assets/images/qr_bg2.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          commonService
                              .labelData.value.data.virastEKhalsa.text.center
                              .textStyle(
                                Get.textTheme.headline1!.copyWith(
                                  color: Get.theme.highlightColor,
                                  fontSize: 25,
                                ),
                              )
                              .make()
                              .centered()
                              .pSymmetric(h: 20)
                              .pOnly(bottom: 10),
                          commonService.qrStatus.value != 0 &&
                                  commonService.qrStatus.value != 2
                              ? Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: Get.theme.primaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Get.theme.indicatorColor
                                                .withOpacity(0.2),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child:
                                                    "${commonService.labelData.value.data.numberOfGuests}: "
                                                        .text
                                                        .textStyle(
                                                          Get.textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                            color: Get.theme
                                                                .indicatorColor,
                                                          ),
                                                        )
                                                        .make(),
                                              ),
                                              Expanded(
                                                child: commonService
                                                    .guestData.value.guests.text
                                                    .textStyle(
                                                      Get.textTheme.headline4!
                                                          .copyWith(
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                    )
                                                    .make(),
                                              )
                                            ],
                                          ).pOnly(bottom: 8),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child:
                                                    "${commonService.labelData.value.data.name}: "
                                                        .text
                                                        .textStyle(
                                                          Get.textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                            color: Get.theme
                                                                .indicatorColor,
                                                          ),
                                                        )
                                                        .make(),
                                              ),
                                              Expanded(
                                                child: commonService
                                                    .guestData.value.name.text
                                                    .textStyle(
                                                      Get.textTheme.headline4!
                                                          .copyWith(
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                    )
                                                    .make(),
                                              )
                                            ],
                                          ).pOnly(bottom: 8),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child:
                                                    "${commonService.labelData.value.data.date}: "
                                                        .text
                                                        .textStyle(
                                                          Get.textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                            color: Get.theme
                                                                .indicatorColor,
                                                          ),
                                                        )
                                                        .make(),
                                              ),
                                              Expanded(
                                                child:
                                                    "${commonService.guestData.value.date} ${commonService.guestData.value.time}"
                                                        .text
                                                        .textStyle(
                                                          Get.textTheme
                                                              .headline4!
                                                              .copyWith(
                                                            color: Get
                                                                .theme
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                        )
                                                        .make(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ).pSymmetric(h: 10, v: 20))
                                  .pSymmetric(h: 30)
                                  .pOnly(bottom: 20)
                              : "${commonService.qrStatus.value == 2 ? commonService.labelData.value.data.qrExpired : commonService.labelData.value.data.qrWrong}"
                                  .text
                                  .center
                                  .textStyle(
                                    Get.textTheme.headline1!.copyWith(
                                      color: Get.theme.highlightColor,
                                      fontSize: 22,
                                    ),
                                  )
                                  .make()
                                  .centered()
                                  .pSymmetric(h: 10, v: 20),
                          commonService.qrStatus.value == 3
                              ? Image.network(
                                  commonService.guestData.value.qrUrl,
                                  width: 120)
                              : SvgPicture.asset(
                                  commonService.qrStatus.value == 1
                                      ? "assets/images/check.svg"
                                      : "assets/images/wrong.svg",
                                  color: Get.theme.highlightColor,
                                  width: 120,
                                )
                        ],
                      ).pSymmetric(v: 15),
                    ).pSymmetric(h: 40),
                    SizedBox(height: 50,)
                  ],
                ).pSymmetric(h: 10),
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
    );
  }
}
