import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:punjab_tourism/utils.dart';
// import 'package:upgrader/upgrader.dart';

import '../../core.dart';

class TrailViewWidget extends StatelessWidget {
  final double width;
  final double height;
  final LocationListing attributes;
  final bool showTitle;
  final bool showVideoIcon;
  final bool bigSize;
  final VoidCallback onTap;
  const TrailViewWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.attributes,
     required this.showTitle,
    required this.showVideoIcon,
    required this.bigSize,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 200),
        child: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
            ),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Get.theme.indicatorColor.withOpacity(0.2),
                    blurRadius: 5.0,
                    offset: const Offset(0, 2.5),
                    spreadRadius: 0,
                  ),
                ],
                color: Get.theme.highlightColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    attributes.title.text
                        .textStyle(
                          headline2().copyWith(
                            color: Get.theme.indicatorColor,
                            fontSize: bigSize ? 20 : 16,
                          ),
                        )
                        .make()
                        .pOnly(left: 60, bottom: 10),
                    attributes.description.text.ellipsis
                        .minFontSize(bigSize ? 18 : 14)
                        .maxLines(bigSize ? 2 : 3)
                        .textStyle(
                          headline1().copyWith(
                            color: Get.theme.indicatorColor.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                        .make()
                        .pOnly(left: 60, right: 15)
                  ],
                ).pSymmetric(v: 20),
              ),
            ).pOnly(left: 70, right: 20),
            Positioned(
              bottom: 0,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: AnimatedContainer(
                  width: bigSize ? 120 : 95,
                  height: bigSize ? 120 : 95,
                  duration: const Duration(milliseconds: 200),
                  child: Image.asset(
                    Helper.localAssetPath(attributes.imagePath),
                    fit: BoxFit.cover,
                    width: bigSize ? 120 : 95,
                    height: bigSize ? 120 : 95,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset(
                        Helper.localAssetPath(attributes.imagePath),
                        width: bigSize ? 120 : 95,
                        height: bigSize ? 120 : 95,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ).centered(),
            ),
          ],
        ).pOnly(top: 40, bottom: 10, left: 10),
      ),
    );
  }
}
