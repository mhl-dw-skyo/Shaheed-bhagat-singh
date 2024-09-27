import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core.dart';

class BirdViewWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Attributes attributes;
  final bool showTitle;
  final bool showVideoIcon;
  final VoidCallback? onTap;
  const BirdViewWidget({
    Key? key,
    this.width,
    this.height,
    required this.attributes,
    required this.showTitle,
    required this.showVideoIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: showTitle
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
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
                    child: Image.asset(
                      Helper.localAssetPath(attributes?.imagePath??''),
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/loading.gif',
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ).pOnly(bottom: 5),
                attributes.title.text
                    .textStyle(
                      Get.textTheme.headline3!.copyWith(
                        color: Get.theme.indicatorColor,
                      ),
                    )
                    .shadow(1, 1, 5, Get.theme.highlightColor)
                    .make()
              ],
            ).pOnly(right: 20)
          : Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
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
                    child: Image.asset(
                      Helper.localAssetPath(attributes.imagePath),
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/loafing.gif',
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  top: 0,
                  child: showVideoIcon
                      ? Icon(
                          Icons.play_circle_outline,
                          color: Get.theme.highlightColor,
                          size: 60,
                        ).centered()
                      : const SizedBox(
                          height: 0,
                        ),
                )
              ],
            ).pOnly(right: 20),
    );
  }
}
