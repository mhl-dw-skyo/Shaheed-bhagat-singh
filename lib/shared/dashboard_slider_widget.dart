import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../core.dart';

class DashboardSliderWidget extends StatelessWidget {
  final List<Attributes> attributes;
  var selectedIndex = 2.obs;
  DashboardSliderWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);
  YoutubePlayerController? controller;
  var youTubeId = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        height: 330,
        child: Stack(
          children: [
            ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: attributes.elementAt(selectedIndex.value).attributeTypes.length,
                itemBuilder: (context, ind) {
                  Attributes attributesData = attributes.elementAt(selectedIndex.value).attributeTypes.elementAt(ind);
                  return InkWell(
                    onTap: () {
                      if (attributes.elementAt(selectedIndex.value).type == "V") {
                        final id = Helper.convertUrlToId(attributesData.link);
                        String thumb = "https://img.youtube.com/vi/$id/0.jpg";
                        controller = YoutubePlayerController(
                          initialVideoId: id!,
                          params: YoutubePlayerParams(
                            autoPlay: true,
                            startAt: Duration(seconds: 0),
                            showControls: true,
                            showFullscreenButton: true,
                            loop: false,
                            strictRelatedVideos: false,
                            enableJavaScript: false,
                            playsInline: false,
                            desktopMode: true,
                          ),
                        );
                        controller?.onEnterFullscreen = () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                        };
                        controller?.onExitFullscreen = () {
                          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                          Future.delayed(const Duration(seconds: 1), () {
                            controller?.play();
                          });
                          Future.delayed(const Duration(seconds: 5), () {
                            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                          });
                        };
                        Get.to(
                          Scaffold(
                            appBar: AppBar(
                              bottomOpacity: 0,
                              shadowColor: Colors.transparent,
                              foregroundColor: Get.theme.indicatorColor,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              automaticallyImplyLeading: true,
                              centerTitle: true,
                              title: "360 Video".text.textStyle(Get.textTheme.headline1!.copyWith(color: Get.theme.indicatorColor)).make(),
                            ),
                            backgroundColor: Get.theme.primaryColor,
                            body: InkWell(
                              onTap: () async {
                                youTubeId.value = id!;
                                if (Platform.isIOS) {
                                  if (await canLaunchUrlString(attributesData.link)) {
                                    await launch(attributesData.link, forceSafariVC: false);
                                  }
                                } else {
                                  controller?.play();
                                  controller?.hideTopMenu();
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: youTubeId.value != id
                                        ? Stack(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                child: CachedNetworkImage(
                                                  imageUrl: thumb,
                                                  placeholder: (context, url) => Center(
                                                    child: Image.asset(
                                                      'assets/images/loading.gif',
                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.width,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.play_circle_outline,
                                                    size: 40,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : YoutubePlayerIFrame(
                                            controller: controller,
                                            aspectRatio: 16 / 9,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (attributes.elementAt(selectedIndex.value).type == "I" && attributesData.locationId == 0) {
                        Get.to(
                          Scaffold(
                            appBar: AppBar(
                              bottomOpacity: 0,
                              shadowColor: Colors.transparent,
                              foregroundColor: Get.theme.indicatorColor,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              automaticallyImplyLeading: true,
                              centerTitle: true,
                              title: "Picture".text.textStyle(Get.textTheme.headline1!.copyWith(color: Get.theme.indicatorColor)).make(),
                            ),
                            backgroundColor: Get.theme.primaryColor,
                            body: Container(
                              width: Get.width,
                              height: Get.height,
                              color: Get.theme.primaryColor,
                              child: PhotoView(
                                backgroundDecoration: BoxDecoration(
                                  color: Get.theme.primaryColor,
                                ),
                                enableRotation: true,
                                imageProvider: AssetImage(
                                  Helper.localAssetPath(attributesData.imagePath),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        if (attributesData.locationId > 0) {
                          CommonService commonService = Get.find();
                          commonService.sameCategoryBeacons.value = [];
                          commonService.sameCategoryBeacons.refresh();
                          DetailController detailController = Get.find();
                          detailController.getLocationDetailData(attributesData.locationId);
                          Get.toNamed('/detail');
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        BirdViewWidget(
                          showVideoIcon: attributes.elementAt(selectedIndex.value).type == "V" ? true : false,
                          showTitle: false,
                          width: Get.width * 0.5,
                          height: 300,
                          attributes: attributesData,
                        ).pOnly(left: ind == 0 ? 70 : 0),
                        Container(
                            width: Get.width * 0.5,
                            height: 300,
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(50),
                              ),
                            )).pOnly(left: ind == 0 ? 70 : 0),
                        Positioned(
                          top: 30,
                          left: ind == 0 ? 90 : 20,
                          child: attributes.elementAt(selectedIndex.value).type == "I" && attributesData.locationId > 0
                              ? SizedBox(
                                  width: Get.width * 0.5,
                                  height: 300,
                                  child: attributesData.title.text
                                      .textStyle(
                                        Get.textTheme.headline2!.copyWith(
                                          color: Get.theme.highlightColor,
                                        ),
                                      )
                                      .make()
                                      .pOnly(right: 10))
                              : const SizedBox(
                                  height: 0,
                                ),
                        )
                      ],
                    ),
                  );
                }),
            SizedBox(
              width: Get.width * 0.15,
              height: 330,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: attributes.mapIndexed((currentValue, index) {
                  return InkWell(
                    onTap: () {
                      selectedIndex.value = index;
                      selectedIndex.refresh();
                    },
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: currentValue.title.text
                          .textStyle(
                            Get.textTheme.headline3!.copyWith(
                              color: Get.theme.indicatorColor.withOpacity(selectedIndex.value == index ? 1 : 0.5),
                            ),
                          )
                          .make(),
                    ),
                  );
                }).toList(),
              ),
            ).pOnly(bottom: 20),
          ],
        ),
      ),
    );
  }
}
