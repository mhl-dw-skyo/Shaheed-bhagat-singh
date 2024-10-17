import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../core.dart';
import '../shared/my_icons_icons.dart';

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
                      child: (GetStorage().read('user_type') != "U"
                          ? commonService.labelData.value.data.welcomeTo +
                          "\n" +
                          commonService
                              .labelData.value.data.virastEKhalsa
                          : commonService
                          .labelData.value.data.qrcodeEntryPoint)
                          .text
                          .center
                          .textStyle(
                        Get.textTheme.displayLarge!.copyWith(
                          color: Get.theme.colorScheme.primary,
                          fontSize: 30
                        ),
                      )
                          .make()
                          .centered()
                          .pSymmetric(h: 20),
                    ).pSymmetric(h: 30),
                    Container(
                      height: GetStorage().read('user_type') != "U"
                          ? Get.height * 0.4
                          : Get.height * 0.5,
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
                            Get.textTheme.displayLarge!.copyWith(
                              color: Get.theme.highlightColor,
                              fontSize: 20,
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
                                      Expanded(
                                        child: commonService
                                            .guestData.value.guests.text
                                            .align(TextAlign.end)
                                            .textStyle(
                                          Get.textTheme
                                              .headlineMedium!
                                              .copyWith(
                                            color: Get
                                                .theme
                                                .colorScheme
                                                .primary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600
                                          ),
                                        )
                                            .make(),
                                      )
                                    ],
                                  ).pOnly(bottom: 8),
                                  Row(
                                    children: [
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
                                      Expanded(
                                        child: commonService
                                            .guestData.value.name.text
                                            .align(TextAlign.end)
                                            .textStyle(
                                          Get.textTheme
                                              .headlineMedium!
                                              .copyWith(
                                            color: Get
                                                .theme
                                                .colorScheme
                                                .primary,
                                              fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        )
                                            .make(),
                                      )
                                    ],
                                  ).pOnly(bottom: 8),
                                  Row(
                                    children: [
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
                                      Expanded(
                                        child:
                                        "${commonService.guestData.value.date} ${commonService.guestData.value.time}"
                                            .text
                                        .align(TextAlign.end)
                                            .textStyle(
                                          Get.textTheme
                                              .headlineMedium!
                                              .copyWith(
                                            color: Get
                                                .theme
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
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
                            Get.textTheme.displayLarge!.copyWith(
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
                              width: Get.width * 0.3)
                              : SvgPicture.asset(
                            commonService.qrStatus.value == 1
                                ? "assets/images/check.svg"
                                : "assets/images/wrong.svg",
                            color: Get.theme.highlightColor,
                            width: Get.width * 0.2,
                          )
                        ],
                      ).pSymmetric(v: 15),
                    ).pSymmetric(h: 40),
                    SizedBox(
                      height: 20,
                    ),
                    GetStorage().read('user_type') != "U"
                        ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFF37311), // Color #F37311
                              Color(0xFFEB9813), // Color #EB9813
                            ],
                            begin: Alignment
                                .topLeft, // Start the gradient from the top-left
                            end: Alignment
                                .bottomRight, // End the gradient at the bottom-right
                          ),
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                '#ff6666',
                                'Cancel',
                                true,
                                ScanMode.BARCODE);
                            if (barcodeScanRes.isNotEmpty &&
                                controller != null) {
                              controller.scanQR(barcodeScanRes);
                            }
                          },
                          icon: Icon(
                            MyIcons
                                .barcode, // Choose the icon you want to use
                            color: Get.theme
                                .primaryColor, // Match the icon color with the text color
                          ),
                          label:
                          "${commonService.labelData.value.data.scanNextQr}: "
                              .text
                              .textStyle(
                            Get.textTheme.bodyMedium!.copyWith(
                              color: Get.theme.primaryColor,
                            ),
                          )
                              .make(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                          ),
                        ))
                        : SizedBox(
                      height: 50,
                    )
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
