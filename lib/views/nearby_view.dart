import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:punjab_tourism/utils.dart';
import '../core.dart';

class NearByView extends GetView<NearByController> {

  NearByView({Key? key}) : super(key: key){
    controller.onInit();
  }
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
                onPressed: () => Get.back(),
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
                  commonService.labelData.value.data.nearBy.text
                      .textStyle(
                        headline1().copyWith(
                          color: Get.theme.indicatorColor,
                          fontSize: 28,
                        ),
                      )
                      .make(),
                  const SizedBox(
                    height: 10,
                  ),
                  commonService.labelData.value.data.selectLangDesc.text
                      .textStyle(
                        bodyText1.copyWith(
                          color: Get.theme.indicatorColor.withOpacity(0.5),
                          fontSize: 18,
                        ),
                      )
                      .make()
                      .pOnly(bottom: 30),
                  Row(
                    children: [
                      Expanded(
                        child: !controller.isSwap.value
                            ? Obx(
                                () => InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<DirectionModel>(
                                      isExpanded: true,
                                      hint: Text(
                                        commonService.labelData.value.data.from,
                                        style: TextStyle(
                                            color: Get.theme.indicatorColor
                                                .withOpacity(0.5)),
                                      ),
                                      style: TextStyle(
                                          color: Get.theme.indicatorColor),
                                      value:
                                          controller.firstSelected.value.name ==
                                                  ""
                                              ? null
                                              : controller.firstSelected.value,
                                      items: controller.directions
                                          .map((DirectionModel value) {
                                        return DropdownMenuItem<DirectionModel>(
                                          value: value,
                                          child: Text(
                                            value.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (DirectionModel? newValue) {
                                        // controller.distance.value = "";
                                        // controller.distance.refresh();
                                        if (newValue?.id == 2) {
                                          controller.loader.value = true;
                                          controller.loader.refresh();
                                          controller.getUserLocation('from');
                                        } else {
                                          controller.fromLat.value = 31.2341507;
                                          controller.fromLat.refresh();
                                          controller.fromLng.value = 76.5075326;
                                          controller.fromLng.refresh();
                                          if (controller.fromLat.value != 0.0 &&
                                              controller.fromLng.value != 0.0 &&
                                              controller.toLat.value != 0.0 &&
                                              controller.toLng.value != 0.0) {
                                            controller.calculateDistance(
                                                controller.fromLat.value,
                                                controller.fromLng.value,
                                                controller.toLat.value,
                                                controller.toLng.value);
                                          }
                                        }
                                        controller.firstSelected.value =
                                            newValue!;
                                        controller.firstSelected.refresh();
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Obx(
                                () => InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<NearByItem>(
                                      isExpanded: true,
                                      hint: Text(
                                        commonService.labelData.value.data.from,
                                        style: TextStyle(
                                            color: Get.theme.indicatorColor
                                                .withOpacity(0.5)),
                                      ),
                                      style: TextStyle(
                                          color: Get.theme.indicatorColor),
                                      value: controller
                                                  .secondSelected.value.title ==
                                              ""
                                          ? null
                                          : controller.secondSelected.value,
                                      items: commonService.nearByData.value.data
                                          .map((NearByItem value) {
                                        return DropdownMenuItem<NearByItem>(
                                          value: value,
                                          child: Text(
                                            value.title,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (NearByItem? data) {
                                        // controller.distance.value = "";
                                        // controller.distance.refresh();
                                        controller.selectedDropDown.value =
                                            data!;
                                        controller.selectedDropDown.refresh();
                                        controller.fromLat.value =
                                            double.parse(data?.latitude??'0');
                                        controller.fromLat.refresh();
                                        print("KAKAKAK");
                                        print(controller.fromLat.value);
                                        controller.fromLng.value =
                                            double.parse(data?.longitude??'0');
                                        controller.fromLng.refresh();
                                        if (controller.fromLat.value != 0.0 &&
                                            controller.fromLng.value != 0.0 &&
                                            controller.toLat.value != 0.0 &&
                                            controller.toLng.value != 0.0) {
                                          controller.calculateDistance(
                                              controller.fromLat.value,
                                              controller.fromLng.value,
                                              controller.toLat.value,
                                              controller.toLng.value);
                                        }
                                        controller.secondSelected.value = data;
                                        controller.secondSelected.refresh();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.firstSelected.value.name = "";
                          controller.firstSelected.refresh();
                          controller.secondSelected.value.title = "";
                          controller.secondSelected.refresh();
                          controller.toLat.value = 0.0;
                          controller.toLat.refresh();
                          controller.toLng.value = 0.0;
                          controller.toLng.refresh();
                          controller.fromLat.value = 0.0;
                          controller.fromLat.refresh();
                          controller.fromLng.value = 0.0;
                          controller.fromLng.refresh();
                          controller.selectedDropDown.value = NearByItem();
                          controller.selectedDropDown.refresh();
                          controller.isSwap.value = !controller.isSwap.value;
                          controller.isSwap.refresh();
                        },
                        child: Image.asset(
                          "assets/images/arrow.png",
                          width: 40,
                          height: 40,
                        ).pSymmetric(h: 15),
                      ),
                      Expanded(
                        child: !controller.isSwap.value
                            ? Obx(
                                () => InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<NearByItem>(
                                      isExpanded: true,
                                      hint: Text(
                                        commonService.labelData.value.data.to,
                                        style: TextStyle(
                                            color: Get.theme.indicatorColor
                                                .withOpacity(0.5)),
                                      ),
                                      style: TextStyle(
                                          color: Get.theme.indicatorColor),
                                      value: controller
                                                  .secondSelected.value.title ==
                                              ""
                                          ? null
                                          : controller.secondSelected.value,
                                      items: commonService.nearByData.value.data
                                          .map((NearByItem value) {
                                        return DropdownMenuItem<NearByItem>(
                                          value: value,
                                          child: Text(
                                            value.title,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (NearByItem? data) {
                                        // controller.distance.value = "";
                                        // controller.distance.refresh();
                                        controller.selectedDropDown.value =
                                            data!;
                                        controller.selectedDropDown.refresh();
                                        print(data.latitude);
                                        controller.toLat.value =
                                            double.parse(data.latitude);
                                        controller.toLat.refresh();
                                        controller.toLng.value =
                                            double.parse(data.longitude);
                                        controller.toLng.refresh();
                                        print(controller.fromLat.value);
                                        if (controller.fromLat.value != 0.0 &&
                                            controller.fromLng.value != 0.0 &&
                                            controller.toLat.value != 0.0 &&
                                            controller.toLng.value != 0.0) {
                                          controller.calculateDistance(
                                              controller.fromLat.value,
                                              controller.fromLng.value,
                                              controller.toLat.value,
                                              controller.toLng.value);
                                        }
                                        controller.secondSelected.value = data;
                                        controller.secondSelected.refresh();
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Obx(
                                () => InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<DirectionModel>(
                                      isExpanded: true,
                                      hint: Text(
                                        commonService.labelData.value.data.to,
                                        style: TextStyle(
                                            color: Get.theme.indicatorColor
                                                .withOpacity(0.5)),
                                      ),
                                      style: TextStyle(
                                          color: Get.theme.indicatorColor),
                                      value:
                                          controller.firstSelected.value.name ==
                                                  ""
                                              ? null
                                              : controller.firstSelected.value,
                                      items: controller.directions
                                          .map((DirectionModel value) {
                                        return DropdownMenuItem<DirectionModel>(
                                          value: value,
                                          child: Text(
                                            value.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (DirectionModel? newValue) {
                                        // controller.distance.value = "";
                                        // controller.distance.refresh();
                                        if (newValue?.id == 2) {
                                          controller.loader.value = true;
                                          controller.loader.refresh();
                                          controller.getUserLocation('to');
                                        } else {
                                          controller.toLat.value = 31.2341507;
                                          controller.toLat.refresh();
                                          controller.toLng.value = 76.5075326;
                                          controller.toLng.refresh();
                                          if (controller.fromLat.value != 0.0 &&
                                              controller.fromLng.value != 0.0 &&
                                              controller.toLat.value != 0.0 &&
                                              controller.toLng.value != 0.0) {
                                            print(4444);
                                            controller.calculateDistance(
                                                controller.fromLat.value,
                                                controller.fromLng.value,
                                                controller.toLat.value,
                                                controller.toLng.value);
                                          }
                                        }
                                        controller.firstSelected.value =
                                            newValue!;
                                        controller.firstSelected.refresh();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  controller.selectedDropDown.value.title.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              color: Get.theme.highlightColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Get.theme.indicatorColor.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3),
                                  spreadRadius: 2,
                                ),
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        Helper.localAssetPath(
                                          controller
                                              .selectedDropDown.value.image,
                                        ),
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            Helper.localAssetPath(
                                              controller
                                                  .selectedDropDown.value.image,
                                            ),
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ).pOnly(right: 15),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          controller
                                              .selectedDropDown.value.title.text
                                              .textStyle(
                                                headline2()
                                                    .copyWith(
                                                  color:
                                                      Get.theme.indicatorColor,
                                                ),
                                              )
                                              .make()
                                              .pOnly(bottom: 5),
                                          controller.loader.value
                                              ? SizedBox(
                                                  width: 15.0,
                                                  height: 15.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Get
                                                                .theme
                                                                .colorScheme
                                                                .secondary),
                                                  ),
                                                )
                                              : controller.distance.value.text
                                                  .textStyle(
                                                    headline3()
                                                        .copyWith(
                                                      color: Get
                                                          .theme.indicatorColor
                                                          .withOpacity(0.5),
                                                    ),
                                                  )
                                                  .make()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.launchMapsUrl();
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/direction.svg",
                                      width: 35,
                                      height: 35,
                                      color: const Color(0xff0e4da4),
                                    ).pOnly(bottom: 5),
                                    commonService
                                        .labelData.value.data.getDirection.text
                                        .textStyle(
                                          bodyText2.copyWith(
                                            color: Get.theme.indicatorColor,
                                          ),
                                        )
                                        .make()
                                  ],
                                ).objectCenterRight(),
                              )
                            ],
                          ).pSymmetric(h: 10, v: 15),
                        )
                      : const SizedBox(
                          height: 0,
                        )
                ],
              ).pOnly(bottom: 60, left: 20, right: 20),
            ),
          ),

        ),
      ),
    );
  }
}
