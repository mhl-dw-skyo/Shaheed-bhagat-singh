import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:punjab_tourism/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core.dart';

class GuestInformationView extends GetView<GuestController> {
  GuestInformationView({Key? key}) : super(key: key);
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
                  if (commonService
                      .guestInformationData.value.data.isNotEmpty) {
                    controller.scrollController.value
                        .removeListener(controller.guestScrollListener);
                  }
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Get.theme.indicatorColor,
                  size: 25,
                )),
            centerTitle: false,

          ),
          body: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  commonService
                      .labelData.value.data.provideNecessaryInfo.text.center
                      .textStyle(
                        headline1().copyWith(
                          color: Get.theme.indicatorColor,
                          fontSize: 25,
                        ),
                      )
                      .make(),
                  const SizedBox(
                    height: 15,
                  ),
                  commonService.guestInformationData.value.data.isEmpty
                      ? TextFormField(
                          style: TextStyle(
                              color: Get.theme.indicatorColor,
                              fontWeight: FontWeight.w300),
                          keyboardType: TextInputType.text,
                          onChanged: (input) {
                            controller.name.value = input;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: commonService
                                .labelData.value.data.enterYourName,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 0),
                            prefixIcon: Align(
                              widthFactor: 1,
                              heightFactor: 1,
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.person,
                                  size: 20,
                                  color: Get.theme.colorScheme.primary),
                            ),
                            errorStyle: const TextStyle(fontSize: 15),
                            hintStyle: bodyText1.copyWith(
                                color:
                                    Get.theme.indicatorColor.withOpacity(0.3)),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Get.theme.indicatorColor
                                        .withOpacity(0.5))),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Get.theme.indicatorColor
                                        .withOpacity(0.5))),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Get.theme.indicatorColor
                                        .withOpacity(0.5))),
                            errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    width: 1, color: errorColor)),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Get.theme.indicatorColor
                                        .withOpacity(0.5))),
                          ),
                        ).pOnly(bottom: 20)
                      : SizedBox(),
                  TextFormField(
                    style: TextStyle(
                      color: Get.theme.indicatorColor,
                      fontWeight: FontWeight.w300,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (input) {
                      controller.guests.value = input;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of guests'; // Error message for empty input
                      }
                      final int? number = int.tryParse(value);
                      if (number == null || number <= 0) {
                        return 'Please enter a valid number greater than zero'; // Error message for invalid number
                      }
                      if (number > 10) {
                        return 'Number of guests cannot exceed 10'; // Error message for exceeding the limit
                      }
                      return null; // Return null if no validation errors
                    },
                    decoration: InputDecoration(
                      hintText: commonService
                          .labelData.value.data.enterNumberOfGuests,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 0),
                      prefixIcon: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                      errorStyle: const TextStyle(fontSize: 15),
                      hintStyle: Get.theme.textTheme.bodyLarge!.copyWith(
                        color: Get.theme.indicatorColor.withOpacity(0.3),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Get.theme.indicatorColor.withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Get.theme.indicatorColor.withOpacity(0.5),
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Get.theme.indicatorColor.withOpacity(0.5),
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Get.theme.colorScheme.error,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Get.theme.indicatorColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ).pOnly(bottom: 30),
                  InkWell(
                    onTap: () {
                      if (commonService
                          .guestInformationData.value.data.isNotEmpty) {
                        controller.name.value = commonService
                            .guestInformationData.value.data
                            .elementAt(0)
                            .name;
                        controller.name.refresh();
                      }
                      if (controller.guests.value.isNotEmpty &&
                          controller.name.value.isNotEmpty) {
                        if (int.parse(controller.guests.value) > 10) {
                          Fluttertoast.showToast(
                            msg: 'Number of guests cannot exceed 10',
                            backgroundColor: Get.theme.colorScheme.error,
                            gravity: ToastGravity.TOP,
                          );
                        } else
                          controller.saveGuestInformation();
                      } else {
                        Fluttertoast.showToast(
                          msg: commonService.labelData.value.data.fillAboveInfo,
                          backgroundColor: Get.theme.colorScheme.error,
                          gravity: ToastGravity.TOP,
                        );
                      }
                    },
                    child: Container(
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
                      child: commonService.labelData.value.data.submit.text
                          .textStyle(
                            Get.textTheme.bodyLarge!.copyWith(
                              color: Get.theme.highlightColor,
                            ),
                          )
                          .make()
                          .pSymmetric(h: 20, v: 12),
                    ),
                  ).pOnly(bottom: 20),
                  commonService.guestInformationData.value.data.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonService
                                .labelData.value.data.history.text.center
                                .textStyle(
                                  headline4().copyWith(
                                    color: Get.theme.indicatorColor,
                                  ),
                                )
                                .make(),
                            commonService.labelData.value.data.viewAll.text
                                .underline.center
                                .textStyle(
                                  headline5().copyWith(
                                    color: Get.theme.colorScheme.primary,
                                  ),
                                )
                                .make()
                                .onTap(() {
                              if (commonService
                                  .guestInformationData.value.data.isNotEmpty) {
                                controller.scrollController.value
                                    .removeListener(
                                        controller.guestScrollListener);
                              }
                              controller.page = 1;
                              controller.fetchGuestInformationHistory();
                              Get.toNamed('/guest-information-history');
                            })
                          ],
                        ).pOnly(bottom: 10)
                      : SizedBox(),
                  if (commonService.guestInformationData.value.data.isNotEmpty)
                    ...commonService.guestInformationData.value.data
                        .take(5)
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
                              color: Get.theme.highlightColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Get.theme.indicatorColor.withOpacity(
                                      currentValue.isScanned == 1 ? 0.2 : 0.5),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        commonService.labelData.value.data.name
                                            .text.center
                                            .textStyle(
                                              headline4().copyWith(
                                                color: Get
                                                    .theme.colorScheme.primary,
                                              ),
                                            )
                                            .make()
                                            .pOnly(right: 15),
                                        ":"
                                            .text
                                            .center
                                            .textStyle(
                                              headline4().copyWith(
                                                color: Get
                                                    .theme.colorScheme.primary,
                                              ),
                                            )
                                            .make()
                                            .pOnly(right: 15),
                                        currentValue.name.text.center
                                            .textStyle(
                                              Get.textTheme.bodyMedium!.copyWith(
                                                color: Get.theme.indicatorColor,
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
                                              headline4().copyWith(
                                                color: Get
                                                    .theme.colorScheme.primary,
                                              ),
                                            )
                                            .make()
                                            .pOnly(right: 15),
                                        ":"
                                            .text
                                            .center
                                            .textStyle(
                                              headline4().copyWith(
                                                color: Get
                                                    .theme.colorScheme.primary,
                                              ),
                                            )
                                            .make()
                                            .pOnly(right: 15),
                                        currentValue.guests.text.center
                                            .textStyle(
                                              Get.textTheme.bodyMedium!.copyWith(
                                                color: Get.theme.indicatorColor,
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
                                                            .pOnly(bottom: 10),
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
                                                            .pOnly(bottom: 20),
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
                                                                        BorderRadius
                                                                            .circular(5),
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
                                                                      .size(18)
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
                                                                        BorderRadius
                                                                            .circular(5),
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
                                                                      .size(18)
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
                                                color: Get
                                                    .theme.colorScheme.primary,
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
                    }).toList(),
                ],
              ).pOnly(bottom: 60, left: 20, right: 20),
            ),
          ),

        ),
      ),
    );
  }
}
