import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:punjab_tourism/shared/dialog_play_video.dart';
import 'package:punjab_tourism/utils.dart';

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
                itemCount: attributes
                    .elementAt(selectedIndex.value)
                    .attributeTypes
                    .length,
                itemBuilder: (context, ind) {
                  Attributes attributesData = attributes
                      .elementAt(selectedIndex.value)
                      .attributeTypes
                      .elementAt(ind);
                  return InkWell(
                    onTap: () {
                      if (attributes.elementAt(selectedIndex.value).type ==
                          "V") {
                        final id = Helper.convertUrlToId(attributesData.link);
                        String thumb = "https://img.youtube.com/vi/$id/0.jpg";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DialogPlayVideo(
                                    id!, thumb, attributesData.title)));
                      } else if (attributes
                                  .elementAt(selectedIndex.value)
                                  .type ==
                              "I" &&
                          attributesData.locationId == 0) {
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
                              title: "Picture"
                                  .text
                                  .textStyle(headline1().copyWith(
                                      color: Get.theme.indicatorColor))
                                  .make(),
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
                                  Helper.localAssetPath(
                                      attributesData.imagePath),
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
                          detailController
                              .getLocationDetailData(attributesData.locationId);
                          commonService.inMuseum.value = false;
                          Get.toNamed('/detail');
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        BirdViewWidget(
                          showVideoIcon:
                              attributes.elementAt(selectedIndex.value).type ==
                                      "V"
                                  ? true
                                  : false,
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
                          child:
                              attributes.elementAt(selectedIndex.value).type ==
                                          "I" &&
                                      attributesData.locationId > 0
                                  ? SizedBox(
                                      width: Get.width * 0.5,
                                      height: 300,
                                      child: attributesData.title.text
                                          .textStyle(
                                            headline2().copyWith(
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
                            headline3().copyWith(
                              color: Get.theme.indicatorColor.withOpacity(
                                  selectedIndex.value == index ? 1 : 0.5),
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
